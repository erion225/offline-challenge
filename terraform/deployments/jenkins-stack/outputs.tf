################################################################################
# Jenkins URL
################################################################################
output "jenkins_url" {
  value       = "http://${module.loadbalancer.elb_dns_name}:8080"
  description = "Jenkins URL"
}