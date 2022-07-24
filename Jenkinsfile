node {

//     stage("Git Clone"){

//         git credentialsId: 'github', url: 'https://github.com/HungNguyen235/k8s.git'
//     }
    
    dir("react-student-management-web-app"){
        stage("Docker build"){
            sh 'docker build -t hungnguyen23/student-app-client .'
            sh 'docker tag hungnguyen23/student-app-client hungnguyen23/student-app-client:1.0.8'
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
        sh 'docker push  hungnguyen23/student-app-client:1.0.8'
        dir("spring-boot-student-app-api"){
            sh 'mvn dockerfile:push'
        }
    }
    
    stage("install istio"){
        dir("istio"){
            stage("Install and Deploy istio using helm"){
                sh 'helm repo add istio https://istio-release.storage.googleapis.com/charts'
//                 sh 'kubectl create namespace istio-system'
                sh 'helm upgrade istio-base istio/base -n istio-system --install'
                sh 'helm upgrade istiod istio/istiod -n istio-system --wait --install'
//                 sh 'kubectl label namespace default istio-injection=enabled --overwrite'
                sh 'helm upgrade istio-ingress istio/gateway -f hungvip.yaml --wait --install'
                
            }
        }
    }
    
    stage("Deploy Application and mongo"){
        dir("k8s"){
            sh 'helm upgrade demo . --install'
        }
    }
    

    stage("Deploy prometeus and grafana"){
        dir("istio"){
            sh 'kubectl apply -f gateway.yaml'
            sh 'helm repo add prometheus-community https://prometheus-community.github.io/helm-charts'
            sh 'helm show values prometheus-community/kube-prometheus-stack > prometheus.yaml'
            sh 'helm upgrade my-kube-prometheus-stack prometheus-community/kube-prometheus-stack --values prometheus.yaml -n monitoring --create-namespace --install'
        }
        
    }
}
