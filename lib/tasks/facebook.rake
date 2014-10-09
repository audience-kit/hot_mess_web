
namespace :facebook do
  desc 'Gets an object from the Facebook graph API and caches it to the spec/fixtures directory'
  task :fixture, [ :token, :path ] => :environment do |task, args|
    path = File.join(Rails.root, "spec/fixtures/#{args[:path]}.json")
    
    graph = Koala::Facebook::API.new(args[:token])
    
    File.write(path, graph.to_json)
  end
end