class CalendarapiController < ApplicationController
  KEY_FILE_PATH = Rails.application.credentials[:calendar_api][:key_file]
  GOOGLE_CREDENTIALS = ENV.fetch('GOOGLE_APPLICATION_CREDENTIALS')

  # require 'googleauth'
  # require 'google/apis/calendar_v3'

  def index
    calendar = Google::Apis::CalendarV3::CalendarService.new
    scopes =  ['https://www.googleapis.com/auth/calendar.readonly', 'https://www.googleapis.com/auth/calendar']
    calendar.authorization = Google::Auth.get_application_default(scopes)
    # token = calendar.authorization.fetch_access_token!

    emails = ["me@example.com","myboss@example.com"]
    # Create an event, adding any emails listed in the command line as attendees
    # event = Calendar::Event.new(
    #   summary: 'A sample event',
    #   location: '1600 Amphitheatre Parkway, Mountain View, CA 94045',
    #   attendees:  emails.each { |email| Calendar::EventAttendee.new(email: email) },
    #   start: Calendar::EventDateTime.new(date_time: DateTime.parse('2015-12-31T20:00:00')),
    #   end: Calendar::EventDateTime.new(date_time: DateTime.parse('2016-01-01T02:00:00'))
    # )
    # event = calendar.insert_event('primary', event, send_notifications: true)
    # puts "Created event '#{event.summary}' (#{event.id})"

    calendar_id = 'getagripmatt@gmail.com'
    @response = calendar.list_events(
        calendar_id,
        max_results: 10,
        single_events: true,
        order_by: 'startTime',
        time_min: Time.now.iso8601
      )

  end

  def credentials_for
    # key = Google::Auth::CredentialsLoader.from_env(KEY_FILE_PATH)
    #
    # authorizer = Google::Auth::ServiceAccountCredentials(key)
    #
    # credentials = authorizer.fetch_access_token!
    #
    # credentials
  end

  private

  def calendar_init
  end

end #controlled end
