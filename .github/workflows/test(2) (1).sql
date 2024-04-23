/*************************************************************************
**                                                                       **
**    IST-659 Final Project,  Test Database                              **
**    Authors: David Mansoir and Chad J Alessi                           **
**    Due Date: 03-26-24                                                 **
**                                                                       **
**************************************************************************/

-- Create the test data base if it does not exist.
if not exists(select * from sys.databases where name = 'test')
  create database test

  -- Execute 
  go

-- Switch to the database.
use test

-- Execute
go

/* This section drops all tables in order to re-create the tables during the database design phase. */
if exists(select * from information_schema.tables
     where table_name = 'tests')
   drop table tests

if exists(select * from information_schema.tables
     where table_name = 'testprofile')
   drop table testprofile

if exists(select * from information_schema.tables
     where table_name = 'testchoices')
   drop table testchoices

if exists(select * from information_schema.tables
     where table_name = 'products')
   drop table products

if exists(select * from information_schema.tables
     where table_name = 'test_types_lookup')
   drop table test_types_lookup

if exists(select * from information_schema.tables
     where table_name = 'test_categories_lookup')
   drop table test_categories_lookup

if exists(select * from information_schema.tables
     where table_name = 'test_groups_lookup')
   drop table test_groups_lookup

if exists(select * from information_schema.tables
     where table_name = 'test_locations_lookup')
   drop table test_locations_lookup

if exists(select * from information_schema.tables
     where table_name = 'test_admins_lookup')
   drop table test_admins_lookup

if exists(select * from information_schema.tables
     where table_name = 'test_statuses_lookup')
   drop table test_statuses_lookup

if exists(select * from information_schema.tables
     where table_name = 'product_models_lookup')
   drop table product_models_lookup

if exists(select * from information_schema.tables
     where table_name = 'product_types_lookup')
   drop table product_types_lookup

if exists(select * from information_schema.tables
     where table_name = 'product_categories_lookup')
   drop table product_categories_lookup

if exists(select * from information_schema.tables
     where table_name = 'product_statuses_lookup')
   drop table product_statuses_lookup
go


/* Create the "test_types_lookup" table listing valid test types. */
if not exists(select * from information_schema.tables
     where table_name = 'test_types_lookup')

   create table test_types_lookup (
     type_name varchar(50) not null,
     constraint pk_test_types_lookup_type_name primary key(type_name)
     )

/* Create the "test_categories_lookup" table listing valid test categories. */
if not exists(select * from information_schema.tables
     where table_name = 'test_categories_lookup')

   create table test_categories_lookup (
     category_name varchar(50) not null,
     constraint pk_test_categories_lookup_category_name primary key(category_name)
     )

/* Create the "test_groups_lookup" table listing valid test groups. */
if not exists(select * from information_schema.tables
     where table_name = 'test_groups_lookup')

   create table test_groups_lookup (
     group_name varchar(50) not null,
     constraint pk_test_groups_lookup_group_name primary key(group_name)
     )

/* Create the "test_locations_lookup" table listing valid test locations. */
if not exists(select * from information_schema.tables
     where table_name = 'test_locations_lookup')

   create table test_locations_lookup (
     location_name varchar(50) not null,
     constraint pk_test_locations__lookup_location_name primary key(location_name)
     )

/* Create the "test_admins_lookup" table listing valid test admins. */
if not exists(select * from information_schema.tables
     where table_name = 'test_admins_lookup')

   create table test_admins_lookup (
     admin_name varchar(50) not null,
     constraint pk_test_admins_lookup_admin_name primary key(admin_name)
     )

/* Create the "test_statuses_lookup" table listing valid test statuses. */
if not exists(select * from information_schema.tables
     where table_name = 'test_statuses_lookup')

   create table test_statuses_lookup (
     status_name varchar(50) not null,
     constraint pk_test_statuses_lookup_status_name primary key(status_name)
     )

