provider "google" {
  project=var.gcp_project
}

resource "google_project_service" "workflows" {
  service            = "workflows.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "workflow-sa" {
  account_id   = "workflow-service-account"
  display_name = "Workflow Service Account"
}


data "local_file" "input" {
  filename = "workflow.yaml"
}


resource "google_workflows_workflow" "example" {
  name          = "workflow"
  region        = "us-central1"
  description   = "Magic"
  service_account = google_service_account.workflow-sa.id
  source_contents = data.local_file.input.content
}
