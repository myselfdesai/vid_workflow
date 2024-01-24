require './clean_disk'
require './read_files'
require './write_files'
require './prepare_package'
require './encode_workflow'
require 'yaml'

def validate_source_files(source_file_dir)
  Dir.glob(File.join(source_file_dir, '*')).each do |file|
    puts "\nvalidating source_file: #{file}"
    result = system("ffprobe #{file}")
    puts "\t==> Source file is valid? #{result}"

    # Delete corrupted source file, so that transcoding can be skipped
    File.delete(file) unless result
  end
end

begin
  workflow_configs = YAML.load_file('./config.yaml')

  # Ensure local directory for FTP download is ready
  create_directory(workflow_configs["Disk"]["storage_dir"])

  # Download Files from FTP
  ftp_read(workflow_configs["FTP"], workflow_configs["Disk"])

  # Validate source files and delete corrupt/partial-uploads
  validate_source_files(workflow_configs["Disk"]["storage_dir"])

  # Create local directory for storing transcoded output files.
  create_directory(workflow_configs["Disk"]["encoded_dir"])

  # Rename downloaded source files to remove 'ID'
  rename_source_files(workflow_configs["Disk"]["storage_dir"])

  # Transcode downloaded files to given profiles
  transcode_vod_files(workflow_configs["Profiles"], workflow_configs["Disk"]["storage_dir"], workflow_configs["Disk"]["encoded_dir"])

  # Upload
  s3_write(workflow_configs["Disk"]["encoded_dir"], workflow_configs["AWS"])

  # Delete all source and encoded files to keep disk clean for new operations
  delete_directory(workflow_configs["Disk"]["encoded_dir"])
  delete_directory(workflow_configs["Disk"]["encoded_dir"])
end
