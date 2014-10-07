desc "Import the list of seeds in config/seeds.yml"
task :import, [ :token ] => [ :environment ] do |task, args|
  
  logger           = Logger.new(STDOUT)
  logger.level     = Logger::INFO
  Rails.logger     = logger
  
  seeds_path = File.join(Rails.root, 'config', 'seeds.yml')
  seeds = YAML.load_file(seeds_path)

  locales = seeds['locales']

  locales.each do |locale, value|
    importer = FacebookImporter.new
    importer.import_locale(value, args)
  end
end

class FacebookImporter
  def facebook_graph
    unless @app_facebook_client
      facebook_secrets = Rails.application.secrets['facebook']
      facebook_oauth = Koala::Facebook::OAuth.new(facebook_secrets['app_id'], facebook_secrets['secret'])
      access_token = @token || facebook_oauth.get_app_access_token
      @app_facebook_client = Koala::Facebook::API.new(access_token)
    end
    
    @app_facebook_client
  end

  def import_locale(data, args)
    @token = args[:token]
    
    venues = data['venues'] || []
    people = data['people'] || []

    puts "Importing #{venues.count} venues and #{people.count} people."
    
    if @token
      user = facebook_graph.get_object('me')
      puts "Importing in user context #{user['name']}"
    end

    import_venues(venues)
    import_people(people)
    
    Venue.all.each {|v| v.import_facebook_events(self.facebook_graph) }
    
    if @token
      person = import_people [ user['id'].to_i ], true
      
      person.user.facebook_access_token = @token
      person.import_facebook_events
    end
  end

  def import_venues(venue_ids = [])
    import_objects venue_ids do |venue_graph|
      puts "Importing venue #{venue_graph['id']}"
      
      venue = Venue.find_or_initialize_by(facebook_id: venue_graph['id'].to_i)
    
      venue.assign_facebook_attributes(venue_graph)
      venue.save
      
      venue
    end
  end
  
  def import_objects(ids = [], &block)
    ids = [ ids ] unless ids.instance_of? Array
    
    objects = facebook_graph.batch do |batch|
      ids.each { |id| batch.get_object id }
    end
    
    result = objects.map(&block)
    
    return result[0] if result.length == 1
    
    result
  end

  def import_people(people_ids = [], build_user = false)
    import_objects people_ids do |person_graph|
      puts "Importing venue #{person_graph['id']}"
      person = Person.find_or_initialize_by(facebook_id: person_graph['id'.to_i])
    
      person.assign_facebook_attributes(person_graph)
      person.is_public = true
      person.save
    
      person
    end
  end
end