/* Create the "product_models_lookup" table listing valid product models. */
if not exists(select * from information_schema.tables
     where table_name = 'product_models_lookup')

   create table product_models_lookup (
     model_name varchar(50) not null,
     model_desc varchar(256) not null,
     constraint pk_product_models_lookup_model_name primary key(model_name)
     )

/* Create the "product_types_lookup" table listing valid product types. */
if not exists(select * from information_schema.tables
     where table_name = 'product_types_lookup')

   create table product_types_lookup (
     type_name varchar(50) not null,
     constraint pk_product_types_lookup_type_name primary key(type_name)
     )

/* Create the "product_categories_lookup" table listing valid product categories. */
if not exists(select * from information_schema.tables
     where table_name = 'product_categories_lookup')

   create table product_categories_lookup (
     category_name varchar(50) not null,
     constraint pk_product_categories_lookup_category_name primary key(category_name)
     )

/* Create the "product_statuses_lookup" table listing valid product statuses. */
if not exists(select * from information_schema.tables
     where table_name = 'product_statuses_lookup')

   create table product_statuses_lookup (
     status_name varchar(50) not null,
     constraint pk_product_statuses_lookup_status_name primary key(status_name)
     )

/* Create the "products" table. */
if not exists(select * from information_schema.tables
     where table_name = 'products')

   create table products (
     product_id int identity not null,
     product_category varchar(50) not null,
     product_model varchar(50) not null,
     product_type varchar(50) not null,
     product_sn int not null,
     product_assembly_no int not null,
     product_ver varchar(5) not null,
     product_rev char(3) not null, 
     product_status varchar(50) not null,
     product_desc varchar(50) not null,
     product_comments varchar(100) null,
     product_customer varchar(50) null,
     product_test_profile int not null,
     --constraint pk_products_product_id primary key(product_id),
     constraint pk_products_sn_test_profile primary key(product_sn,product_test_profile),
     constraint u_products_product_sn unique (product_sn),
     constraint fk_products_product_category foreign key(product_category)
      references product_categories_lookup(category_name),
     constraint fk_products_product_type foreign key(product_type)
      references product_types_lookup(type_name),
     constraint fk_products_product_model foreign key(product_model)
      references product_models_lookup(model_name),
     constraint fk_products_product_status foreign key(product_status)
      references product_statuses_lookup(status_name)
     )

-- Execute
go

/* Create the "testchoices table. */
if not exists(select * from information_schema.tables
     where table_name = 'testchoices')

   create table testchoices (
     test_id int identity not null,
     test_name varchar(50) not null,
     profile_no int not null,
     constraint pk_testchoices_test_name primary key(test_name, profile_no)
     )

-- Execute 
go

/* Create the "test_profile" table. */
if not exists(select * from information_schema.tables
     where table_name = 'testprofile')

   create table testprofile (
     test_profile_id int identity not null,
     test_name varchar(50) not null,
     test_profile_no int not null,
     test_status varchar(50) not null,
     test_cycles int not null,
     test_time time not null,
     test_unit_sn int not null,
     test_tolerance int not null,
     test_cost money not null,
     constraint pk_testprofile_test_id primary key(test_profile_id),
     constraint u_testprofile_test_unit_sn unique (test_unit_sn),
     constraint fk_testprofile_test_unit_sn foreign key(test_unit_sn,test_profile_no)
             references products(product_sn,product_test_profile),
     constraint fk_testprofile_test_name foreign key(test_name,test_profile_no)
             references testchoices(test_name, profile_no),
     constraint fk_testprofile_test_status foreign key(test_status)
             references test_statuses_lookup(status_name)
     )

-- Execute
go

