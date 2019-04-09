class CalendarapiController < ApplicationController
  KEY_FILE_PATH = Rails.application.credentials[:calendar_api][:key_file]

  def index
    @text = "Calendar page"
# @key_file = ENV['GOOGLE_APPLICATION_CREDENTIALS']
@key_file = KEY_FILE_PATH
    # calendar = Google::Apis::CalendarV3::CalendarService.new
    # calendar.authorization = credentials_for
    # calendar_id = 'primary'
    # @result = calendar.list_events(calendar_id,
    #                                max_results: 10,
    #                                single_events: true,
    #                                order_by: 'startTime',
    #                                time_min: Time.now.iso8601)
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

end #controlled end
