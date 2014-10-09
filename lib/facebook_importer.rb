class FacebookImporter
  def initialize(token = nil)
    @user = User.find_by_facebook_token(token) if token
    @graph = @user ? @user.facebook_graph : Facebook.graph
  end

  def import_locale(data)
    puts @user.inspect
    
    venues = data['venues'] || []
    people = data['people'] || []
    venue_other_ids = data['venue_other_ids'] || []

    import_venues(venues, venue_other_ids)
    import_people(people)
    
    Venue.all.each {|v| v.import_facebook_events(@graph) }
    
    if @user
      @user.person.import_facebook_events
    end
  end

  def import_venues(venue_ids = [], venue_other_ids = {})
    import_objects venue_ids do |venue_graph|
      puts "Importing venue #{venue_graph['id']}"
      
      venue = Venue.find_or_initialize_by(facebook_id: venue_graph['id'].to_i)
    
      venue.assign_facebook_attributes(venue_graph)
      
      other_ids_for = venue_other_ids[venue.facebook_id] || []
      other_ids_for.each do |id|
        venue.facebook_ids ||= []
        venue.facebook_ids << id unless venue.facebook_ids.include?(id)
      end
      
      venue.save
      venue
    end
  end
  
  def import_objects(ids = [], &block)
    ids = [*ids]
    
    objects = @graph.batch do |batch|
      ids.each { |id| batch.get_object id }
    end
    
    result = objects.map(&block)
    result.one? ? result.first : result
  end

  def import_people(people_ids = [])
    import_objects people_ids do |person_graph|
      puts "Importing person #{person_graph['id']}"
      person = Person.find_or_initialize_by(facebook_id: person_graph['id'.to_i])
    
      person.assign_facebook_attributes person_graph
      person.is_public = true
      person.save
    
      person
    end
  end
end