terraform {
  cloud {
    organization = "dragon-ws"

    workspaces {
      name = "kubernetes"
    }
  }
}