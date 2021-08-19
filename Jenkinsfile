pipeline {
    agent {
        kubernetes {
          label 'kubepod'
          defaultContainer 'gcloud' 
        }
    }
    environment {

       def networks_params = "${networks_params}"
       def cicd_project = "${cicd_project}"
       def state_bucket = "${state_bucket}" 

  }
    stages {
        
        stage ('Test received params') {
            steps {
                sh '''
                echo \"$networks_params\"
                '''
            }
        }
        stage('Activate GCP Service Account and Set Project') {
            steps {
                
                container('gcloud') {
                    sh '''
                        gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                        gcloud config list
                       '''
                }
            }
            
        }
       stage('Setup Terraform & Dependencies') {
             steps {
                 container('gcloud') {
                     sh '''
                       
                         apt-get -y install jq wget unzip
                         wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
                         unzip -q /tmp/terraform.zip -d /tmp
                         chmod +x /tmp/terraform
                         mv /tmp/terraform /usr/local/bin
                         rm /tmp/terraform.zip
                         terraform --version
                        '''
                 }
             }

         }
        stage('Deploy CFT networks') {
             steps {
                 container('gcloud') {
                     sh '''
                         export CLOUD_BUILD_PROJECT_ID=$cicd_project 
                         
                         cd ./scripts/3-networks/
                         echo \"$networks_params\" | jq "." > common.auto.tfvars.json   
                         echo \"$networks_params\" | jq "." > access_context.auto.tfvars.json
                         mv shared.auto.example.tfvars ./shared.auto.tfvars.json                        
                         mv backend-example.tf backend.tf
                         sed "s/UPDATE_ME/$state_bucket/" backend.tf
                         cd ../..
                         make networks
                         echo "3-networks  done"
                         '''
    
                 }
               
             }
         }
    
    
    }
    
    
    
}
