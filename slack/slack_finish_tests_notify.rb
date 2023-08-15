require_relative "./mock_slack_report.rb"
require 'json'
require 'httparty'

system('allure generate reports/allure-results')
uri_lib = "URI"
file_results = JSON.parse(File.read('allure-report/history/history-trend.json'))
file_duration = JSON.parse(File.read('allure-report/history/duration-trend.json'))
results = JSON.pretty_generate(file_results[0]['data'])
duration = JSON.pretty_generate(file_duration[0]['data']["duration"])

payload = finishing_pipeline(results, duration)
options = { body: payload.to_json, headers: { "Content-type": "application/json" } }
HTTParty.post(uri_lib, options)