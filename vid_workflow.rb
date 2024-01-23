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
  puts "\nworkflow_configs: #{workflow_configs}"
  create_directory(workflow_configs["Disk"]["storage_dir"])
  ftp_read(workflow_configs["FTP"], workflow_configs["Disk"])

  validate_source_files(workflow_configs["Disk"]["storage_dir"])

  create_directory(workflow_configs["Disk"]["encoded_dir"])
  rename_source_files(workflow_configs["Disk"]["storage_dir"])
  transcode_vod_files(workflow_configs["Profiles"], workflow_configs["Disk"]["storage_dir"], workflow_configs["Disk"]["encoded_dir"])
  s3_write(workflow_configs["Disk"]["encoded_dir"], workflow_configs["AWS"])
end
