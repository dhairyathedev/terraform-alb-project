#!/bin/bash

dnf update -y

dnf install -y httpd

systemctl start httpd
systemctl enable httpd

echo "<h1>Hello world from Terraform, Dhairya and Tiny!</h1>" > /var/www/html/index.html