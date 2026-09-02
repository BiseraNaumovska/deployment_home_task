## Deployment Home Task

This repository contains a complete home task implementation for a deployment/infrastructure scenario featuring a containerized PostgreSQL and Nginx setup with Prometheus and Grafana monitoring, explicit log monitoring with Loki and Promtail, fully packaged Kubernetes manifests and Helm Charts with Ingress TLS & HorizontalPodAutoscale, and automated GitHub Actions CI/CD pipelines.

---

## Quick Start (5 Commands)

Run these from the repository root:

```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml --syntax-check
docker compose --env-file .env -f docker-compose/docker-compose.yml up -d
curl -I http://localhost:8080 && curl -k -I https://localhost:8443
docker exec postgres_db psql -U db_admin -d active_network_db -c "SELECT COUNT(*) FROM active_network_equipment;"
kubectl apply --dry-run=client -f k8s/
```

Expected result summary:
- Ansible syntax check passes
- All compose services are up
- HTTP and HTTPS return status 200
- Database contains at least 30 rows in `active_network_equipment`
- Kubernetes manifests validate successfully

---

## Architecture Overview

The repository is structured into two main environments:
* **`develop` (Non-Production):** Main branch for active development, integration, and feature testing.
* **`main` (Production):** Production branch updated exclusively via automated GitHub Actions with timestamped tagging and with available Rollback version mechanism


## Core Components
* **Nginx Webserver:** Reverse proxy handling incoming web requests.
* **PostgreSQL Database:** Primary persistent relational database.
* **Prometheus:** Collects system and container metrics.
* **Loki + Promtail:** Collect and centralize container logs for explicit log monitoring.
* **Grafana:** Visualizes metrics and performance dashboards.
* **Alertmanager:** Handles alerts routed from Prometheus metrics.
* **Kubernetes Stack:** Packaged via Helm including Deployment, ClusterIP Service, Ingress (TLS enabled) and Horizontal Pod Autoscaler.

---

## Repository Structure
```text
deployment_home_task/
├── .env
├── .gitignore
├── README.md
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbook.yml
│   └── roles/
│       ├── compose_deploy/
│       │   └── tasks/
│       │       └── main.yml
│       ├── docker_runtime/
│       │   └── tasks/
│       │       └── main.yml
│       └── ssh_hardening/
│           ├── handlers/
│           │   └── main.yml
│           └── tasks/
│               └── main.yml
├── backups/
│   ├── db_backup_20260831_234739.sql
│   └── db_backup_20260831_235349.sql
├── docker-compose/
│   ├── alertmanager/
│   │   └── alertmanager.yml
│   ├── backup.sh
│   ├── blackbox/
│   │   └── blackbox.yml
│   ├── docker-compose.yml
│   ├── grafana/
│   │   └── provisioning/
│   │       ├── dashboards/
│   │       └── datasources/
│   │           ├── loki.yml
│   │           └── prometheus.yml
│   ├── html-http/
│   │   └── index.html
│   ├── html-https/
│   │   └── index.html
│   ├── init-db/
│   │   └── 01-init.sql
│   ├── loki/
│   │   └── loki-config.yml
│   ├── nginx/
│   │   ├── nginx.conf
│   │   └── ssl/
│   │       ├── nginx.crt
│   │       └── nginx.key
│   ├── prometheus/
│   │   ├── alert.rules.yml
│   │   └── prometheus.yml
│   ├── promtail/
│   │   └── promtail-config.yml
│   ├── restore.sh
│   └── test-alert.sh
├── files/
│   ├── 01_Deployment_Home_Task.drawio.png
│   ├── 02_Generating_SSL_Certificate_for_HTTPS.png
│   ├── 03_Ansible_run_and_containers_verification.png
│   ├── 04_checking_http_https_database.png
│   ├── 05_Apply_kubernetes_deployment_service.png
│   ├── 06_Terraform_init-plan_1.png
│   ├── 07_Terraform_plan_2.png
│   ├── 08_Terraform_apply_unsuccessfull.png
│   ├── 09_Terraofrm_apply_successfull.png
│   ├── 10_Testing_database_backup.png
│   ├── 11_Testing_restore_and_backup.png
│   ├── 12_Prometheus_check_fix.png
│   ├── 13_Prometheus.png
│   ├── 14_Grafana_Dashboard_monitoring.png
│   ├── 15_Mail_integration.png
│   ├── 16_Mail_Alerting_manual_testing.png
│   ├── 17_Mail_Alerts.png
│   ├── 18_Github_secrets.png
│   ├── 19_Database_backup-artifacts.png
│   └── 20_Loki_logs.png
├── .github/
│   └── workflows/
│       ├── db-backup.yml
│       ├── db-restore.yml
│       ├── develop-to-main.yaml
│       ├── infrastructure_validation.yml
│       └── rollback-prod.yml
├── helm/
│   └── webserver-chart/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── hpa.yaml
│           ├── ingress.yaml
│           └── service.yaml
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
└── terraform/
    ├── .terraform.lock.hcl
    ├── main.tf
    ├── terraform.tfstate
    └── terraform.tfstate.backup
```

