[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Work In Progress](https://img.shields.io/badge/Status-Work%20In%20Progress-yellow)](https://unitvectory-labs.github.io/uvy-labs-guide/bestpractices/status/#work-in-progress)

# serviceauthcentral-manage-gcp-tofu

This OpenTofu module is used for deploying ServiceAuthCentral manage API to GCP.

## Usage

The basic use of this module is as follows:

```hcl
module "serviceauthcentral_manage_gcp" {
    source = "git::https://github.com/UnitVectorY-Labs/serviceauthcentral-manage-gcp-tofu.git?ref=main"
    name = "serviceauthcentral"
    project_id = var.project_id
    regions = ["us-east1"]
    region_db_names = {
        "us-east1" = "sac-us-east1"
    }
    sac_issuer = "https://api.example.com"
    sac_cors_origins = "https://portal.example.com"
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->