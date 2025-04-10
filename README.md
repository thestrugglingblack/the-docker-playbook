```
#######                  ######                                        ######                                                  
   #    #    # ######    #     #  ####   ####  #    # ###### #####     #     # #        ##   #   # #####   ####   ####  #    # 
   #    #    # #         #     # #    # #    # #   #  #      #    #    #     # #       #  #   # #  #    # #    # #    # #   #  
   #    ###### #####     #     # #    # #      ####   #####  #    #    ######  #      #    #   #   #####  #    # #    # ####   
   #    #    # #         #     # #    # #      #  #   #      #####     #       #      ######   #   #    # #    # #    # #  #   
   #    #    # #         #     # #    # #    # #   #  #      #   #     #       #      #    #   #   #    # #    # #    # #   #  
   #    #    # ######    ######   ####   ####  #    # ###### #    #    #       ###### #    #   #   #####   ####   ####  #    # 
```


<p align="center">

![GitHub Repo Stars](https://img.shields.io/github/stars/thestrugglingblack/the-docker-playbook)
![GitHub Last Commit](https://img.shields.io/github/last-commit/thestrugglingblack/the-docker-playbook)
![GitHub Commit Activity](https://img.shields.io/github/commit-activity/m/thestrugglingblack/the-docker-playbook)
![GitHub Repo Size](https://img.shields.io/github/repo-size/thestrugglingblack/the-docker-playbook)
</p>

## 📍Table of Contents
* 👋 [Overview](#-overview)
* ✅ [Dependencies](#-dependencies)
* 🌵 [File Structure](#-file-structure)
* 🏃 [Preliminary Steps](#-preliminary-steps)
  * [AWS](#-aws)
  * [Docker](#-docker)
  * [Terraform](#-terraform)
* 🚀 [Getting Started](#getting-started)
* 📑 [Resources](#-resources)


## 👋 Overview
Visualize this! You’re on the field with less than 30 seconds in the 4th quarter. You’re juggling dependencies, battling inconsistent environments and scrambling to get your model into the end zone. You need a way to streamline your pipeline to win. This is when you decide to pull out the “Docker Playbook”, the ultimate game plan! In this seminar, we are going to take a deep dive in turning our Xs and Os into writing efficient Dockerfiles, containerizing our models and distributing them to our peers and the cloud.  At the end of the final whistle, you will have the skills to build scalable, portable and efficient pipelines that are built to win.

Slides for this workshop is located ![here]().

[![LinkedIn Badge](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/zuri-hunter-748ba514)
[![Twitter Badge](https://img.shields.io/badge/Twitter-1DA1F2?style=flat&logo=twitter&logoColor=white)](https://x.com/ZuriHunter)
[![GitHub Badge](https://img.shields.io/badge/GitHub-100000?style=flat&logo=github&logoColor=white)](https://github.com/thestrugglingblack)

## ✅ Dependencies
* [Docker](https://www.docker.com/get-started/)
* [Python (v3)](https://www.python.org/downloads/)
* [Terraform](https://developer.hashicorp.com/terraform/install)
* [AWS Account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html)


## 🌵 File Structure
```txt
├── LICENSE
├── README.md
├── model
│   ├── Dockerfile
│   ├── model.py
│   └── requirements.txt
├── scripts
│   └── ecr-login.sh
└── terraform
    └── lambda
        ├── ecr.tf
        ├── iam_ecr.tf
        ├── iam_lambda.tf
        ├── lambda.tf
        ├── providers.tf
        ├── s3.tf
        └── sns.tf
```

##  🏃 Preliminary Steps

### GitHub Actions 
- Add Docker Hub username and password. 

### ☁️ AWS 
- Provide full permissions needed for Terraform to up and deploy pipelines
- 
### 🐳 Docker 
- Sign up to DockerHub to share amongst friends locally.
- Push up Docker image to ECR

### 🪨 Terraform 
- Install Terraform

## 🚀 Getting Started
- Run docker build 
- Run terraform init
- Run terraform apply

## 📑 Resources
* [Terraform Tutorial](https://spacelift.io/blog/terraform-tutorial)
* [Docker Tutorial For Beginners](https://www.youtube.com/watch?v=fqMOX6JJhGo)
