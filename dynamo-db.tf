resource "aws_dynamodb_table" "db" {
    name           = "terraform-dynamodb-demo"
    billing_mode   = "PROVISIONED"
    hash_key       = "id"
    range_key      = "name"
    read_capacity  = 1
    write_capacity = 1
    attribute {
        name = "id"
        type = "S"
    }
    attribute {
        name = "name"
        type = "S"
    }
    tags = {
        Name = "terraform-dynamodb-demo"
    }
}