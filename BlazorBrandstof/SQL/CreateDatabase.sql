DROP
DATABASE IF EXISTS brandstof;
CREATE
DATABASE brandstof;

USE
brandstof;

CREATE TABLE waiter
(
    Name nvarchar(255),
    PRIMARY KEY (Name)
);

CREATE TABLE categories 
(
    Id  int AUTO_INCREMENT NOT NULL,
    Name nvarchar(255),
    PRIMARY KEY (Id)
);

CREATE TABLE products
(
    Id    int AUTO_INCREMENT NOT NULL,
    Name  nvarchar(255)      NOT NULL,
    Price decimal(15,2)      NOT NULL,
    Category nvarchar(255),

    PRIMARY KEY (Id),
    FOREIGN KEY (Category) REFERENCES categories(Name)
);

CREATE TABLE tables
(
    Id  int AUTO_INCREMENT          NOT NULL,
    Name   nvarchar(255)            NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE orders
(
    Id        int AUTO_INCREMENT NOT NULL,
    Timestamp datetime           NOT NULL default CURRENT_TIMESTAMP,
    TableId   int,
    WaiterName nvarchar(255), 

    PRIMARY KEY (Id),
    FOREIGN KEY (TableId) REFERENCES tables (Id),
    FOREIGN KEY (WaiterName) REFERENCES waiter (Name)
);

CREATE TABLE rounds
(
    Id      int AUTO_INCREMENT NOT NULL,
    Status  nvarchar(255),
    OrderId int,

    PRIMARY KEY (Id),
    FOREIGN KEY (OrderId) REFERENCES orders (Id)
);

CREATE TABLE product_round
(
    ProductId  int NOT NULL,
    RoundId    int NOT NULL,

    Amount     int NOT NULL,
    AmountPaid int,

    FOREIGN KEY (ProductId) REFERENCES products (Id),
    FOREIGN KEY (RoundId) REFERENCES rounds (Id)
);

INSERT INTO waiter (Name) 
VALUES ('Waiter1');

INSERT INTO waiter (Name)
VALUES ('Waiter2');

INSERT INTO waiter (Name)
VALUES ('Waiter3');

INSERT INTO categories (Name)
VALUES ('Warm drinks');

INSERT INTO categories (Name)
VALUES ('Cold drinks');

INSERT INTO categories (Name)
VALUES ('Alcohol free drinks');

INSERT INTO categories (Name)
VALUES ('Pastry\'s and dessert');

INSERT INTO categories (Name)
VALUES ('Snacks');

INSERT INTO categories (Name)
VALUES ('Lunch');

INSERT INTO categories (Name)
VALUES ('Catering drinks');

INSERT INTO categories (Name)
VALUES ('Catering food');

INSERT INTO categories (Name)
VALUES ('Re-usables / disposables');

INSERT INTO products (Name, Price, Category) 
VALUES ('Coffee creme', '1.22', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Coffee creme large', '1.88', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Cappuccino', '1.50', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Cappuccino large', '2.16', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Espresso', '1.22', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Double Espresso', '1.88', 'Warm drinks');

INSERT INTO tables (Name)
VALUES ('table1');

INSERT INTO tables (Name)
VALUES ('table2');

INSERT INTO tables (Name)
VALUES ('table3');
