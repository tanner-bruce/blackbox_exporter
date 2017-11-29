def csh(String str) {
  ansiColor('xterm') {
    sh str
  }
}

project_name = "blackbox_exporter"
pipeline {
  agent {
    node {
      label "kubernetes"
    }
  }
  triggers {
  	cron('0 0 * * *') # rebuild nightly to get new minideb
  }
  stages {
    stage('build') {
      steps {
        slackSend color: 'good', channel: "#devops-cd", message: "$project_name:$BRANCH_NAME started"
        csh 'make build'
      }
    }
    stage('test') {
      steps {
        csh "CONTAINER_NAME='$project_name-$BRANCH_NAME' make test"
      }
    }
    stage('push') {
      when {
        branch 'master'
      }
      steps {
        csh 'make push'
      }
    }
  }
  post {
    success {
      slackSend (color: 'good', channel: "#devops-cd", message: "$project_name:$BRANCH_NAME succeeded")
    }
    failure {
      slackSend (color: 'bad', channel: "#devops-cd", message: "$project_name:$BRANCH_NAME failed")
    }
  }
}
