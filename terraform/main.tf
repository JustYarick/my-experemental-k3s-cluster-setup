terraform {
  required_version = ">= 1.0"
  
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "kubernetes" {
  config_path = "~/MyLocalK3sCluester/k3s.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "~/MyLocalK3sCluester/k3s.yaml"
  }
}

# resource "helm_release" "promtail" {
#   name             = "promtail"
#   repository       = "./charts"
#   chart            = "promtail"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/promtail/values.yaml")
#   ]
# }

# resource "helm_release" "tempo" {
#   name             = "tempo"
#   repository       = "./charts"
#   chart            = "tempo"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/tempo/values.yaml")
#   ]
# }


# resource "helm_release" "loki" {
#   name             = "loki"
#   repository       = "./charts"
#   chart            = "loki"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/loki/values.yaml")
#   ]
# }

# resource "helm_release" "otel-collector" {
#   name             = "otel-collector"
#   repository       = "./charts"
#   chart            = "otel-collector"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/otel-collector/values.yaml")
#   ]
# }

# resource "helm_release" "prometheus" {
#   name             = "prometheus"
#   repository       = "./charts"
#   chart            = "prometheus"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/prometheus/values.yaml")
#   ]
# }

# resource "helm_release" "grafana" {
#   name             = "grafana"
#   repository       = "./charts"
#   chart            = "grafana"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/grafana/values.yaml")
#   ]
# }

resource "helm_release" "argo-cd" {
  name             = "argo-cd"
  repository       = "./charts"
  chart            = "argo-cd"
  namespace        = "ci-cd"
  create_namespace = true

  values = [
    file("${path.module}/charts/argo-cd/values.yaml")
  ]
}

resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "./charts"
  chart            = "jenkins"
  namespace        = "ci-cd"
  create_namespace = true

  values = [
    file("${path.module}/charts/jenkins/values.yaml")
  ]
}



# resource "helm_release" "mimir" {
#   name             = "mimir"
#   repository       = "https://grafana.github.io/helm-charts"
#   chart            = "mimir-distributed"
#   namespace        = "monitoring"
#   create_namespace = true
#   version          = "5.1.0"

#   timeout = 900
#   wait    = true

#   values = [
#     yamlencode({
#       minio = {
#         enabled = false
#       }

#       mimir = {
#         structuredConfig = {
#           multitenancy_enabled = false
          
#           # Ring настройки для 1 реплики
#           ingester = {
#             ring = {
#               replication_factor = 1
#               heartbeat_timeout = "10m"
#               kvstore = {
#                 store = "memberlist"
#               }
#             }
#           }
          
#           distributor = {
#             ring = {
#               kvstore = {
#                 store = "memberlist"
#               }
#             }
#           }
          
#           store_gateway = {
#             sharding_ring = {
#               replication_factor = 1
#               heartbeat_timeout = "10m"
#               kvstore = {
#                 store = "memberlist"
#               }
#             }
#           }
          
#           ruler = {
#             ring = {
#               heartbeat_timeout = "10m"
#               kvstore = {
#                 store = "memberlist"
#               }
#             }
#             rule_path = "/data/ruler-data"
#           }
          
#           alertmanager = {
#             data_dir = "/data/alertmanager-data"
#             sharding_ring = {
#               replication_factor = 1
#               heartbeat_timeout = "10m"
#               kvstore = {
#                 store = "memberlist"
#               }
#             }
#           }
          
#           blocks_storage = {
#             backend = "filesystem"
#             tsdb = {
#               dir = "/data/ingester"
#             }
#             filesystem = {
#               dir = "/data/blocks"
#             }
#           }
          
#           alertmanager_storage = {
#             backend = "filesystem"
#             filesystem = {
#               dir = "/data/alertmanager-storage"
#             }
#           }
          
#           ruler_storage = {
#             backend = "filesystem"
#             filesystem = {
#               dir = "/data/ruler-storage"
#             }
#           }
          
#           compactor = {
#             data_dir = "/data/compactor"
#           }
          
#           limits = {
#             max_global_series_per_user = 0
#             ingestion_rate = 500000
#             ingestion_burst_size = 1000000
#           }
#         }
#       }

#       alertmanager = { 
#         replicas = 1
#         persistentVolume = { enabled = false }
#         zoneAwareReplication = { enabled = false }
#       }
#       compactor = { 
#         replicas = 1
#         persistentVolume = { enabled = false }
#       }
#       distributor = { replicas = 1 }
#       ingester = { 
#         replicas = 1
#         persistentVolume = { enabled = false }
#         zoneAwareReplication = { enabled = false }
#       }
#       querier = { replicas = 1 }
#       query_frontend = { replicas = 1 }
#       ruler = { replicas = 1 }
#       store_gateway = { 
#         replicas = 1
#         persistentVolume = { enabled = false }
#         zoneAwareReplication = { enabled = false }
#       }
#       nginx = { replicas = 1 }
#       overrides_exporter = { replicas = 1 }

#       "chunks-cache" = { enabled = false }
#       "index-cache" = { enabled = false }
#       "metadata-cache" = { enabled = false }
#       "results-cache" = { enabled = false }
#       rollout_operator = { enabled = false }
#     })
#   ]

#   depends_on = [helm_release.loki]
# }



# resource "helm_release" "alloy" {
#   name             = "alloy"
#   repository       = "./charts"
#   chart            = "alloy"
#   namespace        = "monitoring"
#   create_namespace = true

#   values = [
#     file("${path.module}/charts/alloy/values.yaml")
#   ]
# }