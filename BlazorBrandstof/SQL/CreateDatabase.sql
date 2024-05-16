﻿DROP
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

CREATE TABLE products
(
    Id    int AUTO_INCREMENT NOT NULL,
    Name  nvarchar(255)      NOT NULL,
    Price integer NOT NULL,

    PRIMARY KEY (Id)
);

CREATE TABLE tables
(
    Id int AUTO_INCREMENT NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE orders
(
    Id         int AUTO_INCREMENT NOT NULL,
    Timestamp  datetime NOT NULL default CURRENT_TIMESTAMP,
    TableId    int,
    WaiterName nvarchar(255),

    PRIMARY KEY (Id),
    FOREIGN KEY (TableId) REFERENCES tables (id),
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

INSERT INTO products (Name, Price) VALUES ('Coffee', 20);
INSERT INTO products (Name, Price) VALUES ('Tea', 10);
INSERT INTO products (Name, Price) VALUES ('Milk', 30);