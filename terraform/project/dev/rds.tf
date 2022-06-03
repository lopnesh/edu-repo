resource "aws_db_instance" "mydb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "blog"
  username             = "user "
  password             = "p@ssw0rd"
  db_subnet_group_name = aws_db_subnet_group.default.id
  parameter_group_name = "default.mysql5.7"
}
resource "aws_db_subnet_group" "default" {
  name           = "main"
  subnet_ids     = ["${public_subnet_ids}"]
  
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