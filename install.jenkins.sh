
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# Download the appropriate java jdk version from the Oracle website.
# Copy the package from your local environment to the target server.

# Install the jdk package.
rpm -Uvh jdk-8u144-linux-x64.rpm

# Setup Alternatives for Java:
alternatives --install /usr/bin/java java /usr/java/latest/bin/java 200000
alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000

echo "" >> /etc/rc.local
echo 'export JAVA_HOME="/usr/java/latest"' >> /etc/rc.local

# Add the Jenkins repo to yum sources.
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import the Jenkins rpm signing key.
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins.
yum install -y jenkins-2.19.4-1.1

echo "services running on 8080:"
netstat -tulpn | grep 8080
echo "="

systemctl start jenkins
systemctl enable jenkins

sleep 5
echo "services running on 8080:"
netstat -tulpn | grep 8080
echo "="

