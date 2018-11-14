CREATE DATABASE IF NOT EXISTS skytours;

CREATE TABLE IF NOT EXISTS skytours.domains(
  id int(10) not null AUTO_INCREMENT,
  domain_name varchar(100) NOT NULL,
  tld varchar(30) NULL,
  status varchar(100) NULL,
  dns varchar(50) NULL,
  registrar varchar(100) NULL,
  url varchar(200) NULL,
  login varchar(50) NULL,
  insert_date timestamp null default current_timestamp,
  primary key (id)
)engine=InnoDB;
