# TODO: Figure out a way to not run this while on migrations
# TODO: Does not work
# ObjectSpace.each_object Kribi::Application do |instance|
#   app = instance
# end

# NOTE: Comment below while recreating database
# bundle exec rake db:drop db:create db:migrate db:seed
# Dir.glob("./app/models/*.rb").map{|path| path.sub("./app/models/", '')}.each do |line|
#   model_name = line.split('.').first
#   model_name.camelize.constantize
# end
