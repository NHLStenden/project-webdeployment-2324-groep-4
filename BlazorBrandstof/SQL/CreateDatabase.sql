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

INSERT INTO products (Name, Price, Category)
VALUES ('Latte Macchiato', '1.50', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Latte Macchiato large', '2.16', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Flat White', '1.88', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Tea', '1.17', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Fresh Tea', '1.30', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Hot Chocolate Dark', '2.10', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Chai Latte', '2.60', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Dirty Chai Latte', '3.25', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Coffee Special', '3.00', 'Warm drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Smoothie', '2.50', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Homemade Ice Tea', '2.75', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Water Still', '2.10', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Water Sparkling', '2.10', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Apple Juice', '2.30', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Lemon Lime Soda', '2.75', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Ice Latte', '2.70', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Tonic', '3.20', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Fritz Cola', '2.60', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Fritz Rhubarb', '2.60', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Fritz Limo Sinas', '2.60', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Fritz Lemon', '2.60', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Fritz Apple', '2.60', 'Cold drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Virgin Gin Tonic', '5.50', 'Alcohol free drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Van de streek IPA', '4.40', 'Alcohol free drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Nuchtere heit', '3.90', 'Alcohol free drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Heineken draft 0,0%', '3.20', 'Alcohol free drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Mocktail of the day', '5.50', 'Alcohol free drinks');

INSERT INTO products (Name, Price, Category)
VALUES ('Pie of the day', '2.25', 'Pastry\'s and dessert');

INSERT INTO products (Name, Price, Category)
VALUES ('Fluffy pancakes', '6.00', 'Pastry\'s and dessert');

INSERT INTO products (Name, Price, Category)
VALUES ('Bitterballen P.P', '1.10', 'Snacks');

INSERT INTO products (Name, Price, Category)
VALUES ('Roasted potato wedges', '4.00', 'Snacks');

INSERT INTO products (Name, Price, Category)
VALUES ('Vegetarian springroll', '4.50', 'Snacks');

INSERT INTO products (Name, Price, Category)
VALUES ('Soup of the Day', '4.50', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('12-Uurtje', '6.60', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('Croquette on sourdough bread', '6.50', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('Wrap Crispy Chicken', '7.30', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('Pot of the Season', '7.20', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('Grandma\'s meatball', '6.20', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('LBS Circulware cup', '2.00', 'Re-usables / disposables');

INSERT INTO products (Name, Price, Category)
VALUES ('LBS Circulware lid', '2.00', 'Re-usables / disposables');

INSERT INTO products (Name, Price, Category)
VALUES ('Re-usable Cutlery set', '4.50', 'Re-usables / disposables');

INSERT INTO products (Name, Price, Category)
VALUES ('Wentelteefjes', '5.10', 'Lunch');

INSERT INTO products (Name, Price, Category)
VALUES ('Pasta Pesto', '5.85', 'Lunch');

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