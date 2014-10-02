class MoveNameFromPersonToUser < Mongoid::Migration
  def self.up
    puts "Migrating #{User.count} users"
    User.each do |user|
      puts "Migrating User #{user.id}"
      user.person.facebook_id   ||= user[:facebook_id]
      user.first_name           ||= user.person[:first_name]
      user.last_name            ||= user.person[:last_name]
      user.middle_name          ||= user.person[:middle_name]
      user.person.is_public     ||= false
      user.unset :facebook_id
      user.person.unset :first_name
      user.person.unset :last_name
      user.person.unset :middle_name
      user[:person_id]          ||= user.person.id
      
      unless user.save
        puts "Validation Error on #{user.id} => #{user.errors.messages}"
        raise
      end
    end
  end
end