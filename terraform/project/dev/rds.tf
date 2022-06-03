resource "aws_db_instance" "mydb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "blog"
  username             = "admin"
  password             = "Gfhjkm123"
  db_subnet_group_name = aws_db_subnet_group.default.id
}
resource "aws_db_subnet_group" "default" {
  name           = "main"
  subnet_ids     = [aws_subnet.dev-subnet-1.id, aws_subnet.dev-subnet-2.id]
  
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_route53_record" "database" {
  zone_id = "Z050488517TH28UEJEWBY"
  name = "rds.lopnesh.tk"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_db_instance.mydb.address}"]
}