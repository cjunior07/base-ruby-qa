Before do |scenario|
  ENV['file_log'] = "#{Time.now.to_i}_#{SecureRandom.uuid}.log"
  LOG = QaServices::LogService.new
  token_service = QaServices::TokenService.new
  uri_auth = 'uri' if ENV_RUN.include?('_dev')
  uri_auth = 'uri' if ENV_RUN.include?('_hml')
  @token = token_service.create_token(uri_auth, ENV['username'], ENV['password'])
end

After do
  report_log = File.read(ENV['file_log'])
  Allure.add_attachment(name: 'Evidence', source: "#{report_log}", type: Allure::ContentType::TXT, test_case: true)
  File.delete(ENV['file_log'])
end