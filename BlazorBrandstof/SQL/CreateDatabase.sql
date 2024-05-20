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
    Name nvarchar(255),
    PRIMARY KEY (Name)
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
    Name   nvarchar(255)            NOT NULL,
    PRIMARY KEY (Name)
);

CREATE TABLE orders
(
    Id        int AUTO_INCREMENT NOT NULL,
    Timestamp datetime           NOT NULL default CURRENT_TIMESTAMP,
    TableName   nvarchar(255),
    WaiterName nvarchar(255), 

    PRIMARY KEY (Id),
    FOREIGN KEY (TableName) REFERENCES tables (Name),
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
VALUES ('waiter1');

INSERT INTO waiter (Name)
VALUES ('waiter2');

INSERT INTO categories (Name)
VALUES ('hotdrinks');

INSERT INTO categories (Name)
VALUES ('colddrinks');

INSERT INTO categories (Name)
VALUES ('food');

INSERT INTO products (Name, Price, Category) 
VALUES ('coffee', '2.50', 'hotdrinks');

INSERT INTO products (Name, Price, Category)
VALUES ('tea', '1.50', 'hotdrinks');

INSERT INTO products (Name, Price, Category)
VALUES ('softdrinks', '2.79', 'colddrinks');

INSERT INTO products (Name, Price, Category)
VALUES ('iced coffee', '2.79', 'colddrinks');

INSERT INTO products (Name, Price, Category)
VALUES ('applepie', '3.79', 'food');

INSERT INTO products (Name, Price, Category)
VALUES ('carrotcake', '2.49', 'food');

INSERT INTO tables (Name)
VALUES ('table1');

INSERT INTO tables (Name)
VALUES ('table2');

INSERT INTO tables (Name)
VALUES ('table3');
