resource "kubernetes_namespace" "jenkins_namespace" {
  count = var.create_namespace ? 1 : 0
  depends_on = [
    module.eks
  ]
  metadata {
    annotations = {
      name = "jenkins"
    }

    labels = {
      managedby = "terraform"
    }

    name = var.namespace
  }
}

resource "kubernetes_persistent_volume_claim" "claim" {
  metadata {
    name      = "${var.name}-claim"
    namespace = var.namespace
    labels = {
      managedby = "terraform"
    }
  }
  spec {
    access_modes = [var.accessmode]
    resources {
      requests = {
        storage = var.request_storage
      }
    }
    storage_class_name = var.storageclass
  }
  depends_on = [
    kubernetes_namespace.jenkins_namespace
  ]
}

resource "kubernetes_deployment" "jenkins" {
  depends_on = [
    kubernetes_namespace.jenkins_namespace
  ]

  metadata {
    name = "${var.name}-deployment"
    labels = {
      managedby = "terraform"
    }
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        service_account_name = "${var.name}-admin"
        container {
          image = var.jenkins_image
          name  = var.name
          port {
            container_port = "8080"
          }
          volume_mount {
            name       = "${var.name}-persistent-storage"
            mount_path = "/var/jenkins_home"
          }
          #   TODO: liveness probe
        }
        security_context {
          fs_group = "1000"
        }
        volume {
          name = "${var.name}-persistent-storage"
          persistent_volume_claim {
            claim_name = "${var.name}-claim"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "jenkins-service" {
  depends_on = [
    kubernetes_deployment.jenkins,
    kubernetes_namespace.jenkins_namespace
  ]
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = {
      managedby = "terraform"
      service   = var.name
    }
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      port = 8080
      name = "http"
    }
    port {
      port = 50000
      name = "tunnel"
    }

    type = var.service_type
  }
}

resource "kubernetes_service_account" "jenkins_service_account" {
  metadata {
    name      = "${var.name}-admin"
    namespace = var.namespace
  }
}

resource "kubernetes_role" "jenkins_role" {
  metadata {
    name = "jenkins-role"
    namespace = var.namespace
  }

  rule {
    api_groups     = ["","apps","autoscaling"]
    resources      = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "jenkins_role_binding" {
  metadata {
    name = "jenkins-role-binding"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "jenkins-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${var.name}-admin"
    namespace = var.namespace
    api_group = ""
  }
}