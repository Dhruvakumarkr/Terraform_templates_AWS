resource "aws_dynamodb_table" "basic-dynamodb-table1" {
  name           = "GameScores1"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

resource "aws_dynamodb_table_item" "example" {
    table_name = aws_dynamodb_table.basic-dynamodb-table2.name
    hash_key   = aws_dynamodb_table.basic-dynamodb-table2.UserId

    item = <<ITEM
  {
    "UserId": "Dhruva"
    "GameTitle": "PUBG"
    "TopScore": 85
 }
 ITEM
  }
}
   
