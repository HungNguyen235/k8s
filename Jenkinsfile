node {

    stage("Git Clone"){

        git credentialsId: 'github', url: 'https://github.com/HungNguyen235/k8s.git'
    }
    
    dir("react-student-management-web-app"){
        stage("Docker build"){
            sh 'docker build -t hungnguyen23/student-app-client .'
            sh 'docker tag hungnguyen23/student-app-client hungnguyen23/student-app-client:latest'
        }
    }
    
    dir("spring-boot-student-app-api"){
        stage("Build porm file"){
            sh ' mvn package '
        }
    }    

    stage("login dockerhub"){
        withCredentials([string(credentialsId: 'docker', variable: 'PASSWORD')]) {
            sh 'docker login -u hungnguyen23 -p $PASSWORD'
        }
    }

    stage("Push Image to Docker Hub"){
        sh 'docker push  hungnguyen23/student-app-client:latest'
        dir("spring-boot-student-app-api"){
            sh 'mvn dockerfile:push'
        }
    }
    
    dir("/home/ubuntu"){
        stage("Install and Deploy istio using helm"){
            sh 'helm repo add istio https://istio-release.storage.googleapis.com/charts'
            sh 'kubectl create namespace istio-system'
            sh 'helm install istio-base istio/base -n istio-system'
            sh 'helm install istiod istio/istiod -n istio-system --wait'
            sh 'kubectl label namespace default istio-injection=enabled'
            sh 'helm install istio-ingress istio/gateway -f hungvip.yaml --wait'
        }
    }
}