/* Create the "tests" table. */
if not exists(select * from information_schema.tables
     where table_name = 'tests')

  create table tests (
     test_id int identity not null,
     test_start_time time not null,
     test_end_time time null,
     test_start_date date not null,
     test_end_date date null,
     test_category varchar(50) not null,
     test_type varchar(50) not null,
     test_retries int not null,
     test_job_number int not null,
     test_location varchar(50) not null,
     test_group varchar(50) not null,
     test_administered_by varchar(50) not null,
     test_engineer_id int not null,
     test_total_time int not null,
     test_total_days int not null,
     test_desc varchar(100) null,
     test_comments varchar(100) null,
     test_product_sn int not null,
     constraint pk_tests_test_id primary key (test_id),
     constraint fk_tests_test_category foreign key(test_category)
      references test_categories_lookup(category_name),
     constraint fk_tests_test_type foreign key(test_type)
      references test_types_lookup(type_name),
     constraint fk_tests_test_group foreign key(test_group)
      references test_groups_lookup(group_name),
     constraint fk_tests_test_location foreign key(test_location)
      references test_locations_lookup(location_name),
     constraint fk_tests_test_adminstered_by foreign key(test_administered_by)
      references test_admins_lookup(admin_name),
     constraint fk_tests_test_product_sn foreign key(test_product_sn)
      references products(product_sn),
      constraint u_tests_test_product_sn unique (test_product_sn)
     )

-- Execute
go


/* This section inserts default data into the test lookup tables. This can be omitted after testing or remain. */

-- Insert data into the "test_types_lookup" table.
insert into test_types_lookup (type_name) values 
       ('Hardware'), 
       ('Software'), 
       ('Component'), 
       ('System'), 
       ('Environmental'), 
       ('Experimental')

-- Insert data into the "test_categories_lookup" table.
insert into test_categories_lookup (category_name) values 
       ('Development'), 
       ('Production'), 
       ('RMA'), 
       ('Prototype'), 
       ('Preproduction')

-- Insert data into the "test_statuses_lookup" table.
insert into test_statuses_lookup (status_name) values 
       ('Completed'), 
       ('Error'), 
       ('Failed'), 
       ('Halted'), 
       ('Offline'), 
       ('Online'),
       ('Paused'), 
       ('Pending'), 
       ('Queued'),
       ('Running'),
       ('Stopped'),
       ('Unknown')

-- insert data into the "test_groups_lookup" table.
insert into test_groups_lookup (group_name) values 
       ('Engineering'), 
       ('Production'), 
       ('Service'), 
       ('Quality Control'), 
       ('3rd Party'),
       ('Vendor')

-- Insert data into the "test_locations_lookup" table.
insert into test_locations_lookup (location_name) values 
       ('Albuquerque'), 
       ('Fremont'), 
       ('Columbus'), 
       ('Schenectady'), 
       ('San Diego'), 
       ('Austin')

-- Insert data into the "test_admins_lookup" table.
insert into test_admins_lookup (admin_name) values 
       ('Billings Corp.'), 
       ('Advanced Access LLC'), 
       ('SNR Inc'), 
       ('Global Standards'),
       ('Digital Magic LLC')
go


/* This section inserts default data into the product lookup tables. */

-- Insert data into the "product_models_lookup" table.
insert into product_models_lookup (model_name,model_desc) values 
       ('RC-220','GPS Reconnaissance System'), 
       ('ADL-304','Microwave Antenna Array Controller'), 
       ('KX-175','Software Controller for MC180'), 
       ('LX-404','Assembly Diagnostic Test Unit'),
       ('BR-222','Assembly for KX175'),
       ('TN-325','Power Supply 18V'),
       ('CL-111','Logging software for TN325'),
       ('MX-4780','VHF Antenna Array')

-- Insert data into the "product_statuses_lookup" table.
insert into product_statuses_lookup (status_name) values 
       ('Initializing'),
       ('Rebooting'),
       ('Online'),
       ('Offline'),
       ('Testing'),
       ('Finished')

-- Insert data into the "product_categories_lookup" table.
insert into product_categories_lookup (category_name) values 
       ('Telecomm'),
       ('Database'),
       ('AI'),
       ('Automotive'),
       ('Consumer'),
       ('Medical')

-- Insert data into the "product_types_lookup" table.
insert into product_types_lookup (type_name) values 
       ('Hardware'),
       ('Software'),
       ('Assembly'),
       ('Component'),
       ('System'),
       ('Peripheral')
