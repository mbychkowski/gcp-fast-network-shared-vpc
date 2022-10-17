# use `gcloud beta billing accounts list`
# if you have too many accounts, check the Cloud Console :)
billing_account = {
  id              = "01C6D9-AAD6CA-582331"
  organization_id = 203144705064
}

# use `gcloud organizations list`
organization = {
  domain      = "bychkow.ski"
  id          = 203144705064
  customer_id = "C03jki5v8"
}

groups = {
  gcp-billing-admins      = "gcp-billing-admins",
  gcp-devops              = "gcp-devops",
  gcp-network-admins      = "gcp-network-admins"
  gcp-organization-admins = "gcp-organization-admins"
  gcp-security-admins     = "gcp-security-admins"
  gcp-support             = "gcp-support"
  gcp-team-a              = "team-a"
}

federated_identity_providers = {
  github = {
    attribute_condition = "attribute.repository_owner==\"mbychkowski\""
    issuer              = "github"
    custom_settings     = null
  }
}

cicd_repositories = {
  bootstrap = {
    branch            = null
    identity_provider = "github"
    name              = "mbychkowski/gcp-fast-bootstrap"
    type              = "github"
  }
  cicd = null
  resman = {
    branch            = null
    identity_provider = "github"
    name              = "mbychkowski/gcp-fast-resman"
    type              = "github"
  }
}

outputs_location = "~/fast-config"

# use something unique and short
prefix           = "bych"
