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
