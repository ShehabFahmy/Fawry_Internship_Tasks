## Q1 : **CI/CD with DevSecOps for Spring Boot Application Using GitLab**

---

This project implements a **secure and automated CI/CD pipeline** for a Spring Boot microservice using **GitLab CI/CD**, adhering to modern **DevSecOps practices**. It streamlines the entire development-to-deployment lifecycle by automating build, testing, security scanning, and deployment processes. Security is integrated at every stage of the pipeline to ensure a safe and reliable software delivery process.

---

### **Objectives:**

- Automate the CI/CD workflow for a Java Spring Boot application.
- Integrate **security scanning tools** to perform SAST, dependency, and container scans.
- Enable secure deployment to staging or production environments using **GitLab Runners**, **Docker**, or **Kubernetes**.

---

### **Application Properties**
- Spring Boot version: `3.2.0`
- Java version: `17`
- Maven version: `3.9.9`

---

### **Pipeline Stages:**

1. **Build Stage:**
    - Compile Java code using **Maven** or **Gradle**.
2. **Test Stage:**
    - Execute unit and integration tests using **JUnit**.
3. **SAST (Static Application Security Testing):**
    - Analyze source code using **GitLab SAST** or **SonarQube**.
4. **Dependency Scanning:**
    - Scan for vulnerable third-party libraries using **OWASP Dependency-Check** or **Trivy**.
5. **Container Scanning:**
    - Check Docker image for known vulnerabilities using **Trivy** or GitLab's built-in scanning tools.
6. **Deploy Stage:**
    - Deploy the application to a Docker container, a staging environment, or **Kubernetes**.
7. **DAST (Dynamic Application Security Testing) [Optional]:**
    - Perform endpoint security testing using **OWASP ZAP**.

---

### **Tools & Stack:**

- **Language:** Java (Spring Boot)
- **Build Tool:** Maven / Gradle
- **CI/CD:** GitLab CI/CD
- **Security Tools:**
    - **SAST:** GitLab SAST, SonarQube
    - **Dependency Scanning:** OWASP Dependency-Check, Trivy
    - **Container Scanning:** Trivy
    - **DAST:** OWASP ZAP (optional)
- **Testing:** JUnit, Postman/Newman (for API tests)
- **Deployment:** Docker, Kubernetes, GitLab Runners

---

### **Outcome:**

The result is a **robust, secure, and fully automated CI/CD pipeline** that integrates best practices from the DevSecOps methodology. It enables rapid and secure delivery of Java-based applications, reducing manual effort, enhancing code quality, and mitigating security risks early in the development lifecycle.

<p align="center">
  <img src="final-result.png">
</p>

---
