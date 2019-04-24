class CalendarapiController < ApplicationController
  KEY_FILE_PATH = Rails.application.credentials[:calendar_api][:key_file]
  GOOGLE_CREDENTIALS = ENV.fetch('GOOGLE_APPLICATION_CREDENTIALS')

  def index

    calendar = Google::Apis::CalendarV3 # Alias the module
    service = calendar::CalendarService.new

    scopes =  ['https://www.googleapis.com/auth/calendar.readonly', 'https://www.googleapis.com/auth/calendar']
    service.authorization = Google::Auth.get_application_default(scopes)
    # token = service.authorization.fetch_access_token!

    emails = ["me@example.com","myboss@example.com"]
    # Create an event, adding any emails listed in the command line as attendees
    # event = Calendar::Event.new(
    #   summary: 'A sample event',
    #   location: '1600 Amphitheatre Parkway, Mountain View, CA 94045',
    #   attendees:  emails.each { |email| Calendar::EventAttendee.new(email: email) },
    #   start: Calendar::EventDateTime.new(date_time: DateTime.parse('2015-12-31T20:00:00')),
    #   end: Calendar::EventDateTime.new(date_time: DateTime.parse('2016-01-01T02:00:00'))
    # )
    # event = service.insert_event('primary', event, send_notifications: true)
    # puts "Created event '#{event.summary}' (#{event.id})"

    # calendar_id = 'getagripmatt@gmail.com'
    calendar_id = 'martin.st8n@gmail.com'
    @response = service.list_events(
        calendar_id,
        max_results: 30,
        single_events: true,
        order_by: 'startTime',
        time_min: Time.now.iso8601
      )
    @free_busy_request_item = calendar::FreeBusyRequestItem.new
    @free_busy_request_item.id = calendar_id

    today = Time.now
    tomorrow = Time.new(today.year, today.mon, today.day + 1)
    start_time = Time.new(tomorrow.year, tomorrow.mon, tomorrow.day, 9)
    end_time = Time.new(tomorrow.year, tomorrow.mon, tomorrow.day, 17)

    @free_busy_request = calendar::FreeBusyRequest.new(
      items: [@free_busy_request_item],
      time_min: start_time.iso8601,
      time_max: end_time.iso8601,
      time_zone: "-0400"
    )

    @free_busy = service.query_freebusy(
      @free_busy_request
    )

    # per day
    #iterate through array busy
      #iterate through per hash
        # if hash duration > 5.5 add to no-available days else
        # add date to available days
        # create new empty slots with
        # ENDday of current plus Start day of next
  end

  private

  def calendar_init
  end

end #controlled end
