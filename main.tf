provider "google" {
credentials = file ("gcp-practice-392604-396eb7215400.json")  
  project     = "gcp-practice-392604"
region  = "us-west4"
zone    = "us-west4-b"
  
}
resource "google_monitoring_alert_policy" "cpu_alert" {
  display_name = "CPU Usage Alert"
  combiner = "OR"
  conditions {
    display_name = "CPU Usage High"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period = "60s"
        
      }
      threshold_value = 70
    }
  }
  notification_channels = [
    google_monitoring_notification_channel.email.id,
  ]
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notification Channel"
  type = "email"
  labels = {
    email_address = "sreekanth.kokkanti@gmail.com"
  }
}