#! /bin/bash
sudo  su
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install fontconfig openjdk-11-jre -y
apt-get install jenkins -y
systemctl start jenkins

# Run after installtion: gcloud compute ssh your-instance-name --command "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"