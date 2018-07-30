# NOTE: Basically we do not want to preload all models if we are running a rake
# task such as a migration because it tries to load tables even if they do not
# exists causing exceptions.
unless (File.basename($0) == 'rake' && ARGV.join =~ /db/)
  model_names = Dir.glob("./app/models/*.rb").map{|path| path.sub("./app/models/", '').split('.').first }
  model_names.each do |model_name|
    begin
      model_name.camelize.constantize
    rescue
    end
  end
end
