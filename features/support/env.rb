require 'cucumber'
require 'allure-cucumber'
require 'rspec'
require 'qa_services'
require 'logging'
require 'json-schema'
require 'json_matchers'
require 'json_matchers/rspec'

$VERBOSE = nil

Dir.mkdir 'reports/allure-results/allure-reports-s3' if Dir.exist?('reports/allure-results/allure-reports-s3') == false
Dir.mkdir 'reports/allure-results' if Dir.exist?('reports/allure-results') == false
Dir.mkdir 'reports/html' if Dir.exist?('reports/html') == false
Dir.mkdir 'reports/target' if Dir.exist?('reports/target') == false

File.new('reports/html/cucumber-jornada.html', 'w') unless File.exist?('reports/html/cucumber-jornada.html')
File.new('reports/target/cucumber-jornada.json', 'w') unless File.exist?('reports/target/cucumber-jornada.json')

ENV_RUN = ENV['ENV_RUN']
ENV_RUN = ENV['config_vars'] if ENV['aws_access_key_id_temp_qa'] != nil

if ENV['aws_access_key_id_temp_qa'].nil?
  ENV = YAML.load_file(File.dirname(__FILE__) + "/config/qa.yml")
  VERSION_TEST = { "base-ruby-backend-qa" => "local" }
  DEVOPS = false
  Allure.configure do |c|
    c.results_directory = 'reports/allure-results'
    c.clean_results_directory = true
    c.results_directory = 'reports/allure-results/allure-reports-s3'
    c.clean_results_directory = true
  end
else
  DEVOPS = true
  ENV = ENV.to_h
  VERSION_TEST = { "base-ruby-backend-qa" => "#{ENV['cucumber_docker_image'].split(':')[1]}" }
  TAG_RUNNED = ENV['cucumber_tag']
  JOB_BASE_NAME = ENV['JOB_BASE_NAME']
  BUILD_ID = ENV['BUILD_ID']
  CUCUMBER_DOCKER_IMAGE = ENV['cucumber_docker_image']
end

CONFIG = nil
ACCOUNT_NUMBER = nil
AWS_REGION = 'us-east-2'
if ENV_RUN.include?('hml')
  CONFIG = 'hml'
  ACCOUNT_NUMBER = ENV['account_hml']
elsif ENV_RUN.include?('dev')
  CONFIG = 'dev'
  ACCOUNT_NUMBER = ENV['account_dev']
elsif ENV_RUN.include?('prd')
  CONFIG = 'prd'
  ACCOUNT_NUMBER = ENV['account_hml']
elsif ENV_RUN.include?('qa')
  CONFIG = 'qa'
  ACCOUNT_NUMBER = ENV['account_qa']
end

uris = QaServices::AwsSecretsManager.new.get_sm_secret_value("cucumber_uris_#{CONFIG}")
access = QaServices::AwsSecretsManager.new.get_sm_secret_value("cucumber_#{ENV_RUN.downcase}")
accounts = QaServices::AwsSecretsManager.new.get_sm_secret_value("cucumber_accounts_aws")
ENV = ENV.merge!(uris)
ENV = ENV.merge!(access)
ENV = ENV.merge!(accounts)
ENV["TZ"] = 'America/Sao_Paulo'

FOLDER_JSON_SCHEMAS = JsonMatchers.schema_root = './features/schemas'
