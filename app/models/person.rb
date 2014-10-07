class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable
  
  GENDER_MALE                 = 'male'
  GENDER_FEMALE               = 'female'

  field :name,                type: String
  field :locale,              type: String
  field :timezone,            type: Integer
  field :gender,              type: String
  field :link,                type: String
  field :facebook_verified,   type: Boolean
  field :facebook_likes,      type: Integer
  field :soundcloud_id,       type: Integer
  field :is_public,           type: Boolean,    default: false
  
  belongs_to :user,           autobuild: true
  
  validates_presence_of :name
  
  scope :are_public, ->{ where(is_public: true) }
  
  facebook_map_attributes facebook_id: :id, facebook_verified: :verified, facebook_likes: :likes
  
  def import_facebook_events
    graph = user.facebook_graph
    
    Rails.logger.debug "Loading events for #{name}"
    attending, not_replied, maybe = graph.batch do |batch|
      batch.get_object('/me/events/attending')
      batch.get_object('/me/events/not_replied')
      batch.get_object('/me/events/maybe')
    end
    
    events = attending + not_replied + maybe
    
    Rails.logger.info "Loading details for #{events.length} events"
    events = graph.batch do |batch|
      events.each do |event|
        batch.get_object(event['id'])
      end
    end
    
    open_events = events.each.select {|e| e['privacy'] == 'OPEN'}
    Rails.logger.info "Found #{open_events.count} OPEN events"
    open_events.each do |event|
      if event['venue'] && event['venue']['id']
        puts "Attempting to find Venue #{event['venue']['id']}"
        venue = Venue.find_by_facebook_id event['venue']['id'].to_i

        if venue
          Rails.logger.info "Importing event #{event['name']} for venue #{venue.name}"
          event_model = Event.find_or_initialize_by(facebook_id: event['id'].to_i)
          event_model.venue = venue
          event_model.person = Person.find_or_initialize_by(facebook_id: event['owner']['id'].to_i)
        
          event_model.assign_facebook_attributes event
          event_model.save
        end
      end
    end
  end
end