require_relative "./mock_slack_report.rb"
require 'json'
require 'httparty'

payload = starting_pipeline.to_json
options = { body: payload, headers: { "Content-type": "application/json" } }
HTTParty.post('URI', options)