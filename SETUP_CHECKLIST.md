# Azure DevOps Terraform Setup Checklist

## ✅ Configuration Summary

### Azure Resources
- **Subscription ID**: `ac735d05-0b35-4660-a3e3-6df6aedfe159`
- **Tenant ID**: `35824eec-b13e-4418-9f26-cc68a453ae60`

### Terraform State Storage
- **Resource Group**: `eli7e-terraform-state-rg`
- **Storage Account**: `eli7estorage`
- **Container**: `eli7e-tfstate`
- **State File**: `prod.terraform.tfstate`
- **Full URL**: `https://eli7estorage.blob.core.windows.net/eli7e-tfstate/prod.terraform.tfstate`

### Virtual Machine Scale Set
- **Name**: `kaka-vmss-scaleset`
- **Script**: `terraform-script.sh` (installs Terraform, Azure CLI, Git, etc.)

### Azure DevOps
- **Organization**: `https://dev.azure.com/JJalaliDevOps01`
- **Agent Pool**: `kaka_vmss`
- **Service Connection**: `eli7e_service_connection_vmss`
- **Service Connection ID**: `6c2f14a2-c336-48ee-9562-d96f052e9e00`

### GitHub Repository
- **URL**: `https://github.com/crs-infra/Azure_DevOps_terrafrom.git`

---

## 🔧 Setup Steps

### 1. Azure Prerequisites
- [ ] Verify service connection `eli7e_service_connection_vmss` exists in Azure DevOps
- [ ] Verify service principal has proper permissions:
  - [ ] Storage Blob Data Contributor on `eli7estorage`
  - [ ] Contributor on target resource groups
- [ ] Verify VMSS `kaka-vmss-scaleset` is running
- [ ] Verify agent pool `kaka_vmss` is configured

### 2. Repository Setup
- [ ] Connect GitHub repo to Azure DevOps project
- [ ] Ensure pipeline is configured to trigger on `main` branch
- [ ] Verify service connection authorization for pipeline

### 3. Security
- [ ] **IMPORTANT**: Remove `terraform.tfstate*` files from Git history if committed
- [ ] **IMPORTANT**: Remove `set-azure-env.sh` from Git history if committed
- [ ] Verify `.gitignore` is working: `git status` should not show sensitive files
- [ ] Store secrets in Azure Key Vault or Azure DevOps Library

### 4. VMSS Agent Setup
- [ ] Deploy agents to VMSS using `terraform-script.sh`
- [ ] Verify agents are online in Azure DevOps agent pool
- [ ] Test agent connectivity

### 5. Pipeline Testing
- [ ] Run Build stage and verify success
- [ ] Check Terraform init/validate/plan work correctly
- [ ] Deploy to production environment
- [ ] Verify infrastructure is created

---

## 🚨 Security Reminders

### Files to NEVER commit to Git:
- `terraform.tfstate*` - Contains sensitive resource data
- `set-azure-env.sh` - Contains service principal secrets
- `*.tfvars` - May contain sensitive configuration
- `.terraform/` - Local Terraform cache

### Best Practices:
1. Use Azure Key Vault for secrets
2. Use service connections for authentication
3. Rotate service principal secrets regularly
4. Use managed identities where possible
5. Review permissions regularly

---

## 🔍 Troubleshooting

### Pipeline Fails at Init:
- Check service connection permissions
- Verify storage account access
- Check if container `eli7e-tfstate` exists

### Agent Pool Not Available:
- Verify VMSS is running
- Check agent installation logs
- Verify agent pool name matches: `kaka_vmss`

### Authentication Errors:
- Verify subscription ID in [provider.tf](provider.tf)
- Check service connection configuration
- Verify tenant ID matches

---

## 📝 Next Steps

1. **Clean Git History** (if sensitive files were committed):
   ```bash
   # Remove sensitive files from history
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch set-azure-env.sh terraform.tfstate terraform.tfstate.backup" \
     --prune-empty --tag-name-filter cat -- --all
   
   git push origin --force --all
   ```

2. **Test Pipeline**:
   ```bash
   # Make a test change
   git add .
   git commit -m "Update configuration"
   git push origin main
   ```

3. **Monitor**:
   - Check Azure DevOps pipeline runs
   - Verify resources in Azure Portal
   - Check Terraform state in storage account
