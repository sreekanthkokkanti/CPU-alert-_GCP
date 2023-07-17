provider "google" {
credentials = file ("gcp-practice-392604-396eb7215400.json")  
  project     = "gcp-practice-392604"
region  = "us-west4"
zone    = "us-west4-a"
  
}

resource "google_monitoring_alert_policy" "cpu_alert" {
  display_name = "CPU Usage Alert"
  combiner = "OR"
  conditions {
    display_name = "CPU Usage High"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\" AND resource.label.instance_id=\"3061883644434497468\" OR resource.label.instance_id=\"7120643875346624852\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period = "60s"
        
      }
      threshold_value = var.threshold_value
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