terraform {
  cloud {
    organization = "sample-user"

    workspaces {
      name = "tfstate-migrate"
    }
  }
}