go


/* Data section.  This section fills the database with test data. */
-- Insert data into products table. 
insert into products (product_category,product_model,product_type, product_sn,product_assembly_no,product_ver,product_rev,product_status, product_desc,product_customer,product_test_profile) 
   values
   ('Telecomm', 'RC-220', 'Hardware', 1697935, 26385, '1.0', 'A', 'Online', 'First Prototype' , 'Internal',2), 
   ('Telecomm', 'RC-220', 'Hardware', 1697936, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697937, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697938, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697939, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697940, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 2),
   ('Telecomm', 'RC-220', 'Hardware', 1697941, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697942, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697943, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'RC-220', 'Hardware', 1697944, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'TN-325', 'Hardware', 1697945, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 3),
   ('Telecomm', 'MX-4780', 'Hardware', 1697946, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 3),
   ('Telecomm', 'KX-175', 'Software', 1697947, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 4),
   ('Telecomm', 'TN-325', 'Hardware', 1697948, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 4),
   ('Telecomm', 'CL-111', 'Software', 1697949, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 4),
   ('Telecomm', 'BR-222', 'Assembly', 1697950, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 4),
   ('Telecomm', 'ADL-304', 'Hardware', 1697951, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'LX-404', 'Assembly', 1697952, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'MX-4780', 'Hardware', 1697953, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'CL-111', 'Software', 1697954, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'ADL-304', 'Hardware', 1697955, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'BR-222', 'Assembly', 1697956, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'KX-175', 'Software', 1697957, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 5),
   ('Telecomm', 'TN-325', 'Hardware', 1697958, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 2),
   ('Telecomm', 'ADL-304', 'Hardware', 1697959, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'CL-111', 'Software', 1697960, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'KX-175', 'Software', 1697961, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'MX-4780', 'Hardware', 1697962, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 2),
   ('Telecomm', 'TN-325', 'Hardware', 1697963, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'CL-111', 'Software', 1697964, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1),
   ('Telecomm', 'ADL-304', 'Hardware', 1697965, 26385, '1.0', 'A', 'Online', 'Prototype Series', 'Internal', 1);

-- Execute
go
   

-- Insert tests into the testchoices table. 

INSERT INTO testchoices (test_name, profile_no) 
   VALUES 
   ('BIST', 1),
   ('Scan Test', 1),
   ('Network', 1),
   ('Chamber', 1),
   ('Power Cycle', 1),
   ('Soft Reboot', 1),
   ('Surge Test', 1),
   ('BIST', 2),
   ('Scan Test', 2),
   ('Network', 2),
   ('Chamber', 2),
   ('Power Cycle', 2),
   ('Soft Reboot', 2),
   ('Surge Test', 3),
   ('Load Test', 3),
   ('Stress Test', 3),
   ('Quality Check', 4),
   ('Functionality Test', 4),
   ('Safety Check', 4),
   ('Performance Test', 4),
   ('Integration Test', 5),
   ('System Test', 5),
   ('Endurance Test', 5),
   ('Validation Test', 5),
   ('Compatibility Test', 5),
   ('Usability Test', 5),
   ('Compliance Test', 5);
-- Execute
go

-- Insert data into testprofile table. 

