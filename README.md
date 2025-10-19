docker — Containerization and Jenkins CI/CD
📖 Overview

This branch introduces Docker containerization and Jenkins-based CI/CD automation for the project.

🧱 Purpose

Containerize the Python application into a reproducible Docker image.

Automate build, test, and push processes via Jenkins.

🧰 Key Components

Dockerfile – defines how to build the image.

Jenkinsfile – defines the CI/CD pipeline with stages for:

Cloning repository

Linting and security scans

Building the Docker image

Pushing it to Docker Hub

🔐 Credentials

Docker Hub credentials are stored securely in Jenkins under dockerhub-credentials.
