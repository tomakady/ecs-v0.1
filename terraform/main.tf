module "vpc" {
    source = "./vpc.tf"
}

module "sg" {
    source = "./sg.tf"
    depends_on = [module.vpc]
}

module "alb" {
    source = "./alb.tf"
    depends_on = [module.sg]
}

module "route53" {
    source = "./route53.tf"
}

module "acm" {
    source = "./acm.tf"
}

module "ecr" {
    source = "./ecr.tf"
}

module "ecs" {
    source = "./ecs.tf"
    depends_on = [module.alb, module.ecr, module.efs, module.sg]
}

module "efs" {
    source = "./efs.tf"
    depends_on = [module.sg]
}

