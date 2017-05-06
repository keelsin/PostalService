-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-05-03 19:11:10.748

-- tables
-- Table: address
CREATE TABLE address (
    address_id varchar2(10)  NOT NULL,
    postal_code varchar2(7)  NOT NULL,
    street varchar2(50)  NOT NULL,
    city varchar2(20)  NOT NULL,
    country varchar2(20)  NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (address_id)
) ;

-- Table: customer
CREATE TABLE customer (
    customer_id varchar2(10)  NOT NULL,
    address_id varchar2(10)  NOT NULL,
    phone_number varchar2(20)  NULL,
    name varchar2(50)  NOT NULL,
    premium char(1)  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (customer_id)
) ;

-- Table: delivery
CREATE TABLE delivery (
    delivery_id varchar2(10)  NOT NULL,
    drone_id varchar2(10)  NOT NULL,
    address_id varchar2(10)  NOT NULL,
    delivery_time date  NOT NULL,
    CONSTRAINT delivery_pk PRIMARY KEY (delivery_id)
) ;

-- Table: drone
CREATE TABLE drone (
    drone_id varchar2(10)  NOT NULL,
    status varchar2(30)  NOT NULL,
    CONSTRAINT drone_pk PRIMARY KEY (drone_id)
) ;

-- Table: employee
CREATE TABLE employee (
    employee_id varchar2(10)  NOT NULL,
    first_name varchar2(20)  NOT NULL,
    last_name varchar2(20)  NOT NULL,
    type varchar2(20)  NOT NULL,
    salary number(10,2)  NOT NULL,
    phone varchar2(20)  NOT NULL,
    email varchar2(50)  NOT NULL,
    user_id varchar2(20)  NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (employee_id)
) ;

-- Table: mail
CREATE TABLE mail (
    mail_id varchar2(10)  NOT NULL,
    weight number(3,0)  NOT NULL,
    postage number(5,2)  NOT NULL,
    status varchar2(50)  NOT NULL,
    registered char(1)  NOT NULL,
    delievry_address_id varchar2(10)  NOT NULL,
    return_address_id varchar2(10)  NULL,
    CONSTRAINT mail_pk PRIMARY KEY (mail_id)
) ;

-- Table: office
CREATE TABLE office (
    office_number varchar2(10)  NOT NULL,
    employee_id varchar2(10)  NOT NULL,
    extension varchar2(15)  NOT NULL,
    CONSTRAINT office_pk PRIMARY KEY (office_number)
) ;

-- Table: postal_code
CREATE TABLE postal_code (
    postal_code varchar2(7)  NOT NULL,
    route_id varchar2(10)  NULL,
    CONSTRAINT postal_code_pk PRIMARY KEY (postal_code)
) ;

-- Table: product
CREATE TABLE product (
    product_id varchar2(10)  NOT NULL,
    name varchar2(50)  NOT NULL,
    price number(5,2)  NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (product_id)
) ;

-- Table: product_sale
CREATE TABLE product_sale (
    product_id varchar2(10)  NOT NULL,
    sale_id varchar2(10)  NOT NULL
) ;

-- Table: properties
CREATE TABLE properties (
    postal_code varchar2(7)  NOT NULL
) ;

-- Table: properties
CREATE TABLE postage (
  min NUMBER(3,0) NOT NULL,
  max NUMBER(3,0) NOT NULL,
  local NUMBER(3,2) NOT NULL,
  usa NUMBER(4,2) NOT NULL,
  international NUMBER(4,2) NOT NULL
);

-- Table: route
CREATE TABLE route (
    route_id varchar2(10)  NOT NULL,
    name varchar2(50)  NOT NULL,
    last_delivered date  NOT NULL,
    CONSTRAINT route_pk PRIMARY KEY (route_id)
) ;

-- Table: sale
CREATE TABLE sale (
    sale_id varchar2(10)  NOT NULL,
    customer_id varchar2(10)  NOT NULL,
    employee_id varchar2(10)  NOT NULL,
    purchase_date date  NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY (sale_id)
) ;

-- Table: schedule
CREATE TABLE schedule (
    schedule_id varchar2(10)  NOT NULL,
    carrier_id varchar2(10)  NOT NULL,
    route_id varchar2(10)  NOT NULL,
    vehicle_id varchar2(10)  NOT NULL,
    scheduled_start date  NOT NULL,
    end_time date ,
    start_time date ,
    CONSTRAINT schedule_pk PRIMARY KEY (schedule_id)
) ;

-- Table: sick_day
CREATE TABLE sick_day (
    "date" date  NOT NULL,
    employee_id varchar2(10)  NOT NULL
) ;

-- Table: user
CREATE TABLE post_user (
    user_id varchar2(10)  NOT NULL,
    username varchar2(20)  NOT NULL,
    hashed_pass raw(250)  /*NOT NULL*/,--I need to turn these not null just so i can test if it will insert properly
    salt varchar2(200)  /*NOT NULL*/,--I need to turn these not null just so i can test if it will insert properly
    CONSTRAINT user_pk PRIMARY KEY (user_id)
) ;

-- Table: vehicle
CREATE TABLE vehicle (
    vehicle_id varchar2(10)  NOT NULL,
    license_plate varchar2(10)  NOT NULL,
    status varchar2(30)  NOT NULL,
    CONSTRAINT vehicle_pk PRIMARY KEY (vehicle_id)
) ;

