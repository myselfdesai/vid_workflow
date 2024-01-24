require 'aws-sdk-s3'

def s3_write(local_dir, aws_config)
  s3 = Aws::S3::Client.new(
    region: aws_config["Region"],
    access_key_id: aws_config["Access"]["key_id"],
    secret_access_key: aws_config["Access"]["secret_key"]
  )

  Dir.glob(File.join(local_dir, '*')).each do |local_file_path|
    file_name = File.basename(local_file_path)
    local_file_size = File.size(local_file_path)
    bucket = aws_config["S3"]["bucket"]
    key = "#{aws_config["S3"]["storage_dir"]}/#{file_name}"
    puts "key: #{key}"

    # Write file to S3
    s3.put_object(
      bucket: bucket,
      key: key,
      body: File.open(local_file_path, 'rb')
    )
    puts "\t==>Encoded file '#{file_name}' uploaded to S3 successfully."
  end
end