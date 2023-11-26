output "example_app_service_ip" {
  value = kubernetes_service.example.spec[0].cluster_ip
}
