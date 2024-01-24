require 'net/ftp'
require 'net/sftp'

# To download files from FTP server
def ftp_read(ftp_config, disk_config)
  # Connect to FTP server
  Net::FTP.open(
    ftp_config["host"],
    ftp_config["user"],
    ftp_config["password"]
  ) do |ftp|
    ftp.passive = true

    # navigate to remote storage directory
    ftp_config["storage_dir"].split("/").each do |storage_nested_dir|
      ftp.chdir(storage_nested_dir)
    end

    # Download all supported file types to local disk
    ftp_config["file_types"].split(",").each do |file_type|
      ftp.list("*.#{file_type}") do |remote_file|
        remote_filename =  remote_file.split.last
        local_filepath = File.join(disk_config["storage_dir"], remote_filename)
        downloaded_bytes = 0
        file_size = ftp.size(remote_filename)
        puts "\nRemote file: #{remote_filename}, file_size: #{file_size}"

        # Read source files in chunks depending upon network bandwidth
        ftp.getbinaryfile(remote_filename, local_filepath, ftp_config["read_chunk_size"]) do |chunk|
          progress = downloaded_bytes.to_f/file_size.to_f*100.0
          downloaded_bytes = downloaded_bytes + ftp_config["read_chunk_size"]
          puts "\t==> Downloaded #{downloaded_bytes} bytes, Progress: #{progress}"
        end

        puts "\t==> Downloaded file size matches with remote file size? #{File.size(local_filepath) == file_size}"
      end
    end
  end
end

# To download files from sftp server
def sftp_read(sftp_config, disk_config)

end

# To download files from AWS-S3
def s3_read(http_configs, disk_config)

end

# To download files from internal ssl enabled secure URL
def https_read(https_configs, disk_config)

end
