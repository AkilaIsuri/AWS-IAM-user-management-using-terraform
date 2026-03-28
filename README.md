# 🚀 AWS IAM User Management using Terraform

## 📌 Project Overview

This project demonstrates how to **automate AWS IAM user management** using Terraform with best practices.

It includes:

* Dynamic user creation from a CSV file
* Group-based access control (RBAC)
* IAM policy attachment
* Multi-Factor Authentication (MFA) enforcement
* Scalable and maintainable infrastructure design

---

## 🧱 Architecture

```
CSV File → Terraform → IAM Users → IAM Groups → IAM Policies → MFA Enforcement
```

---

## ⚙️ Features

### ✅ 1. User Creation from CSV

* Users are defined in `users.csv`
* Terraform reads and converts CSV into a list of objects using:

  ```hcl
  csvdecode(file("users.csv"))
  ```

---

### ✅ 2. Dynamic IAM User Creation

* Users are created using `for_each`
* Unique usernames are generated automatically

---

### ✅ 3. Group-Based Access Control (RBAC)

* Groups are dynamically created based on departments
* Users are assigned to groups based on their department

---

### ✅ 4. IAM Policy Management

* Policies are attached to groups (not users)
* Supports both:

  * AWS managed policies
  * Custom policies

---

### ✅ 5. MFA Enforcement 🔐

* Custom IAM policy enforces MFA
* Users must enable MFA to access AWS services
* Uses condition:

  ```json
  "aws:MultiFactorAuthPresent": "false"
  ```

---

## 📂 Project Structure

```
.
├── main.tf
├── provider.tf
├── users.tf
├── groups.tf
├── data.tf
├── locals.tf
├── output.tf
├── users.csv
├── .gitignore
└── .terraform.lock.hcl
```

---

## 🔧 Setup Instructions

### 1️⃣ Clone Repository

```bash
git clone https://github.com/AkilaIsuri/AWS-IAM-user-management-using-terraform.git
cd AWS-IAM-user-management-using-terraform
```

---

### 2️⃣ Initialize Terraform

```bash
terraform init
```

---

### 3️⃣ Preview Changes

```bash
terraform plan
```

---

### 4️⃣ Apply Configuration

```bash
terraform apply
```

---

## ⚠️ Important Notes

* `.terraform/` and `.tfstate` files are ignored using `.gitignore`
* Sensitive data should not be committed
* MFA must be configured manually by users after login

---

## 🧠 Best Practices Implemented

* ✅ Infrastructure as Code (IaC)
* ✅ DRY principle using `for_each`
* ✅ Least privilege access
* ✅ RBAC (Role-Based Access Control)
* ✅ MFA enforcement for security
* ✅ Clean Git workflow with feature branches

---

## 🚀 Future Improvements

* Add remote backend (S3 + DynamoDB)
* CI/CD pipeline using GitHub Actions
* Fine-grained policies per department
* Automated reporting/dashboard