## Most Important Files and What They Do

| File                                              | Purpose                                                                               |
|---------------------------------------------------|---------------------------------------------------------------------------------------|
| `docker-compose/docker-compose.yml`               | Main stack definition for DB, web server, monitoring, and alerting services.          |
| `docker-compose/nginx/nginx.conf`                 | Configures HTTP + HTTPS virtual servers, SSL, and HTTP IP allowlist restrictions.     |
| `docker-compose/init-db/01-init.sql`              | Creates `active_network_equipment` and inserts 30 mock records.                       |
| `ansible/playbook.yml`                            | Hardens SSH (key-only style) and deploys the Compose stack.                           |
| `ansible/inventory/hosts.ini`                     | Defines target host group (`remote_server`), currently mapped to localhost.           |
| `docker-compose/prometheus/prometheus.yml`        | Prometheus scrape configuration and alert rule loading.                               |
| `docker-compose/prometheus/alert.rules.yml`       | Alert definitions (high CPU and webserver availability check).                        |
| `docker-compose/loki/loki-config.yml`             | Loki configuration for centralized log storage and querying.                          |
| `docker-compose/promtail/promtail-config.yml`     | Promtail configuration for collecting Docker logs and shipping to Loki.               |
| `docker-compose/grafana/provisioning/datasources/loki.yml` | Grafana datasource for log exploration from Loki.                            |
| `docker-compose/alertmanager/alertmanager.yml`    | Email alert routing and SMTP configuration.                                           |
| `k8s/deployment.yaml`                             | Basic Kubernetes Deployment for Nginx with 2 replicas and resource limits.            |
| `k8s/service.yaml`                                | Exposes Kubernetes Nginx pods via NodePort.                                           |
| `terraform/main.tf`                               | Provisions a local Docker-based VPS-style container and network via Terraform.        |
| `.github/workflows/infrastructure_validation.yml` | CI validation for Ansible syntax, Helm lint command, and K8s dry-run apply.           |
| `.github/workflows/db-backup.yml`                 | Manual/scheduled DB backup workflow using Compose + backup script + artifact upload.  |
| `.github/workflows/db-restore.yml`                | Manual DB restore workflow and before/after row count verification.                   |
| `docker-compose/backup.sh`                        | Creates full or schema-only PostgreSQL backups.                                       |
| `docker-compose/restore.sh`                       | Restores DB from selected or latest backup file.                                      |



## Evidence Artifacts
The `files/` directory contains screenshots and execution evidence for:
- SSL generation
- Ansible run and container checks
- Kubernetes apply
- Terraform plan/apply
- Backup/restore testing
- Prometheus and Grafana dashboards
- Mail alert integration and test alerts
- GitHub secrets/workflow evidence


## Architecture and Design Documentation 

## Design Summary
This solution uses Docker Compose as the primary runtime environment and keeps Kubernetes as an additional required deliverable for the web tier.

- Runtime and services: Docker Compose
- Infrastructure automation: Ansible
- Infrastructure provisioning: Terraform (local Docker-based VPS-like host)
- Monitoring and alerting: Prometheus, Node Exporter, Blackbox Exporter, Alertmanager
- Log monitoring: Loki + Promtail, visualized in Grafana
- Visualization: Grafana
- Database: PostgreSQL with initialization SQL
- Kubernetes deliverable: Nginx Deployment + Service

