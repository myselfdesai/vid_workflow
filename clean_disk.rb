require 'fileutils'

def create_directory(absolute_path)
  puts "\n in create_directory: #{absolute_path}"
  FileUtils.mkdir_p(absolute_path)
end

def rename_source_files(source_file_dir)
  Dir.glob(File.join(source_file_dir, '*')).each do |file|
    File.rename(file, file.gsub(file.split("/").last.split("_").last.split(".").first, ""))
  end
end