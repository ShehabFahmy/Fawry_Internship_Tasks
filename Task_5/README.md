# FlaskApp with MySQL on Kubernetes (with Kustomize)

This project demonstrates deploying a **Flask web application** with a **MySQL database backend** on a Kubernetes cluster using **Kustomize** for environment-specific customization.

The setup follows best practices for containerization, persistence, secret management, and environment overlays for **testing** and **production**.

---

## 📂 Project Structure

```
.
├── docker-compose.yml        # Local testing with Docker Compose
├── flaskapp/                 # Flask application source code
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── static/               # Static assets (CSS, JS)
│   └── templates/            # HTML templates & SQL schema
├── mysql/                    # MySQL Docker build context
│   ├── BucketList.sql
│   └── Dockerfile
└── k8s/                      # Kubernetes manifests with Kustomize
    ├── base/                 # Common base manifests
    │   ├── flaskapp/         # Deployment & Service for FlaskApp
    │   ├── mysql/            # StatefulSet & Service for MySQL
    │   ├── common/           # Shared configs: LimitRange, NetworkPolicy
    │   └── kustomization.yaml
    └── overlays/             # Environment-specific overlays
        ├── testing/          # Testing setup (PV/PVC, 1 replica, low resources)
        └── production/       # Production setup (3 replicas, ingress, higher resources)
```

---

## 🚀 Project Objectives

- Containerize a **Flask web app** with a **MySQL database** backend.
- Push Docker images to **DockerHub** (at least one private repository).
- Deploy to a **Kubernetes cluster** (Minikube is not allowed).
- Use Kustomize for **environment-specific overlays**.
- Implement:

  - **Deployment** for FlaskApp.
  - **StatefulSet** for MySQL (persistence & stable identity).
  - **ConfigMaps** for environment configuration.
  - **Secrets** for sensitive data & DockerHub registry credentials.
  - **Services** (ClusterIP) for internal communication.
  - **Ingress** (via NGINX Ingress Controller) to expose `/flask`.
  - **NetworkPolicy**, **LimitRange**, and **resource requests/limits**.
  - **Liveness, readiness, and startup probes**.
  - **PersistentVolumeClaims (PVCs)** for MySQL data persistence.

---

## 🐳 Local Development (with Docker Compose)

For quick local testing without Kubernetes, you can use Docker Compose.

### Start the services

```bash
docker-compose up --build
```

### Access the Flask app

Open your browser at:
```
http://localhost:5000
```

### Stop the services

```bash
docker-compose down
```

---

## 🐳 Containerization

### FlaskApp

- Defined in [flaskapp/Dockerfile](flaskapp/Dockerfile).
- Runs on Python, installs dependencies from [flaskapp/requirements.txt](flaskapp/requirements.txt).
- Contains routes, static files, and templates.

### MySQL

- Defined in [mysql/Dockerfile](mysql/Dockerfile).
- Initializes schema from [mysql/BucketList.sql](mysql/BucketList.sql).

### Build & Push

```bash
# Build
docker build -t <dockerhub-username>/flaskapp:latest ./flaskapp
docker build -t <dockerhub-username>/mysql:latest ./mysql

# Push
docker push <dockerhub-username>/flaskapp:latest
docker push <dockerhub-username>/mysql:latest
```

---

## ☸️ Kubernetes Deployment with Kustomize

### Testing Environment
- 1 replica
- Lower CPU/Memory limits
- PVC for persistence
```bash
kubectl apply -k k8s/overlays/testing
```

### Production Environment
- 3 replicas
- Higher CPU/Memory limits
- Ingress enabled
```bash
kubectl apply -k k8s/overlays/production
```

---

## 🔑 Secrets & Configurations

- **Secrets**: Store MySQL credentials and DockerHub registry credentials securely.
- **ConfigMaps**: Provide environment variables (DB host, DB name, etc.).

Example environment variables for FlaskApp Deployment:
```yaml
MYSQL_DATABASE_USER: "root"
MYSQL_DATABASE_PASSWORD: "root"
MYSQL_DATABASE_DB: "BucketList"
MYSQL_DATABASE_HOST: "db-service"
```

---

## 🌐 Ingress
Ingress is configured to expose the FlaskApp at the path `/flask`:
- `http://<cluster-ip-or-domain>/flask` → FlaskApp Service.

Test with:
    ```bash
    curl http://<worker-node-ip>/flask
    ```

---

## 📊 Environment Differences

| Feature      | Testing  | Production |
| ------------ | -------- | ---------- |
| Replicas     | 1        | 3          |
| CPU Limit    | 200m     | 500m       |
| Memory Limit | 256Mi    | 1024Mi     |
| PVC          | Yes      | Yes        |
| Ingress      | Optional | Required   |

---

## ✅ Validation & Testing

- Verify FlaskApp ↔ MySQL connectivity.
- Access app via:
  - `NodePort` (for debugging).
  - `Ingress /flask` path (production).
- Confirm persistent storage:
  ```bash
  kubectl get pvc
  ```
- Check probes:
  ```bash
  kubectl describe pod <flaskapp-pod>
  ```
- Ensure secrets are injected properly:
  ```bash
  kubectl get secret
  ```

---
