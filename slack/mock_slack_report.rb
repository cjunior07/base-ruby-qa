def starting_pipeline
    {
        "username": "Report Automation Tests",
        "icon_url": "https://pbs.twimg.com/media/FRbejW8XEAAfzBK.jpg",
        "attachments": [
            {
                "color": "#15CFEC",
                "blocks": [
                    {
                        "type": "header",
                        "text": {
                            "type": "plain_text",
                            "text": "Starting Pipeline Test - Agamotto :loading:",
                            "emoji": true
                        }
                    },
                    {
                        "type": "section",
                        "text": {
                            "type": "mrkdwn",
                            "text": "*Business Unit:* CJ Tech \n *Project Name:* Agamotto \n *Pipeline Name:* #{ENV['JOB_BASE_NAME']} \n *Tribe:* #{ENV['tribe']} \n *Issuer_Enviroment:* #{ENV['config_vars']} \n *Tag(s) Executed:* #{ENV['cucumber_tag']} #{ENV['cucumber_parallels_tag']}"
                        }
                    },
                    {
                        "type": "actions",
                        "elements": [
                            {
                                "type": "button",
                                "text": {
                                    "type": "plain_text",
                                    "emoji": true,
                                    "text": "View Execution Console"
                                },
                                "style": "primary",
                                "value": "click_me_123",
                                "url": "https://jenkins.dock.tech/blue/organizations/jenkins/#{ENV['JOB_BASE_NAME']}/detail/#{ENV['JOB_BASE_NAME']}/#{ENV['BUILD_ID']}/pipeline"
                            }
                        ]
                    },
                    {
                        "type": "divider"
                    },
                    {
                        "type": "context",
                        "elements": [
                            {
                                "type": "image",
                                "image_url": "https://www.pngarts.com/files/1/Quality-Assurance-PNG-Download-Image.png",
                                "alt_text": "QA"
                            },
                            {
                                "type": "mrkdwn",
                                "text": "*QA Team* | #{Time.now.strftime("%d/%m/%Y - %H:%M:%S")}"
                            }
                        ]
                    }
                ]
            }
        ]
    }
end

def finishing_pipeline (file_results, file_duration)
    results = JSON.parse(file_results)
    ENV['PIPELINE_RESULT'] != "SUCCESS" ? emoji = ":alert: :alert:" : emoji = ":white_check_mark:"
    duration_time = get_duration(file_duration)
    percentage_failure = get_percentage_failure(results)
    percentage_success = get_percentage_success(results["passed"], results["total"])
    average_time_scenarios = get_average_time_scenarios(file_duration, results["total"])
    {
        "username": "Report Automation Tests",
        "icon_url": "https://pbs.twimg.com/media/FRbejW8XEAAfzBK.jpg",
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "Finish Pipeline Test - Agamotto #{emoji}",
                    "emoji": true
                }
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "*Pipeline Result: #{ENV['PIPELINE_RESULT']}*\n*Business Unit:* Dock Tech \n*Project Name:* Agamotto \n *Pipeline Name:* #{ENV['JOB_BASE_NAME']} \n *Tribe:* #{ENV['tribe']} \n *Issuer_Enviroment:* #{ENV['config_vars']} \n *Tag(s) Executed:* #{ENV['cucumber_tag']} #{ENV['cucumber_parallels_tag']}"
                }
            },
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "Results",
                    "emoji": true
                }
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": ">*```Failed: #{results["failed"]} \nBroken: #{results["broken"]}\nSkipped: #{results["skipped"]}\nUnknown: #{results["unknown"]}\nPassed: #{results["passed"]}\nTotal Scenarios: #{results["total"]}```*"
                }
            },
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "Statistics",
                    "emoji": true
                }
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": ">*```Total Duration: #{duration_time} \nFailure Percentage: #{percentage_failure}\nSuccess Percentage: #{percentage_success}\nAverage time per scenario: #{average_time_scenarios}```*"
                }
            },
            {
                "type": "actions",
                "elements": [
                    {
                        "type": "button",
                        "text": {
                            "type": "plain_text",
                            "emoji": true,
                            "text": "View Allure Report"
                        },
                        "style": "primary",
                        "value": "allure_report",
                        "url": "https://jenkins.dock.tech/job/#{ENV['JOB_BASE_NAME']}/#{ENV['BUILD_ID']}/allure/"
                    }
                ]
            },
            {
                "type": "divider"
            },
            {
                "type": "context",
                "elements": [
                    {
                        "type": "image",
                        "image_url": "https://www.pngarts.com/files/1/Quality-Assurance-PNG-Download-Image.png",
                        "alt_text": "QA"
                    },
                    {
                        "type": "mrkdwn",
                        "text": "*QA Team* | #{Time.now.strftime("%d/%m/%Y - %H:%M:%S")}"
                    }
                ]
            }
        ]
    }
end

def get_duration(milliseconds = nil)
    begin
      milliseconds = milliseconds.to_f
    rescue
      return "Received value is invalid: #{milliseconds}"
    end
    
    hours, milliseconds   = milliseconds.divmod(1000 * 60 * 60)
    minutes, milliseconds = milliseconds.divmod(1000 * 60)
    seconds, milliseconds = milliseconds.divmod(1000)
    "#{hours}h #{minutes}m #{seconds}s #{milliseconds}ms"
end

def get_percentage_failure(results)
    total_failure = (results["failed"].to_i + results["broken"].to_i + results["skipped"].to_i + results["unknown"].to_i)
    percentage = (total_failure.to_i/results["total"].to_i) * 100
    "#{percentage} %"
end

def get_percentage_success(total_success, total_scenarios)
    percentage = (total_success.to_i/total_scenarios.to_i) * 100
    "#{percentage} %"
end

def get_average_time_scenarios(total_time, total_scenarios)
  begin
    milliseconds = total_time.to_f
  rescue
    return "Received value Time is invalid: #{milliseconds}"
  end
  average = (milliseconds/total_scenarios.to_i)
  get_duration(average)
end
