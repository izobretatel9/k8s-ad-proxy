@Library('jenkins-devops@dev')_ // load jenkins-devops as a library

properties([
  parameters([
    choice(      name: 'TYPE',              choices: ['converge', 'dismiss'],
                                            defaultValue: 'converge',           description: 'TYPE of run Deploy or Dismis packages'),
    string(      name: 'SERVICE',           defaultValue: 'ad-proxy',           description: 'Name of Service (also namespace too)'),
    string(      name: 'WERF_VERSION',      defaultValue: '1.2 stable',         description: 'Werf version'),
  ])
])

pipeline {
  agent { label 'multiwerf' }

  environment {
    WERF_IMAGES_REPO        = "cr.yandex/xxxx/${params.SERVICE}"
    WERF_REPO               = "cr.yandex/xxxx/${params.SERVICE}"
    WERF_STAGES_STORAGE     = "cr.yandex/xxxx/${params.SERVICE}/stages"
    YC_AUTH                 = credentials("ya_registry_key")
    KUBECONFIG              = credentials('werf_kube_config')
    WERF_SECRET_KEY         = credentials("werf_secret_key")
    WERF_ENV                = "ad-proxy"
    WERF_NAMESPACE          = "${params.SERVICE}"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage("Prerequisites") {
      steps {
        script{
            functions.loginYCRegistry("${YC_AUTH}")
        }
      }
    }
    stage('Deploy to dev') {
      when { anyOf { branch 'master'; } }
      environment {
        WERF_KUBE_CONTEXT     = "dev"
      }
      steps {
        script {
          functions.runWerf("${params.TYPE}","${params.WERF_VERSION}")
        }
      }
    }
    stage('Deploy to production') {
      when { anyOf { branch 'master'; } }
      environment {
        WERF_KUBE_CONTEXT     = "production"
      }
      steps {
        script {
          functions.runWerf("${params.TYPE}","${params.WERF_VERSION}")
        }
      }
    }
  }
}
