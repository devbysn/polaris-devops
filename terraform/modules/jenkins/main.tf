resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "jenkins"

  values = [
    <<EOF
master:
  adminPassword: "admin"
  serviceType: "LoadBalancer"
  installPlugins:
    - kubernetes
    - workflow-aggregator
    - git
    - configuration-as-code
  JCasC:
    configScripts:
      pipelineConfig: |
        jenkins:
          systemMessage: "Jenkins configured automatically by Jenkins Configuration as Code plugin\n\n"
          securityRealm:
            local:
              allowsSignup: false
              users:
                - id: "admin"
                  password: "admin"
          authorizationStrategy:
            loggedInUsersCanDoAnything:
              allowAnonymousRead: false
agent:
  enabled: false
EOF
  ]
}

