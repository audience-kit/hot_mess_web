unless Rails.logger
  Rails.logger            = Logger.new(STDOUT)
end

Rails.logger.level      = Logger::INFO
  
namespace :facebook do
  desc 'Gets an object from the Facebook graph API and caches it to the spec/fixtures directory'
  task :fixture, [ :token, :path ] => :environment do |task, args|
    path = File.join(Rails.root, "spec/fixtures/#{args[:path]}.json")
    
    graph = Koala::Facebook::API.new(args[:token])
    
    File.write(path, graph.to_json)
  end
  
  desc 'Reloads pictures for Facebook objects'
  task :pictures, [ :token ] => :environment do |task, args|
    graph = args[:token] ? Koala::Facebook::API.new(args[:token]) : nil
    
    Venue.each { |v| v.update_facebook_pictures graph }
    Person.each { |p| p.update_facebook_pictures graph }
  end
  
  desc 'Makes the Facebook user Id an administrator'
  task :admin, [ :id ] => :environment do |task, args|
    person = Person.find_by_facebook_id args[:id]
    
    person.user.is_admin = true
    person.user.save
  end
end