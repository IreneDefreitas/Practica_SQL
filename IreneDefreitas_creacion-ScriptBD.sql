-- CREACION SCHEMA 
create schema pgmaster authorization ibziectv;


-- TABLA COLORS --
create table pgmaster.colors(
	id_color varchar(20) not null, 
	name varchar(200) not null, 
	description varchar(512) null
);

-- PK COLORS
alter table pgmaster.colors
add constraint colors_PK primary key (id_color);


-- TABLA CAR_GROUPS --
create table pgmaster.car_groups(
	id_group varchar(20) not null, 
	name varchar(200) not null, 
	description varchar(512) null
);	

-- PK CAR_GROUPS
alter table pgmaster.car_groups
add constraint car_groups_PK primary key (id_group);


-- TABLA CAR_BRANDS --
create table pgmaster.car_brands(
	id_brand varchar(20) not null, --PK 
	name varchar(200) not null, 
	id_group varchar(200) not null, --FK 
	description varchar(512) null
);	

-- PK CAR_BRANDS
alter table pgmaster.car_brands
add constraint car_brands_PK primary key (id_brand);

-- FK CAR_BRANDS
alter table pgmaster.car_brands
add constraint car_brands_id_group_FK foreign key (id_group)
references pgmaster.car_groups(id_group);

-- TABLA CAR_MODELS --
create table pgmaster.car_models(
	id_model varchar(20) not null, --PK 
	name varchar(200) not null, 
	id_brand varchar(200) not null, --FK
	description varchar(512) null
);

-- PK MODELS
alter table pgmaster.car_models
add constraint car_models_PK primary key (id_model);

-- FK MODELS
alter table pgmaster.car_models
add constraint car_models_id_brand_FK foreign key (id_brand)
references pgmaster.car_brands(id_brand);

-- TABLA CURRENCIES --
create table pgmaster.currencies(
	id_currency varchar(20) not null, --PK 
	name varchar(200) not null, 
	description varchar(512) null
);

-- PK CURRENCIES
alter table pgmaster.currencies
add constraint id_currency_PK primary key (id_currency);


-- TABLA INSURANCE_COMPS --
create table pgmaster.insurance_comps(
	id_ins_company varchar(20) not null, --PK 
	name varchar(200) not null, 
	description varchar(512) null
);	

-- PK INSURANCE_COMPS 
alter table pgmaster.insurance_comps
add constraint insurance_comps_PK primary key (id_ins_company);


--  INSURANCE_POLS --
create table pgmaster.insurance_pols(
	num_ins_policy varchar(200) not null, --PK 
	amount  decimal not null, 
	id_currency varchar(20) not null default 'CUR001', --FK
	id_ins_company varchar(20) not null, --FK
	description varchar(512) null
);	

-- PK INSURANCE_POLS
alter table pgmaster.insurance_pols
add constraint insurance_pols_PK primary key (num_ins_policy);

-- FK INSURANCE_POLS
alter table pgmaster.insurance_pols
add constraint insurance_pols_id_currency_FK foreign key (id_currency)
references pgmaster.currencies(id_currency);


alter table pgmaster.insurance_pols
add constraint insurance_pols_id_ins_company_FK foreign key (id_ins_company)
references pgmaster.insurance_comps(id_ins_company);


-- TABLA CARS --
create table pgmaster.cars(
	id_car varchar(20) not null, --PK 
	id_model varchar(20) not null, --FK
	plate varchar(200) not null, 
	total_km integer not null,
	dt_adquisition date not null default '4000-01-01',
	id_color varchar(20) not null, --FK
	description varchar(512) null
);

-- PK CARS
alter table pgmaster.cars
add constraint insurance_cars_PK primary key (id_car);

-- FK CARS
alter table pgmaster.cars
add constraint cars_id_model_FK foreign key (id_model)
references pgmaster.car_models(id_model);

alter table pgmaster.cars
add constraint cars_id_color_FK foreign key (id_color)
references pgmaster.colors(id_color);

--  TABLA HIST_INSURANCE_POL --
create table pgmaster.hist_insurance_pol(
	id_car  varchar(20) not null, --PK --FK
	dt_start date not null default '4000-01-01', --PK
	dt_end date not null default '4000-01-01',
	num_ins_policy varchar(200) not null, --FK 
	comment varchar(512) null
);

