resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = module.vpc.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]

  depends_on = [module.vpc]
}
