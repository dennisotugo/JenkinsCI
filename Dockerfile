FROM jenkins/jenkins:lts

WORKDIR /tmp

ENV KOPS_VERSION=1.10.0
ENV KUBECTL_VERSION=v1.11.2
ENV BLUEOCEAN_VERSION=1.5.0

USER root

RUN apt-get update \
 && apt-get install -y curl unzip \
 && apt-get install -y openjdk-8-jdk \
 && curl -fsSL https://get.docker.com | sh \
 && apt-get clean \
 && usermod -aG docker jenkins

RUN curl -O --location --silent --show-error https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 \
  && mv kops-linux-amd64 /usr/local/bin/kops \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
  && mv kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kops /usr/local/bin/kubectl
  
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
  && unzip awscli-bundle.zip \
  && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
  
USER jenkins
WORKDIR $JENKINS_HOME

RUN /usr/local/bin/install-plugins.sh       \
  blueocean-bitbucket-pipeline:${BLUEOCEAN_VERSION}    \
  blueocean-commons:${BLUEOCEAN_VERSION}    \
  blueocean-config:${BLUEOCEAN_VERSION}     \
  blueocean-dashboard:${BLUEOCEAN_VERSION}  \
  blueocean-events:${BLUEOCEAN_VERSION}     \
  blueocean-git-pipeline:${BLUEOCEAN_VERSION}          \
  blueocean-github-pipeline:${BLUEOCEAN_VERSION}       \
  blueocean-i18n:${BLUEOCEAN_VERSION}       \
  blueocean-jwt:${BLUEOCEAN_VERSION}        \
  blueocean-jira:${BLUEOCEAN_VERSION}       \
  blueocean-personalization:${BLUEOCEAN_VERSION}        \
  blueocean-pipeline-api-impl:${BLUEOCEAN_VERSION}      \
  blueocean-pipeline-editor:${BLUEOCEAN_VERSION}        \
  blueocean-pipeline-scm-api:${BLUEOCEAN_VERSION}       \
  blueocean-rest-impl:${BLUEOCEAN_VERSION}  \
  blueocean-rest:${BLUEOCEAN_VERSION}       \
  blueocean-web:${BLUEOCEAN_VERSION}        \
  blueocean:${BLUEOCEAN_VERSION}            \
  ant:1.8                        \
  ansicolor:0.5.2                \
  antisamy-markup-formatter:1.5  \
  artifactory:2.15.1             \
  authentication-tokens:1.3      \
  branch-api:2.0.19              \
  build-name-setter:1.6.9        \
  build-timeout:1.19             \
  cloudbees-folder:6.4           \
  conditional-buildstep:1.3.6    \
  config-file-provider:2.18      \
  copyartifact:1.39.1            \
  cvs:2.14                       \
  docker-build-publish:1.3.2     \
  docker-workflow:1.15.1         \
  durable-task:1.22              \
  ec2:1.39                       \
  embeddable-build-status:1.9    \
  external-monitor-job:1.7       \
  git:3.8.0                      \
  gradle:1.28                    \
  greenballs:1.15                \
  handlebars:1.1.1               \
  ivy:1.28                       \
  jackson2-api:2.8.11.3          \
  job-dsl:1.68                   \
  jobConfigHistory:2.18          \
  jquery:1.12.4-0                \
  ldap:1.20                      \
  mapdb-api:1.0.9.0              \
  marathon:1.6.0                 \
  matrix-auth:2.2                \
  matrix-project:1.13            \
  maven-plugin:3.1.2             \
  metrics:3.1.2.11               \
  monitoring:1.72.0              \
  nant:1.4.3                     \
  node-iterator-api:1.5.0        \
  pam-auth:1.3                   \
  parameterized-trigger:2.35.2   \
  pipeline-build-step:2.7        \
  pipeline-github-lib:1.0        \
  pipeline-input-step:2.8        \
  pipeline-milestone-step:1.3.1  \
  pipeline-model-api:1.2.8       \
  pipeline-model-definition:1.2.8 \
  pipeline-model-extensions:1.2.8 \
  pipeline-rest-api:2.10         \
  pipeline-stage-step:2.3        \
  pipeline-stage-view:2.10       \
  plain-credentials:1.4          \
  prometheus:1.2.0               \
  rebuild:1.28                   \
  role-strategy:2.7.0            \
  run-condition:1.0              \
  s3:0.11.0                      \
  saferestart:0.3                \
  saml:1.0.5                     \
  scm-api:2.2.6                  \
  ssh-agent:1.15                 \
  ssh-slaves:1.26                \
  subversion:2.10.5              \
  timestamper:1.8.9              \
  translation:1.16               \
  variant:1.1                    \
  windows-slaves:1.3.1           \
  workflow-aggregator:2.5        \
  workflow-api:2.27              \
  workflow-basic-steps:2.6       \
  workflow-cps:2.48              \
  workflow-cps-global-lib:2.9    \
  workflow-durable-task-step:2.19 \
  workflow-job:2.18              \
  workflow-multibranch:2.17      \
  workflow-scm-step:2.6          \
  workflow-step-api:2.14         \
  workflow-support:2.18
