NETWORKS_FOLDER=./networks
[ -d $NETWORKS_FOLDER ] && { echo "Removing past deployment file $NETWORKS_FOLDER"; rm -rf $NETWORKS_FOLDER; } || echo "No past deployments found"

ENV_VARIABLES=./scripts/3-networks/env-variables.sh
[ -f $ENV_VARIABLES ] && { echo Sourcing required variables; source $ENV_VARIABLES; } || echo "Can't find $ENV_VARIABLES file, assuming Jenkins deployment"


echo Creating networks folder
mkdir networks
cd ./networks

echo Cloning CFT
CFT_FOLDER=./terraform-example-foundation
[ -d $CFT_FOLDER ] && { echo "Removing past deployment file: $CFT_FOLDER"; rm -rf $CFT_FOLDER; } || echo "No past deployments found"
#git clone https://github.com/terraform-google-modules/terraform-example-foundation.git
git clone https://github.com/tranquilitybase-io/terraform-example-foundation.git


echo Checkout latest release
cd ./terraform-example-foundation/
#git checkout ed164ba
git checkout issue-1
cd ..

echo Cloning gcp networks GSR
GCP_NETWORKS_FOLDER=./gcp-networks
[ -d $GCP_NETWORKS_FOLDER ] && { echo "Removing past deployment file: $GCP_NETWORKS_FOLDER"; rm -rf $GCP_NETWORKS_FOLDER; } || echo "No past deployments found"
gcloud source repos clone gcp-networks --project=$CLOUD_BUILD_PROJECT_ID
cd gcp-networks

echo Checking out plan
echo checkout plan
git checkout -b plan

echo Copying needed build files
cp -R ../terraform-example-foundation/3-networks/. .
cp ../terraform-example-foundation/build/cloudbuild-tf-* .
cp ../terraform-example-foundation/build/tf-wrapper.sh .
chmod 755 ./tf-wrapper.sh

echo Creating empty var files
touch access_context.auto.tfvars
touch common.auto.tfvars
touch shared.auto.tfvars

echo Removing unneeded access_context.auto.example.tfvars
TF_EXAMPLE_VARS=./access_context.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; exit 1; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/access_context.auto.tfvars.json
COPY_LOCATION=./envs/development/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/access_context.auto.tfvars.json
COPY_LOCATION=./envs/non-production/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/access_context.auto.tfvars.json
COPY_LOCATION=./envs/production/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/access_context.auto.tfvars.json
COPY_LOCATION=./envs/shared/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev for bash deployment
TF_VARS=../../scripts/3-networks/access_context.auto.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming jenkins deployment"; }



echo Removing unneeded common.auto.example.tfvars
TF_EXAMPLE_VARS=./common.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; exit 1; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/common.auto.tfvars.json
COPY_LOCATION=./envs/development/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/common.auto.tfvars.json
COPY_LOCATION=./envs/non-production/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/common.auto.tfvars.json
COPY_LOCATION=./envs/production/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/common.auto.tfvars.json
COPY_LOCATION=./envs/shared/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev for bash deployment
TF_VARS=../../scripts/3-networks/common.auto.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming jenkins deployment"; }



echo Removing unneeded shared.auto.example.tfvars
TF_EXAMPLE_VARS=./shared.auto.example.tfvars
[ -f $TF_EXAMPLE_VARS ] && { echo "Removing unneeded $TF_EXAMPLE_VARS file: $TF_EXAMPLE_VARS"; rm $TF_EXAMPLE_VARS; } || { echo "No $TF_EXAMPLE_VARS file found"; exit 1; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/shared.auto.tfvars.json
COPY_LOCATION=./envs/development/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/shared.auto.tfvars.json
COPY_LOCATION=./envs/non-production/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/shared.auto.tfvars.json
COPY_LOCATION=./envs/production/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev jenkins deployment 
TF_VARS=../../scripts/3-networks/shared.auto.tfvars.json
COPY_LOCATION=./envs/shared/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming bash deployment"; }

echo Copying in needed variables for dev for bash deployment
TF_VARS=../../scripts/3-networks/shared.auto.tfvars
COPY_LOCATION=.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp --remove-destination $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; echo "assuming jenkins deployment"; }

git add .
git commit -m 'Your message'


# echo Copying in needed backend file 
# TF_VARS=../../scripts/3-networks/backend.tf
# COPY_LOCATION=./envs/development/.
# [ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; exit; }

# echo Copying in needed backend file 
# TF_VARS=../../scripts/3-networks/backend.tf
# COPY_LOCATION=./envs/non-production/.
# [ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; }

# echo Copying in needed backend file 
# TF_VARS=../../scripts/3-networks/backend.tf
# COPY_LOCATION=./envs/production/.
# [ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; }

echo Copying in needed backend file 
TF_VARS=../../scripts/3-networks/backend.tf
COPY_LOCATION=./envs/shared/.
[ -f $TF_VARS ] && { echo "Copying $TF_VARS to $COPY_LOCATION"; cp $TF_VARS $COPY_LOCATION; } || { echo "No $TF_VARS file found"; }
 
 
echo Local shared file TF apply
cd ./envs/shared/

echo ###
ls
pwd
cat access_context.auto.tfvars.json
cat common.auto.tfvars.json
cat shared.auto.tfvars.json
gcloud auth list
cat backend.tf
echo ###

terraform init
terraform plan
# terraform apply --auto-approve
# cd ../..


# echo Pushing plan
# git add .
# git commit -m 'Your message'
# git push --set-upstream origin plan --force

# sleep 600

# git checkout -b production
# git push origin production --force

# sleep 600

# git checkout -b development
# git push origin development --force

# sleep 600

# git checkout -b non-production
# git push origin non-production --force
