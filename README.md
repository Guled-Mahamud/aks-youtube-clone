# **Overview**

This project runs a **YouTube-clone web app** on a production-ready **Azure Kubernetes Service (AKS)** cluster, with everything managed through a GitOps workflow. **Terraform** takes care of all the Azure infrastructure networking, AKS, and an **Azure Container Registry (ACR)** for storing Docker images while **GitHub Actions** handles the CI/CD pipeline so changes move from code to production automatically.

Traffic is routed through the **NGINX Ingress Controller**, which provides secure, efficient access with built-in **HTTPS**. The setup is designed to grow with demand and stay secure, with:

- **Cert-Manager** issuing SSL certificates automatically
- **ExternalDNS** keeping DNS records up to date in Cloudflare
- **Helm** managing Kubernetes packages with clean, repeatable installs
- **ArgoCD** keeping the cluster in sync with the Git repo
- **Prometheus & Grafana** delivering detailed monitoring and dashboards

---

## :memo:**Architecture Diagram**

 ![AD](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/AD.png)

## **🎥Youtube Clone Demo**


![App Demo](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/app.gif)


---

## :key:**Key Components**

| Component | What it Does |
| --- | --- |
| **Azure Kubernetes Service (AKS)** | Runs the production-grade Kubernetes cluster that hosts the YouTube-clone app. |
| **Azure Container Registry (ACR)** | Stores and manages our Docker images securely, ready for AKS to pull during deployments. |
| **GitHub Actions (CI/CD)** | Automates the whole pipeline – building, testing, scanning, and deploying both the app and the infrastructure. |
| **Terraform** | Handles all the Azure infrastructure using Infrastructure-as-Code, so everything is consistent and repeatable. |
| **Helm** | Makes it easy to install and manage Kubernetes apps like ArgoCD, Prometheus, and NGINX Ingress with reusable charts. |
| **ArgoCD** | Keeps the cluster in sync with the Git repo using GitOps, so what’s in Git is what’s running in AKS. |
| **NGINX Ingress Controller** | Routes HTTP/HTTPS traffic inside the cluster and takes care of SSL termination. |
| **Cert-Manager** | Gets and renews SSL certificates from Let’s Encrypt automatically for secure HTTPS. |
| **ExternalDNS** | Works with Cloudflare to automatically update DNS records based on Kubernetes Ingress changes. |
| **Prometheus** | Gathers and stores metrics from the cluster and applications for monitoring. |
| **Grafana** | Displays Prometheus data on dashboards so you can track performance and spot issues fast. |
| **Trivy** | Scans Docker images for security vulnerabilities during the CI build. |
| **TFLint** | Checks Terraform code for syntax issues and best practice violations before applying changes. |
| **Checkov** | Scans Terraform for security and compliance issues to catch problems early. |

---

## :arrow_up_down: **Project Structure**

```
├── .github/
│   └── workflows/                  # GitHub Actions workflows for CI/CD
│       ├── push-docker-image.yml    
│       ├── terraform-apply.yml      
│       ├── terraform-destroy.yml    
│       └── terraform-plan.yml       
│
├── app/                             # YouTube-clone application source code
│   ├── public/                      
│   ├── src/                         
│   ├── package.json                 
│   └── package-lock.json
│
├── k8s-manifests/                    # Kubernetes manifests for GitOps
│   ├── apps/                         
│   ├── values/                       
│   ├── youtube-clone/                
│   ├── app-of-apps.yaml               
│   └── issuer.yaml                    
│
├── terraform/                         # Terraform IaC for Azure infrastructure
│   ├── modules/                       
│   ├── backend.tf                     
│   ├── main.tf                         
│   ├── outputs.tf                      
│   ├── provider.tf                     
│   └── variables.tf                    
│
├── .dockerignore                       
└── .gitignore      
```        

---


## :large_blue_circle: Azure Deployment Workflow


This project takes the **YouTube-clone app** from code to production on Azure using a GitOps-driven workflow with **AKS**, **Terraform**, and **GitHub Actions**. Here’s how it all comes together:

---

### 1. Containerising the App

The app is packaged into a Docker image using the `Dockerfile` in the `app/` folder. This guarantees that it runs the same way in development, staging, and production.

---

### 2. Build & Push to Azure Container Registry (ACR)

Whenever code is pushed to the **main** branch, the `push-docker-image.yml` workflow kicks in:

- Builds the Docker image
- Runs a **Trivy** scan for security vulnerabilities
- Pushes the image to **Azure Container Registry** so it’s ready for deployment

---

### 3. Validating Infrastructure Changes (Pull Requests)

If a pull request changes Terraform files, the `terraform-plan.yml` workflow runs automatically:

- `terraform plan` previews what will change in Azure
- **TFLint** checks for Terraform syntax issues and best practices
- **Checkov** scans for security and compliance issues

---

### 4. Provisioning Infrastructure (Merge to Main)

When changes are approved and merged, the `terraform-apply.yml` workflow updates or creates all required Azure resources with Terraform:

- **AKS cluster**
- **ACR**
- Networking & DNS
- Managed identities
- Any other supporting infrastructure

---

### 5. GitOps with ArgoCD

ArgoCD keeps the AKS cluster in sync with the Kubernetes manifests in `k8s-manifests/`. Any change pushed to Git is automatically reflected in the live cluster.

---

### 6. Ingress, HTTPS, and DNS

- **NGINX Ingress Controller** routes web traffic inside the cluster
- **Cert-Manager** automatically requests and renews SSL certificates via Let’s Encrypt
- **ExternalDNS** works with Cloudflare to keep DNS records up to date in real time

---

### 7. Monitoring & Dashboards

- **Prometheus** collects metrics from the cluster and workloads
- **Grafana** turns those metrics into real-time, visual dashboards for quick insights


---


## :black_circle: ArgoCD: GitOps Deployment to AKS

The YouTube-clone app is deployed to AKS via **ArgoCD**, which syncs the cluster with the Kubernetes manifests in k8s-manifests/ so it always matches the Git source of truth.

![Argocd](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/argocd.gif)



## :chart_with_upwards_trend:Prometheus & Grafana

 **Prometheus** collects metrics from AKS and workloads, while **Grafana** turns them into real-time dashboards and alerts for cluster and app health.

 #### Prometheus Dashboard:

![prom](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/monitor.png)

 #### Grafana Dashboard:


 ![grafana1](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/grafana2.png)


 ![grafana2](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/grafana.png)


---


## :newspaper: Cloudflare DNS Setup

The YouTube-clone platform and its monitoring tools are all reachable via custom subdomains managed in **Cloudflare**.

Current records:

- `youtube.guled.co.uk` → YouTube-clone app
- `grafana.guled.co.uk` → Grafana dashboards
- `prometheus.guled.co.uk` → Prometheus UI
- `argocd.guled.co.uk` → ArgoCD UI

All records point to the Azure **NGINX Ingress Controller** public IP (`51.141.33.41`). **ExternalDNS** keeps them in sync automatically, and **Cert-Manager** issues SSL certificates so each service is accessible securely over HTTPS.

 ![cloudflare](https://github.com/Guled-Mahamud/aks-youtube-clone/blob/main/docs/cloudflare.png)



 ----
### Website link

https://youtube.guled.co.uk
----
#### :page_facing_up: Licence

Licensed under the MIT Licence.
