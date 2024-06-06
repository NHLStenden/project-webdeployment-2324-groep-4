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
    CategoryId int AUTO_INCREMENT NOT NULL,
    Name nvarchar(255),
    PRIMARY KEY (CategoryId)
);

CREATE TABLE products
(
    ProductId    int AUTO_INCREMENT NOT NULL,
    Name  nvarchar(255)      NOT NULL,
    Price decimal(15,2)      NOT NULL,
    CategoryId int,

    PRIMARY KEY (ProductId),
    FOREIGN KEY (CategoryId) REFERENCES categories(CategoryId)
);

CREATE TABLE tables
(
    TableId  int AUTO_INCREMENT          NOT NULL,
    Name   nvarchar(255)            NOT NULL,
    PRIMARY KEY (TableId)
);

CREATE TABLE orders
(
    OrderId        int AUTO_INCREMENT NOT NULL,
    Timestamp datetime           NOT NULL default CURRENT_TIMESTAMP,
    TableId   int,
    WaiterName nvarchar(255), 

    PRIMARY KEY (OrderId),
    FOREIGN KEY (TableId) REFERENCES tables (TableId),
    FOREIGN KEY (WaiterName) REFERENCES waiter (Name)
);

CREATE TABLE rounds
(
    RoundId      int AUTO_INCREMENT NOT NULL,
    Status  nvarchar(255),
    OrderId int,

    PRIMARY KEY (RoundId),
    FOREIGN KEY (OrderId) REFERENCES orders (OrderId)
);

CREATE TABLE product_round
(
    ProductId  int NOT NULL,
    RoundId    int NOT NULL,

    Amount     int NOT NULL,
    AmountPaid int,

    FOREIGN KEY (ProductId) REFERENCES products (ProductId),
    FOREIGN KEY (RoundId) REFERENCES rounds (RoundId)
);

CREATE TABLE add_on_categories
(
    AddonCategoryId   int AUTO_INCREMENT NOT NULL,
    Name nvarchar(255),

    PRIMARY KEY (AddonCategoryId)
);

CREATE TABLE addons
(
    AddonId              int AUTO_INCREMENT NOT NULL,
    Name            nvarchar(255)      NOT NULL,
    AddonCategoryId int                NOT NULL,

    PRIMARY KEY (AddonId),
    FOREIGN KEY (AddonCategoryId) REFERENCES add_on_categories (AddonCategoryId)
);

CREATE TABLE product_addons
(
    ProductId int,
    AddOnId   int,
    Price     integer,

    FOREIGN KEY (ProductId) REFERENCES products (ProductId),
    FOREIGN KEY (AddOnId) REFERENCES addons (AddonId)
);

CREATE TABLE Users
(
   UserName NVARCHAR(255) NOT NULL,
   PassWord NVARCHAR(255) NOT NULL  
);

INSERT INTO Users (Username, PassWord)
VALUES ('Personeel', 'Personeel1');

INSERT INTO Users (Username, PassWord)
VALUES ('Manager', 'Manager1');

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

INSERT INTO add_on_categories (Name)
VALUES ('Milk');

INSERT INTO add_on_categories (Name)
VALUES ('Syrup');

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Soy Milk', 1);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Oat Milk', 1);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Coconut Milk', 1);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Regular Milk', 1);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Caramel', 2);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Cinnamon', 2);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Vanilla', 2);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('No Syrup', 2);

INSERT INTO add_on_categories (Name)
VALUES ('Lunch');

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('With Kinchi', 3);

INSERT INTO addons (Name, AddonCategoryId)
VALUES ('Without Kinchi', 3);

