def transcode_vod_files(vod_profiles, source_file_dir, encoded_dir)
  puts "\n In vod_profiles: #{vod_profiles}"

  Dir.glob(File.join(source_file_dir, '*')).each do |source_file|
    vod_profiles.each do |vod_profile|
      puts "vod_profile: #{vod_profile}"
      profile_name, specs = vod_profile
      puts specs
      encode_cmd = "ffmpeg -i #{source_file} -b:v #{specs["bitrate"]} -s #{specs["resolution"]} #{encoded_dir}/#{source_file.split("/").last.split(".").first}#{profile_name}.mp4"
      res = system("#{encode_cmd}")
      puts "Transcoded #{source_file} successfully? #{res}"
    end
  end
end