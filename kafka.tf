provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

resource "google_compute_address" "kafka1ip" {
  name   = "${var.kafka1_instance_ip_name}"
  region = "${var.kafka_instance_ip_region}"
}
resource "google_compute_address" "kafka2ip" {
  name   = "${var.kafka2_instance_ip_name}"
  region = "${var.kafka_instance_ip_region}"
}
resource "google_compute_address" "kafka3ip" {
  name   = "${var.kafka3_instance_ip_name}"
  region = "${var.kafka_instance_ip_region}"
}


resource "google_compute_instance" "kafka1" {
  name         = "${var.instance_name1}"
  machine_type = "n1-standard-2"
  zone         = "us-east1-b"

  tags = ["name", "kafka1", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.kafka1vpc}"
    subnetwork = "${var.kafka1sub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.kafka1ip.address}"
    }
  }
  metadata = {
    name = "kafka1"
  }

  metadata_startup_script = "sudo su; sudo yum update -y;sudo yum install git -y; sudo git clone https://github.com/Diksha86/kafka-terraform.git; cd kafka-terraform ; sudo chmod 777 *; sudo sh kafka1.sh"
}
resource "google_compute_instance" "kafka2" {
  name         = "${var.instance_name2}"
  machine_type = "n1-standard-2"
  zone         = "us-east1-b"

  tags = ["name", "kafka2", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.kafka2vpc}"
    subnetwork = "${var.kafka2sub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.kafka2ip.address}"
    }
  }
  metadata = {
    name = "kafka2"
  }

  metadata_startup_script = "sudo su; sudo yum update -y;sudo yum install git -y; sudo git clone https://github.com/Diksha86/kafka-terraform.git; cd kafka-terraform ; sudo chmod 777 *; sudo sh kafka1.sh"
}
resource "google_compute_instance" "zookeeper" {
  name         = "${var.instance_name3}"
  machine_type = "n1-standard-2"
  zone         = "us-east1-b"

  tags = ["name", "zookeeper", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.kafka3vpc}"
    subnetwork = "${var.kafka3sub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.kafka3ip.address}"
    }
  }
  metadata = {
    name = "zookeeper"
  }

  metadata_startup_script = "sudo su; sudo yum update -y;sudo yum install git -y; sudo git clone https://github.com/Diksha86/kafka-terraform.git; cd kafka-terraform ; sudo chmod 777 *; sudo sh kafka.sh"
}
