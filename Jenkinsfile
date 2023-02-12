pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('bootstrap-dockerhub')
        }
    stages {

        stage('ECHO') {
            steps {
                sh 'echo hello world'
                sh 'ls -lah'
                
            }
        }

      

        stage('Docker Build') {
            steps {
                sh 'docker build -t bahachalbia/maven-customer-service:latest maven/customer-service/'
                sh 'docker build -t bahachalbia/maven-order-service:latest maven/order-service/'
                sh 'docker build -t bahachalbia/maven-oauth2-server:latest maven/oauth2-server/'
                sh 'docker build -t bahachalbia/maven-admin:latest maven/admin-server/'
                sh 'docker build -t bahachalbia/maven-config-server:latest maven/config-server/'
                sh 'docker build -t bahachalbia/maven-zuul-server:latest maven/zuul-server/'
                sh 'docker build -t bahachalbia/maven-eureka-server:latest maven/eureka-server/'
                 }
        }
          stage('login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u bahachalbia --password-stdin '

            }
        }
        stage('push') {
            steps {
                sh 'docker push bahachalbia/maven-customer-service'
                sh 'docker push bahachalbia/maven-order-service'
                sh 'docker push bahachalbia/maven-oauth2-server'
                sh 'docker push bahachalbia/maven-admin'
                sh 'docker push bahachalbia/maven-config-server'
                sh 'docker push bahachalbia/maven-zuul-server'
                sh 'docker push bahachalbia/maven-eureka-server'

            }
        }
        stage('Docker Logout') {
            steps {
                sh 'docker logout'
            }
        }
        stage('Deployment') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                    sh'kubectl apply -f manifest/deployments.yaml'
            }
            }
        }
    }
}
