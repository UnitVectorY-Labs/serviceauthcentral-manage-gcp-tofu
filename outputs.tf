
output "region_service_map" {
  value = { for service in google_cloud_run_v2_service.serviceauthcentral-manage : service.location => service.name }
}