-- foreign keys
-- Reference: Employee_Schedule (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT Employee_Schedule
    FOREIGN KEY (carrier_id)
    REFERENCES employee (employee_id);

-- Reference: Route_Schedule (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT Route_Schedule
    FOREIGN KEY (route_id)
    REFERENCES route (route_id);

-- Reference: Route_postal_code (table: postal_code)
ALTER TABLE postal_code ADD CONSTRAINT Route_postal_code
    FOREIGN KEY (route_id)
    REFERENCES route (route_id);

-- Reference: Vehicle_Schedule (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT Vehicle_Schedule
    FOREIGN KEY (vehicle_id)
    REFERENCES vehicle (vehicle_id);

-- Reference: address_customer (table: customer)
ALTER TABLE customer ADD CONSTRAINT address_customer
    FOREIGN KEY (address_id)
    REFERENCES address (address_id);

-- Reference: address_mail (table: mail)
ALTER TABLE mail ADD CONSTRAINT address_mail
    FOREIGN KEY (return_address_id)
    REFERENCES address (address_id);

-- Reference: delivery_address (table: delivery)
ALTER TABLE delivery ADD CONSTRAINT delivery_address
    FOREIGN KEY (address_id)
    REFERENCES address (address_id);

-- Reference: drone_delivery (table: delivery)
ALTER TABLE delivery ADD CONSTRAINT drone_delivery
    FOREIGN KEY (drone_id)
    REFERENCES drone (drone_id);

-- Reference: employee_office (table: office)
ALTER TABLE office ADD CONSTRAINT employee_office
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id);

-- Reference: employee_sale (table: sale)
ALTER TABLE sale ADD CONSTRAINT employee_sale
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id);

-- Reference: employee_sick_day (table: sick_day)
ALTER TABLE sick_day ADD CONSTRAINT employee_sick_day
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id);

-- Reference: mail_address (table: mail)
ALTER TABLE mail ADD CONSTRAINT mail_address
    FOREIGN KEY (delievry_address_id)
    REFERENCES address (address_id);

-- Reference: postal_code_Address (table: address)
ALTER TABLE address ADD CONSTRAINT postal_code_Address
    FOREIGN KEY (postal_code)
    REFERENCES postal_code (postal_code);

-- Reference: product_product_sale (table: product_sale)
ALTER TABLE product_sale ADD CONSTRAINT product_product_sale
    FOREIGN KEY (product_id)
    REFERENCES product (product_id);

-- Reference: sale_customer (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (customer_id);

-- Reference: sale_product_sale (table: product_sale)
ALTER TABLE product_sale ADD CONSTRAINT sale_product_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (sale_id);

-- Reference: user_employee (table: employee)
ALTER TABLE employee ADD CONSTRAINT user_employee
    FOREIGN KEY (user_id)
    REFERENCES post_user (user_id);

-- sequences
-- Sequence: address_id_seq
CREATE SEQUENCE address_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: customer_id_seq
CREATE SEQUENCE customer_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: delivery_id_schedule
CREATE SEQUENCE delivery_id_schedule
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: drone_id_seq
CREATE SEQUENCE drone_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: emp_id_seq
CREATE SEQUENCE emp_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: mail_id_seq
CREATE SEQUENCE mail_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: office_id_seq
CREATE SEQUENCE office_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: product_id_seq
CREATE SEQUENCE product_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: route_id_seq
CREATE SEQUENCE route_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;
      
-- Sequence: sale_id_seq
CREATE SEQUENCE sale_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: schedule_id_seq
CREATE SEQUENCE schedule_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;
      
CREATE SEQUENCE user_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;

-- Sequence: vehicle_id_seq
CREATE SEQUENCE vehicle_id_seq
      INCREMENT BY 1
      MINVALUE 0
      NOMAXVALUE
      START WITH 0
      NOCACHE
      NOCYCLE;
      

      
/*
drop table address CASCADE CONSTRAINTS;
drop table postal_code CASCADE CONSTRAINTS;
drop table product_sale CASCADE CONSTRAINTS;
drop table postage CASCADE CONSTRAINTS;
drop table customer CASCADE CONSTRAINTS;
drop table properties CASCADE CONSTRAINTS;
drop table route CASCADE CONSTRAINTS;
drop table sale CASCADE CONSTRAINTS;
drop table schedule CASCADE CONSTRAINTS;
drop table sick_day CASCADE CONSTRAINTS;
drop table delivery CASCADE CONSTRAINTS;
drop table drone CASCADE CONSTRAINTS;
drop table employee CASCADE CONSTRAINTS;
drop table mail CASCADE CONSTRAINTS;
drop table office CASCADE CONSTRAINTS;
drop table vehicle CASCADE CONSTRAINTS;
drop table post_user CASCADE CONSTRAINTS;
drop table product CASCADE CONSTRAINTS;
drop sequence address_id_seq;
drop sequence customer_id_seq;
drop sequence delivery_id_schedule;
drop sequence drone_id_seq;
drop sequence emp_id_seq;
drop sequence mail_id_seq;
drop sequence office_id_seq;
drop sequence product_id_seq;
drop sequence route_id_seq;
drop sequence sale_id_seq;
drop sequence schedule_id_seq;
drop sequence user_id_seq;
drop sequence vehicle_id_seq;
*/
-- End of file.