INSERT INTO testprofile (test_name, test_profile_no, test_status, test_cycles, test_time, test_unit_sn, test_tolerance, test_cost) 
   VALUES 
   ('Power Cycle', 1, 'Online', 24, '1:00:00', 1697936, 10, 25.00),
   ('Surge Test', 1, 'Online', 24, '1:00:00', 1697939, 10, 85.00),
   ('Chamber', 1, 'Online', 24, '1:00:00', 1697937, 10, 15.00),
   ('Surge Test', 1, 'Online', 24, '1:00:00', 1697938, 10, 85.00),
   ('BIST', 1, 'Online', 24, '1:00:00', 1697941, 10, 5.00),
   ('Network', 1, 'Online', 24, '1:00:00', 1697942, 10, 35.00),
   ('Chamber', 1, 'Online', 24, '1:00:00', 1697943, 10, 15.00),
   ('Chamber', 1, 'Online', 24, '1:00:00', 1697944, 10, 15.00),
   ('Soft Reboot', 	2, 'Online', 24, '1:00:00', 1697940, 10, 5.00),
   ('Soft Reboot', 2, 'Online', 24, '1:00:00', 1697935, 10, 5.00),
   ('Load Test', 3, 'Online', 24, '1:00:00', 1697945, 10, 25.00),
   ('Stress Test', 3, 'Online', 24, '1:00:00', 1697946, 10, 85.00),
   ('Quality Check', 4, 'Online', 24, '1:00:00', 1697947, 10, 15.00),
   ('Functionality Test', 4, 'Online', 24, '1:00:00', 1697948, 10, 5.00),
   ('Safety Check', 4, 'Online', 24, '1:00:00', 1697949, 10, 35.00),
   ('Performance Test', 4, 'Online', 24, '1:00:00', 1697950, 10, 85.00),
   ('Integration Test', 5, 'Online', 24, '1:00:00', 1697951, 10, 15.00),
   ('System Test', 5, 'Online', 24, '1:00:00', 1697952, 10, 5.00),
   ('Endurance Test', 5, 'Online', 24, '1:00:00', 1697953, 10, 35.00),
   ('Validation Test', 5, 'Online', 24, '1:00:00', 1697954, 10, 25.00),
   ('Compatibility Test', 5, 'Online', 24, '1:00:00', 1697955, 10, 85.00),
   ('Usability Test', 5, 'Online', 24, '1:00:00', 1697956, 10, 15.00),
   ('Compliance Test', 5, 'Online', 24, '1:00:00', 1697957, 10, 5.00),
   ('Chamber', 2, 'Online', 24, '1:00:00', 1697958, 10, 35.00),
   ('Scan Test', 1, 'Online', 24, '1:00:00', 1697959, 10, 85.00),
   ('Scan Test', 1, 'Online', 24, '1:00:00', 1697960, 10, 15.00),
   ('Scan Test', 1, 'Online', 24, '1:00:00', 1697961, 10, 5.00),
   ('Power Cycle', 2, 'Online', 24, '1:00:00', 1697962, 10, 35.00),
   ('Power Cycle', 1, 'Online', 24, '1:00:00', 1697963, 10, 25.00),
   ('BIST', 1, 'Online', 24, '1:00:00', 1697964, 10, 85.00);

-- Execute
go