-- PK CARS
alter table pgmaster.hist_insurance_pol
add constraint hist_insurance_pol_PK primary key (id_car, dt_start);

-- FK CARS
alter table pgmaster.hist_insurance_pol
add constraint hist_insurance_pol_id_car_FK foreign key (id_car)
references pgmaster.cars(id_car);

alter table pgmaster.hist_insurance_pol
add constraint hist_insurance_pol_num_ins_policy_FK foreign key (num_ins_policy)
references pgmaster.insurance_pols(num_ins_policy);


-- TABLA HIST_REVISIONS --
create table pgmaster.hist_revisions(
	id_car varchar(20) not null, --PK --FK
	num_revision integer not null, --PK
	km integer not null, 
	dt_revision date not null default '4000-01-01',
	amount  decimal not null, 
	id_currency varchar(20) not null default 'CUR001', --FK
	comment varchar(512) null
);

-- PK CARS
alter table pgmaster.hist_revisions
add constraint hist_revisions_PK primary key (id_car, num_revision);

-- FK CARS
alter table pgmaster.hist_revisions
add constraint hist_revisions_id_car_FK foreign key (id_car)
references pgmaster.cars(id_car);

alter table pgmaster.hist_revisions
add constraint hist_revisions_id_currency_FK foreign key (id_currency)
references pgmaster.currencies(id_currency);

-- INSERT TABLE COLORS --

insert into pgmaster.colors(id_color, name, description)values('COL001','Black','Color Black');
insert into pgmaster.colors(id_color, name, description)values('COL002','White','');
insert into pgmaster.colors(id_color, name, description)values('COL003','Blue','');
insert into pgmaster.colors(id_color, name, description)values('COL004','Grey','');

-- INSERT TABLE CAR_GROUPS --

insert into pgmaster.car_groups(id_group, name, description)values('GRP001','Toyota Motor Corporation','');
insert into pgmaster.car_groups(id_group, name, description)values('GRP002','Daimler Motores Gesellschaft','');
insert into pgmaster.car_groups(id_group, name, description)values('GRP003','Tesla Inc','');

-- INSERT TABLE CAR_BRAND --

insert into pgmaster.car_brands(id_brand, name, id_group,description)values('BRA001','Toyota','GRP001','');
insert into pgmaster.car_brands(id_brand, name, id_group,description)values('BRA002','Lexus','GRP001','');
insert into pgmaster.car_brands(id_brand, name, id_group,description)values('BRA003','Mercedes-Benz','GRP002','');
insert into pgmaster.car_brands(id_brand, name, id_group,description)values('BRA004','SMART','GRP002','');
insert into pgmaster.car_brands(id_brand, name, id_group,description)values('BRA005','Tesla Inc','GRP003','');

-- INSERT TABLE CAR_MODELS --

insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD001','Prius','BRA001','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD002','Rav4','BRA001','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD003','RX','BRA002','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD004','LC','BRA002','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD005','For Two','BRA004','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD006','For Two Cabrio','BRA004','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD007','Clase A','BRA003','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD008','Clase E','BRA003','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD009','Model 3','BRA005','');
insert into pgmaster.car_models(id_model, name, id_brand,description)values('MOD010','Model S','BRA005','');

-- INSERT TABLE CURRENCIES --

insert into pgmaster.currencies(id_currency, name, description)values('CUR001','EUR','Euro - Eurozone');
insert into pgmaster.currencies(id_currency, name, description)values('CUR002','USD','Dollar - USA');
insert into pgmaster.currencies(id_currency, name, description)values('CUR003','GBP','Pound - Great Britain');

-- INSERT TABLE INSURANCE_COMPS --

insert into pgmaster.insurance_comps(id_ins_company, name, description)values('ICO001','DIVINA PASTORA SEGUROS, MUTUA DE SEGUROS','');
insert into pgmaster.insurance_comps(id_ins_company, name, description)values('ICO002','BBVA ALLIANZ, SEGUROS Y REASEGUROS, S.A.','');
insert into pgmaster.insurance_comps(id_ins_company, name, description)values('ICO003','ZURICH INSURANCE PLC SUC.ESPAÑA','');

-- INSERT TABLE INSURANCE_POLS --

insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('021606819','453.69','CUR001','ICO001','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('021806712','453.69','CUR001','ICO001','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('21816518','453.69','CUR001','ICO001','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('FG-1284-0019462','658.99','CUR001','ICO002','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('FG-1284-0019812','1023.45','CUR001','ICO002','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('FG-1284-0027495','200','CUR001','ICO002','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('002438-XK','897.25','CUR001','ICO003','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('002925-SP','356.6','CUR001','ICO003','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('003856-WF','555.55','CUR001','ICO003','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('021606820','266.07','CUR001','ICO001','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('021806713','496.25','CUR001','ICO001','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('FG-1284-0019463','701.55','CUR001','ICO002','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('FG-1284-0019813','1066.01','CUR001','ICO002','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('FG-1284-0027496','242.56','CUR001','ICO002','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('21816519','187.79','CUR001','ICO001','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('002439-SD','399.16','CUR001','ICO003','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('002926-SD','399.16','CUR001','ICO003','');
insert into pgmaster.insurance_pols(num_ins_policy, amount, id_currency,id_ins_company,description)values('003857-SD','399.16','CUR001','ICO003','');

-- INSERT TABLE CARS --

insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR001','MOD001','5685FFD','27456','2021-01-23','COL001','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR002','MOD001','5686FFD','29653','2021-01-23','COL001','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR003','MOD001','5687FFD','12455','2021-01-23','COL001','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR004','MOD002','9855GGA','11596','2021-03-12','COL001','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR005','MOD003','6589GGF','14865','2021-03-25','COL002','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR006','MOD004','3578GWD','23547','2021-04-01','COL003','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR007','MOD005','6582HFR','12458','2021-05-01','COL004','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR008','MOD006','5614JAA','9542','2022-01-02','COL001','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR009','MOD007','5248JBG','6475','2022-02-14','COL002','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR010','MOD008','7845JDW','24587','2022-03-08','COL003','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR011','MOD009','2354KJS','5542','2022-06-24','COL004','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR012','MOD010','4454LMO','5362','2022-09-01','COL003','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR013','MOD010','4455LMO','1457','2022-09-01','COL003','');
insert into pgmaster.cars(id_car, id_model, plate,total_km, dt_adquisition,id_color,description)values('CAR014','MOD010','4456LMO','3659','2022-09-01','COL003','');

-- INSERT TABLE HIST_INSURANCE_POL --

insert into pgmaster.hist_insurance_pol(id_car, dt_start, dt_end,num_ins_policy,comment)values('CAR001','2021-01-23','2022-09-30','021606819','Change for a cheaper insurance');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, dt_end,num_ins_policy,comment)values('CAR002','2021-01-23','2022-09-30','021806712','Change for a cheaper insurance');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, dt_end,num_ins_policy,comment)values('CAR003','2021-01-23','2022-09-30','21816518','Change for a cheaper insurance');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, dt_end,num_ins_policy,comment)values('CAR004','2021-03-12','2022-08-31','FG-1284-0019462','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR005','2021-03-25','FG-1284-0019812','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR006','2021-04-01','FG-1284-0027495','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR007','2021-05-01','002438-XK','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR008','2022-01-02','002925-SP','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR009','2022-02-14','003856-WF','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR010','2022-03-08','021606820','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR011','2022-06-24','021806713','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR012','2022-09-01','FG-1284-0019463','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR013','2022-09-01','FG-1284-0019813','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR014','2022-09-01','FG-1284-0027496','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR004','2022-09-01','21816519','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR001','2022-10-01','002439-SD','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR002','2022-10-01','002926-SD','');
insert into pgmaster.hist_insurance_pol(id_car, dt_start, num_ins_policy,comment)values('CAR003','2022-10-01','003857-SD','');

-- INSERT TABLE HIST_REVISIONS --

insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR001','1','10200','2021-07-15','125.45','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR002','1','10200','2021-07-15','145.65','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR003','1','10200','2021-07-15','156.21','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR004','1','10000','2021-09-21','187.21','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR005','1','10100','2021-10-02','196.12','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR006','1','10100','2021-11-05','156.23','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR007','1','10400','2021-12-09','214.28','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR010','1','10300','2022-06-05','745.12','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR001','2','20200','2022-09-10','453.23','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR002','2','20200','2022-09-10','562.12','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR006','2','20200','2022-09-10','325.56','CUR001','');
insert into pgmaster.hist_revisions(id_car, num_revision, km,dt_revision, amount,id_currency,comment)values('CAR010','2','19900','2022-09-10','899.75','CUR001','Change of the brake pads');