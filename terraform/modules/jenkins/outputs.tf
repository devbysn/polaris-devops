output "jenkins_url" {
  description = "The URL of the Jenkins server"
  value       = helm_release.jenkins.name
}