-- Insert data into tests table.
insert into tests
   (test_start_time,test_end_time,test_start_date,test_end_date, test_category,test_type,test_retries,test_job_number, test_location,test_group,test_administered_by,test_engineer_id, test_total_time,test_total_days,test_desc,test_comments,test_product_sn) 
   values
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'Schenectady','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697935),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'San Diego','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697936),
   ('05:00:00','10:00:00','20240227','20240227','Development','Component',1,27385,'Schenectady','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697937),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'Columbus','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697938),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'Columbus','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697939),
   ('05:00:00','10:00:00','20240227','20240227','Development','Experimental',1,27385,'Austin','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697940),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'San Diego','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697941),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'Albuquerque','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697942),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'Albuquerque','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697943),
   ('05:00:00','10:00:00','20240227','20240227','Development','System',1,27385,'Columbus','Engineering','SNR Inc',125578,5,1,'First Run Prototype','Testing for European Standards',1697944),
   ('05:00:00','10:00:00','20240228','20240228','Development','Environmental',1,278515,'Fremont','Engineering','Advanced Access LLC',125579,5,1,'Extended Run Prototype','Extended testing for global standards',1697945),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,27378,'Schenectady','Service','Digital Magic LLC',125581,5,1,'Extended Run Prototype','Extended testing for global standards',1697946),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,27378,'Schenectady','Quality Control','Digital Magic LLC',125581,5,1,'Extended Run Prototype','Extended testing for global standards',1697947),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,27378,'Schenectady','Service','Digital Magic LLC',125581,5,1,'Extended Run Prototype','Extended testing for global standards',1697948),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,278517,'Austin','Production','SNR Inc',125583,5,1,'Extended Run Prototype','Extended testing for global standards',1697949),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,27385,'Fremont','Production','Advanced Access LLC',125584,5,1,'Extended Run Prototype','Extended testing for global standards',1697950),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,278520,'San Diego','Production','Billings Corp.',125585,5,1,'Extended Run Prototype','Extended testing for global standards',1697951),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,278521,'San Diego','Quality Control','Digital Magic LLC',125586,5,1,'Extended Run Prototype','Extended testing for global standards',1697952),
   ('05:00:00','10:00:00','20240228','20240228','Development','Hardware',1,278522,'Schenectady','Quality Control','Billings Corp.',125587,5,1,'Extended Run Prototype','Extended testing for global standards',1697953),
   ('05:00:00','10:00:00','20240228','20240228','Development','Component',1,278523,'Austin','Production','SNR Inc',125588,5,1,'Extended Run Prototype','Extended testing for global standards',1697954),
   ('05:00:00','10:00:00','20240228','20240228','Development','Component',1,278524,'Fremont','Production','Advanced Access LLC',125589,5,1,'Software Functionality Test','Adapting to new standards',1697955),
   ('05:00:00','10:00:00','20240228','20240228','Development','Component',1,278525,'Columbus','Service','Global Standards',125590,5,1,'Algorithm Performance Test','Verifying new algorithms',1697956),
   ('05:00:00','10:00:00','20240228','20240228','RMA','Component',1,278526,'Austin','Production','Global Standards',125591,5,1,'Hardware Stress Test','Stress testing for durability',1697957),
   ('05:00:00','10:00:00','20240228','20240228','RMA','Component',1,278527,'Austin','Engineering','SNR Inc',125592,5,1,'Peripheral Integration Test','Ensuring compatibility',1697958),
   ('05:00:00','10:00:00','20240228','20240228','Production','Component',1,278528,'Austin','Production','SNR Inc',125593,5,1,'Assembly Efficiency Test','Optimizing assembly line',1697959),
   ('05:00:00','10:00:00','20240228','20240228','Production','Component',1,278529,'Fremont','Production','Advanced Access LLC',125594,5,1,'User Experience Test','Evaluating user interface',1697960);

-- Execute
go


/* The following section contains stored procedures and views for the tests database. */

-- Stored procedures for this database 

-- Transaction safe procedure to switch test profile 
create or alter procedure dbo.p_SwitchTestProfile 
(
	@productSn int,
	@newProfile int,
 @TestName varchar(50),
 @cost money
 )
	as begin
		begin try
			begin transaction
				--data logic
				if exists (select * from [dbo].[testprofile] where test_unit_sn = @productSn)
					begin
						delete from testprofile where test_unit_sn = @productSn

      INSERT INTO testprofile (test_name, test_profile_no, test_status, test_cycles, test_time, test_unit_sn, test_tolerance, test_cost) 
        VALUES 
        (@testName, @newProfile, 'Online', 24, '1:00:00', @productSn, 10, @cost);

      update products set product_test_profile = @newProfile where product_sn = @productSn

						if @@rowcount <> 1 throw 50001, 'p_SwitchTestprofile: Update Error', 1
					end
			 else begin 
     print("The product serial number does not exist in the TestProfile table")
			 END
			commit
		end try
		begin catch
			rollback
			;
			throw
		end catch
	end

go


