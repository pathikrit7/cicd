# Solution

1. Dockerfile contains the nginx image which is listening on port 8080

docker build -t webserver .
docker run -it --rm -d -p 8888:8080 --name web webserver

Should be able to view the contents of index.html by visiting localhost:8888

2. terraform folder has the terraform to push it to my ECR registry/repository, state is stored in an S3 bucket but it can be modified to run locally to validate/plan.

3. helm folder has a basic helm chart to deploy the application to kubernetes, it also includes hpa which will allow you to autoscale. currently based on cpu and memory but can be enhanced by using prometheus metrics via prometheus adapter or KEDA.

The whole solution gets deployed via github actions which is define here - https://github.com/pathikrit7/cicd-ecr-eks/blob/main/.github/workflows/cicd.yaml

The running hello world container can be access via the LB - http://a76a80d38a7254e93b51967601db3a85-1822124596.us-east-1.elb.amazonaws.com/
