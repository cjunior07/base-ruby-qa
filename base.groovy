pipeline {
  agent {
    docker {
      image "${params.cucumber_docker_image}"
      args '-v /var/jenkins_home:/var/jenkins_home -v /var/lib/jenkins:/var/lib/jenkins'
    }
  }
  // triggers {
  //         cron('0 9 * * 1-5')
  //   }
  parameters {
    string(
      name: 'cucumber_docker_image',
      defaultValue:'URI_ECR',
      description: 'The cucumber docker image'
    )
    string(
      name: 'retry',
      defaultValue:'--retry 0',
      description: 'set quantity of retry if cucumber scenario failed'
    )
    string(
      name: 'config_vars',
      defaultValue:'cdt_hml',
      description: 'Where you set config vars'
    )
    string(
      name: 'cucumber_tag',
      defaultValue:'@make_journey',
      description: 'Where you set cucumber tag'
    )
    string(
      name: 'cucumber_parallels_tag',
      defaultValue:'@make_parallel',
      description: 'Where you set cucumber tag'
    )
    string(
      name: 'parallels_workers',
      defaultValue:'10',
      description: 'How many workers to use'
    )
    string(
      name: 'env',
      defaultValue: 'qa',
      description: 'Where you set enviroment (dev|hml|prd|dr)'
    )
    string(
      name: 'tribe',
      defaultValue: 'T039 - Identity',
      description: 'Set Tribe: \n T016 - Inst. Payments\n T027 - Transfers\n T018 - Marketplace\n T001 - Accounts\n T033 - Capture Platforms (POSWEB)\n T035 - Acquiring as a Service\n T039 - Identity\n T040 - Prevention\n T012 - Forks\n T031 - Processing\n T049 - Card Management\n T021 - Pier Pro\n T009 - New Initiatives\n T004 - Card Scheme\n T048 - Key accounts\n T047 - Auth Globalization\n T007 - Core Authorization\n T005 - Clearing\n T008 - Core System\n T010 - Data (Pegasus)\n T025 - Mobile Apps\n T044 - Dev Tools\n T038 - Operation Journey (Console)\n T003 - Client Journey (Legacy Backoffices)\n T042 - Dockyard\n TNA - Other'
    )
  }
    stages {
      stage('CLEANING WORKDIR') {
        steps {
            deleteDir()
        }
      }
      stage('SENDING START REPORT IN SLACK CHANNEL'){
       steps { 
        sh 'printenv'
          script {
            env.TRIBE="${params.tribe}"
          }
          sh 'printenv'
          sh 'cd /base-ruby-backend-qa && ruby slack/slack_starting_tests_notify.rb'
        }
      }
      stage('RUNNING PARALLEL TESTS') {
      steps {
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
          configFileProvider([configFile(fileId: "${params.env}", variable:"${params.env}")]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
              sh "cd /base-ruby-backend-qa && . \$${params.env} >> /dev/null && bundle exec parallel_cucumber --type cucumber -n ${params.parallels_workers} features/ --group-by scenarios -o '-t ${params.cucumber_parallels_tag}'"
            }
          }
        }
      }
      }
      stage('RUNNING JOURNEY TESTS') {
        steps {
          catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
            slackSend(channel: "#reports-cucumber-tests", color: '#FFFF00', message: "Tests Started \n Tag Run: ${params.cucumber_tag} \n Image: ${params.cucumber_docker_image} \n Build Number: ${BUILD_NUMBER} \n Pipeline: ${JOB_NAME} \n Build Console: ${BUILD_URL}console")
            configFileProvider([configFile(fileId: "${params.env}", variable:"${params.env}")]) {
              wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
                sh "cd /base-ruby-backend-qa && . \$${params.env} >> /dev/null && bundle exec cucumber -t ${params.cucumber_tag} --color ${params.retry}"
              }
            }
          }
        }
      }
    }
    post {
      always{
      echo "TESTS FINISHED"
        sh 'mkdir -p ${WORKSPACE}/slack && cp -R /base-ruby-backend-qa/slack/* ${WORKSPACE}/slack'
        sh 'mkdir -p ${WORKSPACE}/allure-results && cp -R /base-ruby-backend-qa/reports/allure-results/* ${WORKSPACE}/allure-results'
        sh 'mkdir -p ${WORKSPACE}/result_html && cp /base-ruby-backend-qa/reports/html/cucumber-jornada.html ${WORKSPACE}/result_html'
        sh 'mkdir -p ${WORKSPACE}/result_json && cp /base-ruby-backend-qa/reports/target/cucumber-jornada.json ${WORKSPACE}/result_json'
        archiveArtifacts artifacts: 'result_html/cucumber-jornada.html'
          allure([
          includeProperties: true,
          jdk: '',
          reportBuildPolicy: 'ALWAYS',
          results: [[path: 'allure-results']]
        ])
        sh 'mkdir allure-report-${JOB_NAME}-${BUILD_NUMBER}'
        sh 'cp ../../jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/archive/allure-report.zip allure-report-${JOB_NAME}-${BUILD_NUMBER}'
        sh 'cd allure-report-${JOB_NAME}-${BUILD_NUMBER} && unzip allure-report.zip'
        sh "aws s3 cp allure-report-${JOB_NAME}-${BUILD_NUMBER}/allure-report s3://report-tests/${JOB_NAME}/${params.env}/${BUILD_NUMBER} --recursive"
        script {
          env.PIPELINE_RESULT="${currentBuild.result}"
          sh 'ruby slack/slack_finish_tests_notify.rb'
          if ("${currentBuild.result}" == "SUCCESS") {
          slackSend(channel: "#reports-cucumber-tests", color: "#00FF00", message: "Tests Finished \n Tag Run: ${params.cucumber_tag} \n Build Number: ${BUILD_NUMBER} \n Pipeline: ${JOB_NAME} \n Report Link: https://report-tests.devtools.caradhras.io/${JOB_NAME}/${params.env}/${BUILD_NUMBER}/index.html \n Pipeline Results: ${currentBuild.result}")
        } else if ("${currentBuild.result}" == "UNSTABLE") {
         slackSend(channel: "#reports-cucumber-tests", color: "#FF0000", message: "Tests Finished \n Tag Run: ${params.cucumber_tag} \n Build Number: ${BUILD_NUMBER} \n Pipeline: ${JOB_NAME} \n Report Link: https://report-tests.devtools.caradhras.io/${JOB_NAME}/${params.env}/${BUILD_NUMBER}/index.html \n Pipeline Results: ${currentBuild.result}")
        } else {
          slackSend(channel: "#reports-cucumber-tests", color: "", message: "Problem Tests \n Tag Run: ${params.cucumber_tag} \n Build Number: ${BUILD_NUMBER} \n Pipeline: ${JOB_NAME} \n Report Link: https://report-tests.devtools.caradhras.io/${JOB_NAME}/${params.env}/${BUILD_NUMBER}/index.html \n Pipeline Results: ${currentBuild.result}")
        }
        }
      }
    }
  }
