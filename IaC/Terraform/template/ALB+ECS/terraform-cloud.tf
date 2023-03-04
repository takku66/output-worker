terraform {
  cloud {
    organization = "takku66"

    workspaces {
      name = "template-alb-ecs"
    }
  }
}