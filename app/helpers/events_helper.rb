module EventsHelper
  def natural_time(date_time)
    if date_time > DateTime.now
      "in #{distance_of_time_in_words_to_now date_time}"
    else
      "#{distance_of_time_in_words_to_now date_time} ago"
    end
  end
end
