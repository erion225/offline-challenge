FROM jenkins/jenkins:lts

# Set default Jenkins options like disabling the setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Copy Plugins list and post install validator
COPY plugins.yaml /usr/share/jenkins/ref/plugins.yaml
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.yaml  --available-updates --output yaml > /usr/share/jenkins/ref/plugins_latest.yaml
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins_latest.yaml --verbose --view-all-security-warnings 2>&1 | tee /tmp/plugin_install.log