## Assumptions
- The repository is executed in a local/lab environment first, then adapted to a real VPS.
- Required secrets are provided via `.env` locally and via GitHub Secrets in CI.
- HTTPS uses provided/self-managed cert/key files mounted into Nginx.
- Prometheus availability checks are based on HTTP/HTTPS probes through Blackbox Exporter.
- Docker container logs are collected by Promtail and sent to Loki.

### Limitations
- The current inventory includes localhost for easy testing; remote hosts must be added for full multi-host deployment.
- Terraform targets a local Docker engine (VPS-like simulation), not a public cloud VM by default.
- Alerting is configured for email; additional channels (Slack/Teams) are not enabled yet.
- Loki retention and advanced log parsing are kept minimal for this home-task scope.


## 4. Brief Report (Work Summary and Challenges)

### Work Summary
Completed implementation includes:
- Nginx web server on HTTP and HTTPS with separate HTML pages
- HTTP IP allowlist and TLS setup in Nginx
- PostgreSQL with required `active_network_equipment` schema and 30 mock records
- Docker Compose stack for application, database, monitoring, and alerting
- Explicit log monitoring with Loki + Promtail integrated into Grafana
- Ansible playbook for SSH hardening, Docker runtime setup, and stack deployment
- Kubernetes basic manifests (Deployment + Service)
- Helm chart with optional advanced Kubernetes resources
- CI workflows for infrastructure validation and DB backup/restore automation

## Main Challenges Faced
- Keeping balance between required complexity and bonus features
- Coordinating multiple tools (Ansible, Compose, Terraform, K8s, Helm, GitHub Actions)
- Discovering Grafana, Prometheus, Loki and Promtail


## VPS Access Details
## Local VPS Access
- SSH: host `22223` -> container `22`
- HTTP: host `8082` -> container `80`
- HTTPS: host `8444` -> container `443`
- Grafana: host `3002` -> container `3000`
- Prometheus: host `9092` -> container `9090`

The Terraform-provisioned local VPS-like container starts `sshd` automatically and enables key-based SSH access by provisioning the local public key from `~/.ssh/id_rsa.pub` into the container.

Note: this key provisioning is a local demo convenience assumption for the home-task environment and depends on the host machine already having `~/.ssh/id_rsa.pub` available.

## Example Access Commands
- Check provisioned container:
    `docker ps | grep DevOps-HomeTask-VPS`
- Verified SSH access command:
    `ssh -i ~/.ssh/id_rsa -p 22223 root@localhost`

For a real remote VPS, replace localhost with the server public IP and set host entries in `ansible/inventory/hosts.ini`.


## How To Test The Whole Solution

### 1) Ansible syntax validation
`ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml --syntax-check`

### 2) Compose file validation
`docker compose --env-file .env -f docker-compose/docker-compose.yml config`

### 3) Start full stack
`docker compose --env-file .env -f docker-compose/docker-compose.yml up -d`

### 4) Verify running containers
`docker compose -f docker-compose/docker-compose.yml ps`

### 5) Verify web endpoints
- HTTP: `curl -I http://localhost:8080`
- HTTPS: `curl -k -I https://localhost:8443`

### 6) Verify database data count (must be >= 30)
`docker exec postgres_db psql -U db_admin -d active_network_db -c "SELECT COUNT(*) FROM active_network_equipment;"`

### 7) Verify monitoring targets
`curl -s http://localhost:9090/api/v1/targets`

### 8) Verify probe metric for web availability
`curl -s 'http://localhost:9090/api/v1/query?query=probe_success'`

### 9) Verify Loki readiness (log backend)
`curl -s http://localhost:3100/loki/api/v1/query`

### 10) Verify logs are searchable in Loki
`curl -sG 'http://localhost:3100/loki/api/v1/query' --data-urlencode 'query={job="docker-logs"}'`

### 11) Validate Kubernetes manifests
`kubectl apply --dry-run=client -f k8s/`

### 12) Validate Helm chart
`helm lint helm/webserver-chart`

### 13) Optional: test alerting path
`./docker-compose/test-alert.sh`


## Future Possible Improvements

- Add a real `ansible-lint` execution step in the infrastructure validation workflow, not only Ansible syntax check.
- Add a `docker compose --env-file .env -f docker-compose/docker-compose.yml config` validation step in CI to verify the main runtime stack configuration.
- Add a lightweight smoke test in the backup and restore workflows to verify DB readiness and expected table/data state.




