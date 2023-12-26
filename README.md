# Zomato_Case_Study

## About the Dataset used for case study

## menu:

menu_id: Unique identifier for a menu item.

r_id: Identifier for the restaurant associated with the menu item.

f_id: Identifier for the food item.

price: The price of the menu item.

## food:

f_id: Unique identifier for a food item.

f_name: The name of the food item.

f_type: The type or category of the food item.

## users:

user_id: Unique identifier for a user.

name: The name of the user.

email: The email address of the user.

password: The password associated with the user's account.

## restaurants:

r_id: Unique identifier for a restaurant.

r_name: The name of the restaurant.

cuisine: The type of cuisine offered by the restaurant.

## orders:

order_id: Unique identifier for an order.

user_id: Identifier for the user placing the order.

r_id: Identifier for the restaurant fulfilling the order.

amount: The total amount of the order.

date: The date when the order was placed.

## order_details:

id_: Unique identifier for an order detail.

order_id: Identifier for the order to which the detail belongs.

f_id: Identifier for the food item included in the order.

This schema appears to model a system where users can place orders at restaurants. The "menu" table defines the available items and their prices, the "food" table provides information about the types of food, the "users" table stores user details, the "restaurants" table stores information about different restaurants, the "orders" table contains information about placed orders, and the "order_details" table links orders to the specific food items they include