-- Transaction safe procedure to add test profile 
create or alter procedure dbo.p_AddTestProfile 
(
	@productSn int,
	@newProfile int,
 @TestName varchar(50),
 @cost money
 )
	as begin
		begin try
			begin transaction
				--data logic
				if exists (select * from [dbo].[testprofile] where test_unit_sn = @productSn)
					begin
       print("The product serial number already exist in the TestProfile table")
					end
			 else begin 
				  if exists (select * from [dbo].[products] where product_sn = @productSn)
					   begin
         update products set product_test_profile = @newProfile where product_sn = @productSn

         INSERT INTO testprofile (test_name, test_profile_no, test_status, test_cycles, test_time, test_unit_sn, test_tolerance, test_cost) 
           VALUES 
           (@testName, @newProfile, 'Online', 24, '1:00:00', @productSn, 10, @cost);

						   if @@rowcount <> 1 throw 50001, 'p_AddTestProfile: Update Error', 1
        end
      else begin
         print("The product serial number does not exist in the Products table")
      end
    end
			commit
		end try
		begin catch
			rollback
			;
			throw
		end catch
	end

go


-- Transaction safe procedure to remove test profile 
create or alter procedure dbo.p_RemoveTestProfile 
(
	@productSn int
 )
	as begin
		begin try
			begin transaction
				--data logic
				if exists (select * from [dbo].[testprofile] where test_unit_sn = @productSn)
					begin
       delete from testprofile where test_unit_sn = @productSn

       update products set product_test_profile = 0 where product_sn = @productSn

				   if @@rowcount <> 1 throw 50001, 'pRemoveTestProfile: Update Error', 1
     end
    else begin
       print("The serial number does not exist in the TestProfile table")
    end
			commit
		end try
		begin catch
			rollback
			;
			throw
		end catch
	end

go


-- Transaction safe procedure to set the test status by serial number
create or alter procedure dbo.p_SetTestStatus 
(
	@productSn int,
 @testStatus varchar(50) 
 )
	as begin
		begin try
			begin transaction

				  --data logic
      update testprofile set test_status = @testStatus where test_unit_sn = @productSn

						if @@rowcount <> 1 throw 50001, 'p_TestsByJobNumber: Update Error', 1
			commit
		end try
		begin catch
			rollback
			;
			throw
		end catch
	end

go


-- Transaction safe procedure to set the test name by serial number
create or alter procedure dbo.p_SetTestName 
(
	@productSn int,
 @testName varchar(50) 
 )
	as begin
		begin try
			begin transaction

				  --data logic
      update testprofile set test_name = @testName where test_unit_sn = @productSn

						if @@rowcount <> 1 throw 50001, 'p_TestsByJobNumber: Update Error', 1
			commit
		end try
		begin catch
			rollback
			;
			throw
		end catch
	end

go


/* Views for this database */

create or alter view dbo.v_TestsInAustin
 as select test_job_number, test_location,test_administered_by,product_model,product_sn,test_name,test_status 
        from products join tests on product_id = test_id 
        join testprofile on test_profile_id = test_id 
        where test_location = 'Austin'
go

create or alter view dbo.v_TestsAlbuquerque
 as select test_job_number, test_location,test_administered_by,product_model,product_sn,test_name,test_status 
        from products join tests on product_id = test_id 
        join testprofile on test_profile_id = test_id 
        where test_location = 'Albuquerque'
go

create or alter view dbo.v_TestsInColumbus
 as select test_job_number, test_location,test_administered_by,product_model,product_sn,test_name,test_status 
        from products join tests on product_id = test_id 
        join testprofile on test_profile_id = test_id 
        where test_location = 'Columbus'
go

create or alter view dbo.v_TestsInFremont
 as select test_job_number, test_location,test_administered_by,product_model,product_sn,test_name,test_status 
        from products join tests on product_id = test_id 
        join testprofile on test_profile_id = test_id 
        where test_location = 'Fremont'
go

create or alter view dbo.v_TestsInSanDiego
 as select test_job_number, test_location,test_administered_by,product_model,product_sn,test_name,test_status 
        from products join tests on product_id = test_id 
        join testprofile on test_profile_id = test_id 
        where test_location = 'San Diego'
go

create or alter view dbo.v_TestsInSchenectady
 as select test_job_number, test_location,test_administered_by,product_model,product_sn,test_name,test_status 
        from products join tests on product_id = test_id 
        join testprofile on test_profile_id = test_id 
        where test_location = 'Schenectady'
go
