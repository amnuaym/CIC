# GCP Service Account Key Setup Guide

To deploy the Customer Information Center (CIC) application to Google Cloud Platform (GCP) using the provided Terraform manifests and deployment scripts, you must configure a Google Cloud service account with the necessary IAM permissions and save its JSON credential key to the root of this repository.

This guide outlines the step-by-step process.

---

## Step 1: Create a Service Account in GCP

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Select your target **GCP Project** from the top dropdown menu.
3. In the left-hand navigation menu, go to **IAM & Admin** > **Service Accounts**.
4. Click **+ Create Service Account** at the top of the page.
5. Provide a descriptive name and description:
   * **Service account name**: `cic-deployment-sa`
   * **Service account ID**: Automatically generated (e.g., `cic-deployment-sa@your-project-id.iam.gserviceaccount.com`)
   * **Service account description**: Service account for CIC Jenkins CI/CD, Terraform, and GKE deployments.
6. Click **Create and Continue**.

---

## Step 2: Assign IAM Roles (Permissions)

To allow the deployment script and Terraform to provision networks, load balancers, Cloud SQL databases, and deploy workloads to GKE and Cloud Run, you must grant the service account the appropriate roles.

### Option A: Fine-Grained Least Privilege Roles (Recommended)
Add the following roles to the service account during the "Grant this service account access to project" step:

| Role Name | IAM Role Identifier | Purpose |
| :--- | :--- | :--- |
| **Service Usage Admin** | `roles/serviceusage.serviceUsageAdmin` | Enabling GCP Service APIs (Compute, SQL, Cloud Run, Secret Manager). |
| **Compute Admin** | `roles/compute.admin` | Provisioning VPC networks, subnets, NEGs, and Load Balancers. |
| **Kubernetes Engine Admin** | `roles/container.admin` | Deploying Kubernetes manifests to the GKE Cluster. |
| **Cloud SQL Admin** | `roles/cloudsql.admin` | Provisioning private PostgreSQL Cloud SQL instance. |
| **Artifact Registry Administrator** | `roles/artifactregistry.admin` | Pushing/Pulling docker images to/from Artifact Registry. |
| **Cloud Run Developer** | `roles/run.developer` | Creating and configuring the backend & frontend Cloud Run services. |
| **Secret Manager Admin** | `roles/secretmanager.admin` | Storing and managing the API's JWT signing secret. |
| **Project IAM Admin** | `roles/resourcemanager.projectIamAdmin` | Granting `roles/run.invoker` member access to Cloud Run. |

### Option B: Broad Roles (For Development/Sandbox Environments Only)
For sandbox or prototyping environments where you want to simplify role assignment, you can assign:
* **Editor** (`roles/editor`) or **Owner** (`roles/owner`)

Click **Continue**, then click **Done**.

---

## Step 3: Generate and Download the JSON Key

1. In the **Service Accounts** list, locate the service account you just created (`cic-deployment-sa`).
2. Click the three vertical dots (Actions) in the service account's row and select **Manage keys**.
3. Click **Add Key** > **Create new key**.
4. Select **JSON** as the key type and click **Create**.
5. The JSON file containing your private key credentials will automatically download to your computer.

---

## Step 4: Save the Key File in your Workspace

1. Locate the downloaded JSON file on your machine.
2. Rename the file to exactly **`gcp-key.json`**.
3. Move or copy the file into the **root** of this repository:
   * Target Path: `D:/Github/CIC/gcp-key.json`

> [!WARNING]
> Keep this file secure. The `gcp-key.json` contains private cryptographic keys that grant administrative access to your GCP resources.
> * Never commit this file to Git. The project's `.gitignore` is pre-configured to exclude `gcp-key.json` to prevent accidental leaks.

---

## Step 5: Test Authentication

Once the key file is in place, you can test authentication by executing the setup verification check. Run the script from a PowerShell or Bash shell:

### PowerShell
```powershell
# Run the deployment script with your Project ID to test authentication
powershell -ExecutionPolicy Bypass -File D:\Github\CIC\prod-setup\gcp\deploy.ps1
```

### Bash
```bash
# Set execute permissions and run the deployment script
chmod +x D:/Github/CIC/prod-setup/gcp/deploy.sh
D:/Github/CIC/prod-setup/gcp/deploy.sh
```

If the file is found and valid, the script will successfully output:
`[+] Authenticating using Service Account Key...` and authenticate your local `gcloud` CLI session.
