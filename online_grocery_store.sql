CREATE DATABASE Grocery_Store;

USE Grocery_Store;

CREATE TABLE Customer (

	Cust_ID CHAR(7) NOT NULL,
	Cust_Name VARCHAR(50) NOT NULL,
	Cust_DOB DATE,
	Cust_email VARCHAR(20) NOT NULL,
	Cust_Add VARCHAR(50) NOT NULL,
	Cust_City VARCHAR (20) NOT NULL,
	Cust_Postcode INT(5) NOT NULL,
	Cust_Phone VARCHAR(20) NOT NULL,
	PRIMARY KEY (Cust_ID)
);

CREATE TABLE Cart (

	Cart_ID CHAR(7) NOT NULL,
	Cust_ID CHAR(7) NOT NULL,
	Total DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (Cart_ID),

	CONSTRAINT FK_CUSTOMER_CART
	FOREIGN KEY Cart(Cust_ID) REFERENCES Customer(Cust_ID)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Deliveryman (

	Deliveryman_ID CHAR(7) NOT NULL,
	Deliveryman_Phone VARCHAR(15) NOT NULL,
	Deliveryman_Name VARCHAR(50) NOT NULL,
	PRIMARY KEY (Deliveryman_ID)
);

CREATE TABLE LoyaltyAcc(

	Account_ID CHAR(7) NOT NULL,
	Loyalty_pts INT(6) NOT NULL,
	Cust_ID CHAR(7) NOT NULL,
	PRIMARY KEY(Account_ID),

	CONSTRAINT FK_CUSTOMER_LOYALTYACC
	FOREIGN KEY LoyaltyAcc(Cust_ID) REFERENCES Customer(Cust_ID)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Coupon(

	Coupon_ID CHAR(7) NOT NULL,
	Coupon_value INT(10) NOT NULL,
	Account_ID CHAR(7) NOT NULL,
	PRIMARY KEY(Coupon_ID),

	CONSTRAINT FK_LOYALTYACC_COUPON
	FOREIGN KEY Coupon(Account_ID) REFERENCES LoyaltyAcc(Account_ID)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

 
CREATE TABLE Transactions(

    Transactions_ID CHAR(7) NOT NULL,
    Total DECIMAL(6,2)NOT NULL,
    Payment_meth VARCHAR(20) NOT NULL,
    Billing_add VARCHAR(50) NOT NULL,
    Loyalty_pts_change INT(6),
    Cart_ID CHAR(7) NOT NULL,
    PRIMARY KEY(Transactions_ID),

    CONSTRAINT FK_CART_TRANSACTIONS
    FOREIGN KEY Transactions(Cart_ID)REFERENCES Cart(Cart_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE wholesaler(

    Wholesaler_ID CHAR(7) NOT NULL,
    Wholesaler_name VARCHAR(50) NOT NULL,
    Wholesaler_email VARCHAR(30),
    Wholesaler_phone VARCHAR(15),
    PRIMARY KEY(Wholesaler_ID)
);

CREATE TABLE product(

    Prod_ID CHAR(7) NOT NULL,
    Prod_name VARCHAR(50) NOT NULL,
    Prod_stock INT(5) NOT NULL,
    Prod_category VARCHAR(20) NOT NULL,
    Wholesaler_ID CHAR(7) NOT NULL,
    Prod_price DECIMAL(6,2) NOT NULL,
    Prod_PurchasePrice DECIMAL(6,2) NOT NULL,
    PRIMARY KEY(Prod_ID),

    CONSTRAINT FK_WHOLESALER_PRODUCT
    FOREIGN KEY Product(Wholesaler_ID) 
    REFERENCES Wholesaler(Wholesaler_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Receipt(
        
    Receipt_ID CHAR(7) not null,
    Delivery_status VARCHAR(10) not null,
    Shipping_add VARCHAR(50) not null,  
    Transactions_ID CHAR(7) NOT NULL,
    Deliveryman_ID CHAR(7) NOT NULL,

    CONSTRAINT FK_TRANSACTION_RECEIPT
    FOREIGN KEY Receipt(Transactions_ID) REFERENCES Transactions(Transactions_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT FK_DELIVERYMAN_RECEIPT
    FOREIGN KEY Receipt(Deliveryman_ID) REFERENCES Deliveryman(Deliveryman_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Line(
        
    Line_ID CHAR(7) not null,
    Prod_qty INT(6) not null,
    Subtotal DECIMAL(6,2) not null,
    Prod_ID CHAR(7) NOT NULL,
    Cart_ID CHAR(7) NOT NULL,

    CONSTRAINT FK_PRODUCT_LINE
    FOREIGN KEY Line(Prod_ID) REFERENCES Product(Prod_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
	
    CONSTRAINT FK_Cart_LINE
    FOREIGN KEY Line(Cart_ID) REFERENCES Cart(Cart_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

--done
INSERT INTO Customer (Cust_ID, Cust_Name, Cust_DOB, Cust_email, Cust_Add, Cust_City, Cust_Postcode, Cust_Phone) 
VALUES
('CS00001', 'Ahmad Faiz', '1985-04-12', 'ahmad.f@gmail.com', '123 Jalan Tun Razak', 'Kuala Lumpur', 50400, '+60 12-3456789'),
('CS00002', 'Siti Nor', '1990-08-25', 'siti.n@gmail.com', '456 Lorong Bukit Bintang', 'Kuala Lumpur', 55100, '+60 16-9876543'),
('CS00003', 'Lim Wei Sheng', '1978-11-03', 'lim.w@gmail.com', '789 Taman Tun Dr Ismail', 'Petaling Jaya', 60000, '+60 13-1122334'),
('CS00004', 'Aisha Rahman', '1992-02-18', 'aisha.r@gmail.com', '321 Jalan Duta', 'Kuala Lumpur', 50480, '+60 17-2233445'),
('CS00005', 'Chong Mei Ling', '1983-07-07', 'chong.m@gmail.com', '654 Jalan Sultan Ismail', 'Kuala Lumpur', 50250, '+60 14-5566778'),
('CS00006', 'Ariff Abdullah', '1988-05-30', 'ariff.a@gmail.com', '987 Jalan Ampang', 'Ampang', 68000, '+60 19-6677889'),
('CS00007', 'Nurul Huda', '1995-11-23', 'nurul.h@gmail.com', '321 Jalan Bukit Ledang', 'Kuala Lumpur', 50490, '+60 12-9988776'),
('CS00008', 'Kevin Yap', '1982-01-15', 'kevin.y@gmail.com', '456 Jalan Puchong', 'Puchong', 47100, '+60 16-7766554'),
('CS00009', 'Faridah Ali', '1975-03-19', 'faridah.a@gmail.com', '789 Jalan Cheras', 'Cheras', 56000, '+60 13-3344552'),
('CS00010', 'Samuel Wong', '1991-09-29', 'samuel.w@gmail.com', '123 Jalan Bukit Jalil', 'Kuala Lumpur', 57000, '+60 17-9988776'),
('CS00011', 'Sarah Tan', '1986-12-05', 'sarah.t@gmail.com', '456 Jalan Kepong', 'Kepong', 52100, '+60 19-1122334'),
('CS00012', 'Mohd Zaid', '1979-08-17', 'mohd.z@gmail.com', '789 Jalan Kuching', 'Kuala Lumpur', 51200, '+60 12-4455667'),
('CS00013', 'Jia Wei Lee', '1994-04-22', 'jia.wei.l@gmail.com', '321 Jalan Ipoh', 'Kuala Lumpur', 51200, '+60 14-7788990'),
('CS00014', 'Natasha Lim', '1980-06-30', 'natasha.l@gmail.com', '654 Jalan Segambut', 'Segambut', 51200, '+60 16-8899001'),
('CS00015', 'Hafiz Hamid', '1993-10-09', 'hafiz.h@gmail.com', '987 Jalan Damansara', 'Petaling Jaya', 47400, '+60 13-5566778'),
('CS00016', 'Karen Chew', '1984-03-14', 'karen.c@gmail.com', '321 Jalan Tun H S Lee', 'Kuala Lumpur', 50000, '+60 17-6677889'),
('CS00017', 'Azlan Shah', '1987-07-21', 'azlan.s@gmail.com', '456 Jalan Imbi', 'Kuala Lumpur', 55100, '+60 19-9988776'),
('CS00018', 'Elaine Tan', '1996-11-11', 'elaine.t@gmail.com', '789 Jalan Raja Chulan', 'Kuala Lumpur', 50200, '+60 12-7788990'),
('CS00019', 'Ibrahim Khalid', '1977-02-18', 'ibrahim.k@gmail.com', '123 Jalan Ampang Hilir', 'Ampang', 55000, '+60 14-1122334'),
('CS00020', 'Michelle Ng', '1992-08-06', 'michelle.n@gmail.com', '654 Jalan Damai', 'Kuala Lumpur', 55000, '+60 16-2233445'),
('CS00021', 'Bryan Ng', '1994-08-06', 'bryan.n@gmail.com', '65 Jalan Amai', 'Kuala Lumpur', 55000, '+60 16-2232545'),
('CS00022', 'Samuel Ng', '1998-02-07', 'samuel.n@gmail.com', '54 Jalan Dami', 'Kuala Lumpur', 55000, '+60 16-2278445'),
('CS00023', 'Ezekiel Ng', '1991-10-09', 'ezekiel.n@gmail.com', '6 Jalan Aman', 'Kuala Lumpur', 55000, '+60 16-2229445'),
('CS00024', 'Braun Ng', '2001-11-21', 'braun.n@gmail.com', '124 Jalan Chulan', 'Kuala Lumpur', 55000, '+60 16-2233095'),
('CS00025', 'Dick Ng', '2004-12-07', 'dick.n@gmail.com', '164 Jalan Kuching', 'Kuala Lumpur', 55000, '+60 16-2233525');

--done
INSERT INTO Cart (Cart_ID, Cust_ID, Total)
VALUES
('CA00001', 'CS00014', 22.50),
('CA00002', 'CS00007', 43.60),
('CA00003', 'CS00019', 54.00),
('CA00004', 'CS00014', 55.00),
('CA00005', 'CS00013', 61.20),
('CA00006', 'CS00001', 159.10),
('CA00007', 'CS00008', 18.00),
('CA00008', 'CS00020', 46.00),
('CA00009', 'CS00005', 156.00),
('CA00010', 'CS00016', 420.00),
('CA00011', 'CS00018', 12.60),
('CA00012', 'CS00009', 15.00),
('CA00013', 'CS00011', 252.00),
('CA00014', 'CS00003', 123.00),
('CA00015', 'CS00007', 50.00),
('CA00016', 'CS00012', 16.00),
('CA00017', 'CS00004', 28.80),
('CA00018', 'CS00010', 21.50),
('CA00019', 'CS00006', 17.50),
('CA00020', 'CS00015', 140.00),
('CA00021', 'CS00022', 67.30),
('CA00022', 'CS00016', 80.00),
('CA00023', 'CS00003', 35.50),
('CA00024', 'CS00020', 106.00),
('CA00025', 'CS00001', 69.20),
('CA00026', 'CS00025', 81.50),
('CA00027', 'CS00022', 36.50),
('CA00028', 'CS00019', 62.50),
('CA00029', 'CS00021', 102.00),
('CA00030', 'CS00015', 85.00);


--done
INSERT INTO Deliveryman (Deliveryman_ID, Deliveryman_Phone, Deliveryman_Name)
VALUES
('DE00001', '+60 12-3456789', 'John Smith'),
('DE00002', '+60 16-9876543', 'Michael Johnson'),
('DE00003', '+60 13-1122334', 'Emily Davis'),
('DE00004', '+60 17-2233445', 'Jessica Brown'),
('DE00005', '+60 14-5566778', 'David Miller'),
('DE00006', '+60 19-6677889', 'Sarah Wilson'),
('DE00007', '+60 12-9988776', 'Christopher Taylor'),
('DE00008', '+60 16-7766554', 'Ashley Martinez'),
('DE00009', '+60 13-3344552', 'Daniel Anderson'),
('DE00010', '+60 17-9988776', 'Jessica Thomas'),
('DE00011', '+60 19-1122334', 'Matthew White'),
('DE00012', '+60 12-4455667', 'Jennifer Harris'),
('DE00013', '+60 14-7788990', 'William Martin'),
('DE00014', '+60 16-8899001', 'Elizabeth Garcia'),
('DE00015', '+60 13-5566778', 'Joshua Lopez'),
('DE00016', '+60 17-6677889', 'Amanda Lee'),
('DE00017', '+60 19-9988776', 'Ryan Clark'),
('DE00018', '+60 12-7788990', 'Stephanie Rodriguez'),
('DE00019', '+60 14-1122334', 'Andrew Lewis'),
('DE00020', '+60 16-2233445', 'Olivia Walker');

--done
INSERT INTO LoyaltyAcc (Account_ID, Loyalty_pts, Cust_ID)
VALUES
('LO00001', 1000,'CS00001'),
('LO00002', 456, 'CS00003'),
('LO00003', 921, 'CS00004'),
('LO00004', 777, 'CS00005'),
('LO00005', 167, 'CS00006'),
('LO00006', 492, 'CS00007'),
('LO00007', 589, 'CS00008'),
('LO00008', 888, 'CS00009'),
('LO00009', 368, 'CS00010'),
('LO00010', 743, 'CS00011'),
('LO00011', 328, 'CS00012'),
('LO00012', 734, 'CS00013'),
('LO00013', 324, 'CS00014'),
('LO00014', 953, 'CS00015'),
('LO00015', 865, 'CS00016'),
('LO00016', 234, 'CS00019'),
('LO00017', 467, 'CS00020'),
('LO00018', 567, 'CS00021'),
('LO00019', 345, 'CS00022'),
('LO00020', 1234, 'CS00025');

--done
INSERT INTO Coupon (Coupon_ID, Coupon_value, Account_ID)
VALUES
('CO00001', 10, 'LO00016'),
('CO00002', 15, 'LO00013'),
('CO00003', 10, 'LO00012'),
('CO00004', 20, 'LO00001'),
('CO00005', 20, 'LO00004'),
('CO00006', 50, 'LO00015'),
('CO00007', 20, 'LO00010'),
('CO00008', 15, 'LO00002'),
('CO00009', 10, 'LO00006'),
('CO00010', 20, 'LO00014'),
('CO00011', 5, 'LO00019'),
('CO00012', 10, 'LO00015'),
('CO00013', 5, 'LO00002'),
('CO00014', 20, 'LO00017'),
('CO00015', 10, 'LO00001'),
('CO00016', 15, 'LO00020'),
('CO00017', 5, 'LO00019'),
('CO00018', 5, 'LO00016'),
('CO00019', 20, 'LO00018'),
('CO00020', 15, 'LO00014');

--done
INSERT INTO Transactions(Transactions_ID,Total,Payment_meth,Billing_add,Loyalty_pts_change,Cart_ID)
VALUES
('TR00001',22.50,'E-Wallet','31 Jalan Ipoh, 51200, Kuala Lumpur', 22,'CA00001' ),
('TR00002',43.60,'Debit Card','23 Jalan Ampang Hilir, 55000, Ampang', 43,'CA00002'),
('TR00003',39.00,'Debit Card','79 Jalan Raja Chulan, 50200, Kuala Lumpur', 0,'CA00003'),
('TR00004',45.00,'Online Transfer',' 65 Jalan Damai, 55000, Kuala Lumpur', 0,'CA00004'),
('TR00005',51.20,'E-wallet','78 Jalan Kuching,48000 , Kuala Lumpur', 0,'CA00005'),
('TR00006',139.10,'E-wallet','32 Jalan Duta, 50480, Kuala Lumpur', 0,'CA00006' ),
('TR00007',18.00,'Online Transfert','45 Lorong Bukit Bintang, 55100 , Kuala Lumpur', 18, 'CA00007'),
('TR00008',46.00,'Credit Card','46 Jalan Imbi, 55100, Kuala Lumpur', 46,'CA00008'),
('TR00009',136.00,'Online Transfer','789 Taman Tun Dr Ismail,60000, Petaling Jaya ', 0,'CA00009'),
('TR00010',370.00,'Debit Card','87 Jalan Ampang, 68000, Ampang', 0,'CA00010'),
('TR00011',12.60,'Debit Card','12 Jalan Tun Razak,Kuala Lumpur,50400', 12,'CA00011'),
('TR00012',15.00,'E-wallet','32 Jalan Ipoh, 51200, Kuala Lumpur', 15,'CA00012'),
('TR00013',232.00,'E-wallet','21 Jalan Duta, 50480, Kuala Lumpur', 0,'CA00013'),
('TR00014',108.00,'Debit Card','46 Lorong Bukit Bintang, 55100 , Kuala Lumpur', 0,'CA00014'),
('TR00015',40.00,'E-wallet','97 Jalan Ampang, 68000, Ampang', 0,'CA00015'),
('TR00016',16.00,'Credit Card','12 Jalan Ampang Hilir, 55000, Ampang', 16,'CA00016'),
('TR00017',28.80,'E-wallet','456 Jalan Imbi, 55100, Kuala Lumpur', 28,'CA00017'),
('TR00018',21.50,'Debit Card','654 Jalan Sultan Ismail, 50250, Kuala Lumpur', 21,'CA00018'),
('TR00019',17.50,'Credit Card','654 Jalan Damai, 55000, Kuala Lumpur', 17,'CA00019'),
('TR00020',120.00,'Credit Card','23 Jalan Tun Razak,Kuala Lumpur,50400', 0,'CA00020' ),
('TR00021',62.30,'E-wallet','21 Jalan Ipoh, 51200, Kuala Lumpur', 0,'CA00021' ),
('TR00022',65.00,'Debit Card','31 Jalan Duta, 50480, Kuala Lumpur', 0,'CA00022' ),
('TR00023',30.50,'Credit Card','987 Jalan Ampang, 68000, Ampang', 0,'CA00023' ),
('TR00024',86.00,'Online Transfer','456 Lorong Bukit Bintang, 55100 , Kuala Lumpur', 0,'CA00024' ),
('TR00025',59.20,'Credit Card','789 Jalan Kuching,48000 , Kuala Lumpur', 0,'CA00025' ),
('TR00026',66.50,'Debit Card','123 Jalan Tun Razak,Kuala Lumpur,50400', 0,'CA00026' ),
('TR00027',31.50,'E-wallet','321 Jalan Ipoh, 51200, Kuala Lumpur', 0,'CA00027' ),
('TR00028',57.50,'Debit Card','789 Jalan Raja Chulan, 50200, Kuala Lumpur', 0,'CA00028' ),
('TR00029',82.00,'Credit Card','123 Jalan Ampang Hilir, 55000, Ampang', 0,'CA00029' ),
('TR00030',70.00,'Online Transfer','321 Jalan Duta, 50480, Kuala Lumpur', 0,'CA00030' );


--done
INSERT INTO wholesaler(Wholesaler_ID,Wholesaler_name ,Wholesaler_email ,Wholesaler_phone)
VALUES
('WH00001','UNFI','UNFI@gmail.com','014-5288634'),
('WH00002','KeHE Distributors','KeHe@gmail.com','019-9955343'),
('WH00003','C&S Wholesale Grocers','C&SWholesale@gmail.com','011-2777000'),
('WH00004','SpartanNash','spartan8123@gmail.com','012-4518500'),
('WH00005','Gordon Food Service','GordonF@gmail.com','012-9686474'),
('WH00006','Boxed Wholesale','BoxedWholesale@gmail.com','019-8287755'),
('WH00007','FreshDirect','freshdirect@gmail.com','013-2837374'),
('WH00008','Azure Standard','azurestand@gmail.com','011-2008350'),
('WH00009','Tree of Life','treelife1@gmail.com','018-3335123'),
('WH00010','Ben''s Independent Grocer','Bengrocer@gmail.com','017-7431227'),
('WH00011','NSK Trade City','NSKtradeI@gmail.com','014-5023134'),
('WH00012','Hock Choon Supermarket','HCSuper@gmail.com','019-966433'),
('WH00013','Village Grocer','VillageGrocer@gmail.com','011-28943020'),
('WH00014','KK Super Mart','KKsuper@gmail.com','012-4512333980'),
('WH00015','Segi Fresh Market','Segi@gmail.com','012-90094534'),
('WH00016','Econsave','Econsave@gmail.com','019-8321455'),
('WH00017','Jaya Grocer Wholesale','GrocerJaya@gmail.com','013-77563094'),
('WH00018','Mydin','Mydin@gmail.com','017-2012309'),
('WH00019','Giant Wholesale','Giant@gmail.com','018-32154223'),
('WH00020','TF Value-Mart','TFValue-Mart@gmail.com','017-0912453');

--done
INSERT INTO product(Prod_ID,Prod_name,Prod_stock,Prod_category,Wholesaler_ID,Prod_price,Prod_PurchasePrice)
VALUES
('PR00001','Banana',837,'Fruits', 'WH00001',4.2,3.9),
('PR00002','Orange',284,'Fruits','WH00005',6.1,5.4),
('PR00003','Strawberry',799,'Fruits','WH00006',20.5,18.3),
('PR00004','Grape',731,'Fruits','WH00002',15.5, 14.3),
('PR00005','Durian',542,'Fruits','WH00002',50.0, 39.9),
('PR00006','Carrot',710,'Vegetables','WH00004',3.2,1.5),
('PR00007','Broccoli',514,'Vegetables','WH00003',8.5,7.0),
('PR00008','Spinach',983,'Vegetables','WH00007',4.0,3.3),
('PR00009','Tomato',667,'Vegetables','WH00001',5.3,4.5),
('PR00010','Potato',124,'Vegetables','WH00001',3.2,2.8),
('PR00011','Soy milk',278,'Dairy Products','WH00005',6.0,5.5),
('PR00012','Cheese',436,'Dairy Products','WH00006',20.0,17),
('PR00013','Butter',987,'Dairy Products','WH00002',10.0,8.5),
('PR00014','Chicken Breast',113,'Proteins','WH00002',12.0,10.0),
('PR00015','Salmon',545,'Proteins','WH00004',60.0,58.0),
('PR00016','Tuna',658,'Proteins','WH00003',30.5,28.0),
('PR00017','Ground Beef',111,'Proteins','WH00011',28.0,27.5),
('PR00018','Berries',98,'Fruits','WH00008',21.5,19.4),
('PR00019','Onions',45,'Vegetables','WH00007',3.5,2.9),
('PR00020','Eggs',234,'Proteins','WH00008',12.0,11.5),
('PR00021','Tofu',546,'Proteins','WH00008',2.5,2.0),
('PR00022','Rambutan',254,'Fruits','WH00009', 12.0,11.5),
('PR00023','Mangosteen',743,'Fruits','WH00009', 33.0,30.0),
('PR00024','Rice',126,'Pantry Staples','WH00010',15.0,14.5),
('PR00025','Pasta',223,'Pantry Staples','WH00015',12.0,11.0),
('PR00026','Bread',299,'Pantry Staples','WH00012',3.0,2.5),
('PR00027','Flour',243,'Pantry Staples','WH00011',2.0,1.9),
('PR00028','Sugar',657,'Pantry Staples','WH00011',2.5,2.3),
('PR00029','Salt',886,'Pantry Staples','WH00012',4.3,4.1),
('PR00030','Pepper',334,'Pantry Staples','WH00013', 15.0,14.0),
('PR00031','Olive oil',229,'Pantry Staples','WH00014', 25.5,25.0),
('PR00032','Vinegar',442,'Pantry Staples','WH00015', 4.3,4.0),
('PR00033','Baking Powder',676,'Pantry Staples','WH00010', 3.5,3.3),
('PR00034','Ketchup',342,'Condiments and Sauces','WH00016', 5.5,4.5),
('PR00035','Mustard',660,'Condiments and Sauces','WH00018', 8.0,7.5),
('PR00036','Mayonnaise',632,'Condiments and Sauces','WH00017', 10.0,9.5),
('PR00037','Soy Sauce',157,'Condiments and Sauces','WH00018', 6.5,6.0),
('PR00038','Hot Sauce',803,'Condiments and Sauces','WH00017', 8.0,7.7),
('PR00039','Thousand Island Sauce',99,'Condiments and Sauces','WH00016', 12.0,11.5),
('PR00040','Fish Sauce',340,'Condiments and Sauces','WH00016', 5.0,4.5),
('PR00041','Popcorn',78,'Snacks','WH00020', 5.5,5.0),
('PR00042','Chips',99,'Snacks','WH00018', 3.0,2.6),
('PR00043','Crackers',243,'Snacks','WH00019', 4.0,3.5),
('PR00044','Cookies',987,'Snacks','WH00018', 8.5,7.5);

--done
INSERT INTO Receipt(Receipt_ID,Delivery_status,Shipping_add,Transactions_ID,Deliveryman_ID)
VALUES
('RE00001','delivered','123 Jalan Tun Razak 50400 Kuala Lumpur','TR00001','DE00001'),
('RE00002','preparing','456 Lorong Bukit Bintang 55100 Kuala Lumpur','TR00002','DE00002'),
('RE00003','preparing','789 Taman Tun Dr Ismail 60000 Petaling Jaya','TR00003','DE00003'),
('RE00004','delivered','321 Jalan Duta 50480 Kuala Lumpur','TR00004','DE00004'),
('RE00005','transit','654 Jalan Sultan Ismail 50250 Kuala Lumpur','TR00005','DE00018'),
('RE00006','transit','987 Jalab Ampang 68000 Ampang','TR00006','DE00006'),
('RE00007','delivered','321 Jalan Bukit Ledang 50490 Kuala Lumpur','TR00007','DE00007'),
('RE00008','delivered','456 Jalan Puchong 47100 Puchong','TR00008','DE00008'),
('RE00009','preparing','789 Jalan Cheras 56000 Cheras','TR00009','DE00009'),
('RE00010','delivered','123 Jalan Bukit Jahil 57000 Kuala Lumpur','TR00010','DE00010'),
('RE00011','preparing','456 Jalan Kepong 52100 Kepong','TR00011','DE00001'),
('RE00012','transit','789 Jalan Kuching 51200 Kuala Lumpur','TR00012','DE00012'),
('RE00013','preparing','321 Jalan Ipoh 51200 Kuala Lumpur','TR00013','DE00013'),
('RE00014','delivered','654 Jalan Segambut 51200 Segambut','TR00014','DE00014'),
('RE00015','preparing','987 Jalan Damasara 47400 Petaling Jaya','TR00015','DE00015'),
('RE00016','delivered','321 Jalan Tun H S Lee 50000 Kuala Lumpur','TR00016','DE00012'),
('RE00017','preparing','456 Jalan Imbi 55100 Kuala Lumpur','TR00017','DE00017'),
('RE00018','delivered','789 Jalan Raja Chulan 50200 Kuala Lumpur','TR00018','DE00018'),
('RE00019','transit','123 Jalan Ampang Hilir 55000 Ampang','TR00019','DE00019'),
('RE00020','delivered','654 Jalan Damai 55000 Kuala Lumpur','TR00020','DE00020'),
('RE00021','transit','341 Jalan Duta 50480 Kuala Lumpur','TR00021','DE00004'),
('RE00022','preparing','739 Taman Tun Dr Ismail 60000 Petaling Jaya','TR00022','DE00002'),
('RE00023','delivered','189 Jalan Cheras 56000 Cheras','TR00023','DE00003'),
('RE00024','transit','656 Lorong Bukit Bintang 55100 Kuala Lumpur','TR00024','DE00001'),
('RE00025','delivered','287 Jalab Ampang 68000 Ampang','TR00025','DE00010'),
('RE00026','preparing','543 Jalan Kepong 52100 Kepong','TR00026','DE00012'),
('RE00027','transit','324 Jalan Bukit Jahil 57000 Kuala Lumpur','TR00027','DE00015'),
('RE00028','delivered','267 Jalan Sultan Ismail 50250 Kuala Lumpur','TR00028','DE00020'),
('RE00029','preparing','788 Jalan Puchong 47100 Puchong','TR00029','DE00008'),
('RE00030','delivered','256 Jalan Ampang Hilir 55000 Ampang','TR00030','DE00004');

--done
INSERT INTO Line(Line_ID,Prod_qty,Subtotal,Prod_ID,Cart_ID)
VALUES
('LI00001',1,8.50,'PR00007','CA00001'),
('LI00002',3,18.00,'PR00011','CA00007'),
('LI00003',6,123.00,'PR00003','CA00014'),
('LI00004',2,31.00,'PR00004','CA00008'),
('LI00005',3,12.60,'PR00001','CA00011'),
('LI00006',5,17.50,'PR00019','CA00019'),
('LI00007',7,140.00,'PR00012','CA00020'),
('LI00008',9,28.80,'PR00006','CA00017'),
('LI00009',2,10.60,'PR00009','CA00002'),
('LI00010',2,12.20,'PR00002','CA00005'),
('LI00011',1,10.00,'PR00013','CA00004'),
('LI00012',1,30.50,'PR00016','CA00006'),
('LI00013',1,50.00,'PR00005','CA00015'),
('LI00014',4,16.00,'PR00008','CA00016'),
('LI00015',9,54.00,'PR00011','CA00003'),
('LI00016',10,120.00,'PR00014','CA00006'),
('LI00017',13,156.00,'PR00020','CA00009'),
('LI00018',7,420.00,'PR00015','CA00010'),
('LI00019',9,252.00,'PR00017','CA00013'),
('LI00020',1,21.50,'PR00018','CA00018'),
('LI00021',4,10.00,'PR00021','CA00001'),
('LI00022',2,4.00,'PR00027','CA00001'),
('LI00023',1,33.00,'PR00023','CA00002'),
('LI00024',3,45.00,'PR00024','CA00004'),
('LI00025',2,24.00,'PR00025','CA00005'),
('LI00026',5,15.00,'PR00026','CA00012'),
('LI00027',10,20.00,'PR00027','CA00005'),
('LI00028',2,5.00,'PR00028','CA00005'),
('LI00029',2,8.60,'PR00029','CA00006'),
('LI00030',1,15.00,'PR00030','CA00008'),
('LI00031',1,25.50,'PR00031','CA00027'),
('LI00032',1,4.30,'PR00032','CA00021'),
('LI00033',2,7.00,'PR00033','CA00021'),
('LI00034',5,27.50,'PR00034','CA00023'),
('LI00035',5,40.00,'PR00035','CA00026'),
('LI00036',1,10.00,'PR00036','CA00024'),
('LI00037',1,6.50,'PR00037','CA00026'),
('LI00038',10,80.00,'PR00038','CA00022'),
('LI00039',3,36.00,'PR00039','CA00024'),
('LI00040',7,35.00,'PR00040','CA00026'),
('LI00041',2,11.00,'PR00041','CA00027'),
('LI00042',4,102.00,'PR00031','CA00029'),
('LI00043',2,8.00,'PR00043','CA00023'),
('LI00044',7,42.70,'PR00002','CA00025'),
('LI00045',5,26.50,'PR00009','CA00025'),
('LI00046',1,60.00,'PR00015','CA00024'),
('LI00047',2,56.00,'PR00017','CA00021'),
('LI00048',1,15.00,'PR00024','CA00028'),
('LI00049',5,17.50,'PR00033','CA00028'),
('LI00050',10,85.00,'PR00044','CA00030'),
('LI00051',5,30.00,'PR00011','CA00028');
     

select Cust_Name, Cust_DOB, Cust_email, Cust_Add, Cust_City, Cust_Postcode, Cust_Phone from customer, cart 
where customer.cust_id = cart.cust_id;

select * from customer, cart 
where customer.cust_id = cart.cust_id
and count(distinct cart.cust_id) > 1
;

select sum(transactions.Loyalty_pts_change) as total_number_of_loyalty_points_collected
from transactions, cart, customer
where transactions.cart_id = cart.cart_id
and customer.cust_id = cart.cust_id
and cust_name = 'natasha lim';
