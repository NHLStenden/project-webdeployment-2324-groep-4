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
    Id int AUTO_INCREMENT NOT NULL,
    Name nvarchar(255),
    PRIMARY KEY (Id)
);

CREATE TABLE products
(
    Id    int AUTO_INCREMENT NOT NULL,
    Name  nvarchar(255)      NOT NULL,
    Price decimal(15,2)      NOT NULL,
    CategoryId int,

    PRIMARY KEY (Id),
    FOREIGN KEY (CategoryId) REFERENCES categories(Id)
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
VALUES ('Re-usables / disposables');

INSERT INTO products (Name, Price, CategoryId) 
VALUES ('Coffee creme', '1.22', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Coffee creme large', '1.88', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Cappuccino', '1.50', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Cappuccino large', '2.16', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Espresso', '1.22', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Double Espresso', '1.88', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Latte Macchiato', '1.50', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Latte Macchiato large', '2.16', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Flat White', '1.88', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Tea', '1.17', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fresh Tea', '1.30', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Hot Chocolate Dark', '2.10', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Chai Latte', '2.60', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Dirty Chai Latte', '3.25', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Coffee Special', '3.00', 1);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Smoothie', '2.50', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Homemade Ice Tea', '2.75', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Water Still', '2.10', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Water Sparkling', '2.10', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Apple Juice', '2.30', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Lemon Lime Soda', '2.75', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Ice Latte', '2.70', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Tonic', '3.20', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fritz Cola', '2.60', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fritz Rhubarb', '2.60', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fritz Limo Sinas', '2.60', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fritz Lemon', '2.60', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fritz Apple', '2.60', 2);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Virgin Gin Tonic', '5.50', 3);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Van de streek IPA', '4.40', 3);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Nuchtere heit', '3.90', 3);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Heineken draft 0,0%', '3.20', 3);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Mocktail of the day', '5.50', 3);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Pie of the day', '2.25', 4);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Fluffy pancakes', '6.00', 4);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Bitterballen P.P', '1.10', 5);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Roasted potato wedges', '4.00', 5);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Vegetarian springroll', '4.50', 5);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Soup of the Day', '4.50', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('12-Uurtje', '6.60', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Croquette on sourdough bread', '6.50', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Wrap Crispy Chicken', '7.30', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Pot of the Season', '7.20', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Grandma\'s meatball', '6.20', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('LBS Circulware cup', '2.00', 7);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('LBS Circulware lid', '2.00', 7);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Re-usable Cutlery set', '4.50', 7);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Wentelteefjes', '5.10', 6);

INSERT INTO products (Name, Price, CategoryId)
VALUES ('Pasta Pesto', '5.85', 6);

INSERT INTO tables (Name)
VALUES ('Table 1');

INSERT INTO tables (Name)
VALUES ('Table 2');

INSERT INTO tables (Name)
VALUES ('Table 3');

INSERT INTO tables (Name)
VALUES ('Table 4');

INSERT INTO tables (Name)
VALUES ('Table 5');

INSERT INTO tables (Name)
VALUES ('Table 6');

INSERT INTO tables (Name)
VALUES ('Table 7');

INSERT INTO tables (Name)
VALUES ('Table 8');

INSERT INTO tables (Name)
VALUES ('Table 9');

INSERT INTO tables (Name)
VALUES ('Table 10');

INSERT INTO tables (Name)
VALUES ('Table 11');

INSERT INTO tables (Name)
VALUES ('Table 12');

INSERT INTO tables (Name)
VALUES ('Table 13');

INSERT INTO tables (Name)
VALUES ('Table 14');

INSERT INTO tables (Name)
VALUES ('Table 15');