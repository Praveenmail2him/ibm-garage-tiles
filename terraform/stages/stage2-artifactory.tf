module "dev_serviceaccount_artifactory" {
  source = "../modules/cluster/serviceaccount"

  cluster_type             = "${var.cluster_type}"
  namespace                = "${module.dev_cluster_namespaces.tools_namespace_name}"
  cluster_config_file_path = "${module.dev_cluster.config_file_path}"
  service_account_name     = "artifactory-artifactory"
  sscs                     = ["anyuid", "privileged"]
}

module "dev_tools_artifactory_release" {
  source = "../modules/tools/artifactory_release"

  cluster_type             = "${var.cluster_type}"
  service_account          = "${module.dev_serviceaccount_artifactory.name}"
  cluster_ingress_hostname = "${module.dev_cluster.ingress_hostname}"
  cluster_config_file      = "${module.dev_cluster.config_file_path}"
  releases_namespace       = "${module.dev_cluster_namespaces.tools_namespace_name}"
}