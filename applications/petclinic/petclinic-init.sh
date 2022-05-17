#!/bin/bash
echo '=============== Staring init script for PetClinic Server ==============='

# save all env for debugging
printenv > /var/log/colony-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#accept updates
#sudo yum -y update

#upgrade to python3
#sudo yum -y install python36
#sudo yum -y install epel-release
#sudo yum -y install wget

#set pip to use python3
#sudo python3 -m pip install --upgrade --force pip

#install dependancies for python api
#sudo python3 -m pip install Flask --user
#sudo python3 -m pip install werkzeug --user

#install java
sudo yum -y install java-11-openjdk-devel


#install git
#sudo yum -y install git

#Install JFrog CLI
sudo echo "[jfrog-cli]" > jfrog-cli.repo;
sudo echo "name=jfrog-cli" >> jfrog-cli.repo;
sudo echo "baseurl=https://releases.jfrog.io/artifactory/jfrog-rpms" >> jfrog-cli.repo;
sudo echo "enabled=1" >> jfrog-cli.repo;
sudo rpm --import https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key
sudo mv jfrog-cli.repo /etc/yum.repos.d/;
sudo yum install -y jfrog-cli-v2-jf;

#import creds
jf config import eyJ2ZXJzaW9uIjoyLCJ1cmwiOiJodHRwczovL3JvbmFrLmpmcm9nLmlvLyIsImFydGlmYWN0b3J5VXJsIjoiaHR0cHM6Ly9yb25hay5qZnJvZy5pby9hcnRpZmFjdG9yeS8iLCJkaXN0cmlidXRpb25VcmwiOiJodHRwczovL3JvbmFrLmpmcm9nLmlvL2Rpc3RyaWJ1dGlvbi8iLCJ4cmF5VXJsIjoiaHR0cHM6Ly9yb25hay5qZnJvZy5pby94cmF5LyIsIm1pc3Npb25Db250cm9sVXJsIjoiaHR0cHM6Ly9yb25hay5qZnJvZy5pby9tYy8iLCJwaXBlbGluZXNVcmwiOiJodHRwczovL3JvbmFrLmpmcm9nLmlvL3BpcGVsaW5lcy8iLCJ1c2VyIjoicnJhaG1hbiIsInBhc3N3b3JkIjoiQVA4dTNhVzFnZ0p0cGZmOHl6WFNBUm5Kdm5GIiwiYWNjZXNzVG9rZW4iOiJleUoyWlhJaU9pSXlJaXdpZEhsd0lqb2lTbGRVSWl3aVlXeG5Jam9pVWxNeU5UWWlMQ0pyYVdRaU9pSXhhVnBsY2toRGFGUlROalY1TTNFMU9IUnhXbVpLVlRGRFEydDJhVE5KTUVwSGVqTmpaRGgxZUZBMEluMC5leUp6ZFdJaU9pSnFabkowUURBeFp6RnVkMjV6ZG5ScmVETnRNR2huZW5Gb2NUSXhZVGhoWEM5MWMyVnljMXd2Y25KaGFHMWhiaUlzSW5OamNDSTZJbTFsYldKbGNpMXZaaTFuY205MWNITTZLaUlzSW1GMVpDSTZJbXBtY25SQU1ERm5NVzUzYm5OMmRHdDRNMjB3YUdkNmNXaHhNakZoT0dFaUxDSnBjM01pT2lKcVpuSjBRREF4WnpGdWQyNXpkblJyZUROdE1HaG5lbkZvY1RJeFlUaGhYQzkxYzJWeWMxd3ZjbkpoYUcxaGJpSXNJbVY0Y0NJNk1UWTFNamd3TVRBM09Td2lhV0YwSWpveE5qVXlOemszTkRjNUxDSnFkR2tpT2lKbFltRmlZalV5TnkwMU5UTmpMVFJpTlRNdE9HVmxaaTAwTkRjME56SmhNRGsxTVRVaWZRLnA5ZUZtbXl4LThTSW1SRFRtSzlHUkRsdUlFbmVnaTh6TTJhYnBUc0gzbFdKZ3R0bFBxZDBYOS1VTU9sRFdLeFA1N0s1Nm5VTmw4N0U4VS1KeW5GTE10a0lud1J4c0dHTDVZT0xXelR4bWdvMUF3N1ZldWJ5d041b242SW9HVk8zNTIyTm10Vi1aVVFQSVRucTlnVm1KNXpRN3NpVGptRjFMclU0Rll2WDNmWkVYc3BPQkwyQlhYNTdtbFR6NlQ5VlJ4ZDlPWmgtLUQ1NThBZXhKbC1MalQwaVRuVTlCSTc4eFpraUh2Ty1nMVJaV0MyenRUeDJPdmI5c0FQZEJpT2IwOUZWUmhGQ2loMTR6aWwyYTVvZlM5cXpmNUtYRU5DeUN5VE1UNFhjc1JpNmJKUGFCVlE4SGs2WDJscS1kTi1RVy1NWDBZeGtzbmRwRm5xYVl6cmtuZyIsInJlZnJlc2hUb2tlbiI6IjJiOWM1NDEyLWNkMjUtNGU1ZC04MzY4LTM1Y2RmMTE1MTc2ZiIsInNlcnZlcklkIjoicm9uYWsifQ==


#download artifact
jf rt dl --flat default-generic-local/com/petclinic/spring-petclinic-2.6.0-SNAPSHOT.jar

#start PetClinic
sudo java -jar spring-petclinic-2.6.0-SNAPSHOT.jar