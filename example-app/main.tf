provider "kubernetes" {
  config_path = var.kubeconfig_path
}

variable "namespace" {
  description = "The namespace for the example app"
  default     = "example-namespace"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name      = "example-deployment"
    namespace = var.namespace
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "example-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "example-app"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "example-container"
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name      = "example-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "example-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
