desc "Import the list of seeds in config/seeds.yml"
task :import => :environment do
  seeds_path = File.join(Rails.root, 'config', 'seeds.yml')
  seeds = YAML.load_file(seeds_path)

  locales = seeds['locales']

  locales.each do |locale, value|
    Import.import_locale(value)
  end
end

module Import
  def self.facebook_graph
    facebook_secrets = Rails.application.secrets['facebook']
    facebook_oauth = Koala::Facebook::OAuth.new(facebook_secrets['app_id'], facebook_secrets['secret'])
    access_token = facebook_oauth.get_app_access_token
    Koala::Facebook::API.new(access_token)
  end

  def self.import_locale(data)
    venues = data['venues'] || []
    people = data['people'] || []

    puts "Importing #{venues.count} venues and #{people.count} people."

    venues.each {|v| import_venue(v) }
    people.each {|p| import_person(p) }
  end

  def self.import_venue(v)
    puts "Importing venue with Id #{v}"

    venue = Venue.find_or_initialize_by(facebook_id: v)

    venue_object = facebook_graph.get_object(v)
    puts venue_object.inspect
  end

  def self.import_person(p)
    puts "Importing person with Id #{p}"

    person = Person.find_or_initialize_by(facebook_id: p)
  end
end