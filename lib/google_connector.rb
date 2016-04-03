class GoogleConnector
  require 'google/apis/drive_v3'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'

  require 'fileutils'

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  APPLICATION_NAME = CONFIG['app_name']
  CLIENT_SECRETS_PATH = File.join(Rails.root, 'config', 'client_secret.json')
  CREDENTIALS_PATH = File.join(Rails.root, 'config',
                               'google-connector-credentials.yaml')
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE

  def initialize
    @service = Google::Apis::DriveV3::DriveService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  private

  def authorize
    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      code = get_authorization_code(authorizer)
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end

  def authorization_code(authorizer)
    url = authorizer.get_authorization_url(
      base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         'resulting code after authorization'
    puts url
    gets
  end

  def client_id
    Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  end

  def token_store
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))
    Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  end
end
