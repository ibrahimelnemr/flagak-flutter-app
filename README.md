# Overview

This repository contains a full-stack Flutter application with a backend built using Node.js, TypeScript, and MongoDB. The Flutter app provides an interface for managing products, while the backend handles data storage and retrieval. Users can register as either admins (can create and update products and view individual products) or regular users (can only view all products, cannot create, update or view individual products).

* [Prerequisites](#prerequisites)
* [Backend Setup](#backend-setup)
* [Flutter Setup](#flutter-setup)
* [API Endpoints](#api-endpoints)
* [UI Prototype](#figma-ui-prototype)
* [Elastic Beanstalk Deployment](#elastic-beanstalk-deployment)

# Prerequisites

Before running the application, ensure you have the following software installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/)
- [MongoDB](https://www.mongodb.com/try/download/community)

# Flutter App Structure


The Flutter app is organized into several main files and directories:

- **lib/**
  - **views/**: Dart files for different screens or views.
    - `admin_view.dart`: Implements the Admin view for managing products.
    - `create_product_view.dart`: Allows admins to create new products.
    - `edit_product_view.dart`: Allows admins to edit existing products.
    - `login_view.dart`: Handles user login.
    - `main_view.dart`: Displays the main screen with a list of products.
    - `register_view.dart`: Handles user registration.
    - `view_product_view.dart`: Displays information about a product.
    - `welcome_view.dart`: The welcome screen with registration and login options.
  - **services/**: Dart files for services.
    - `api_service.dart`: Implements communication with the backend API.
  - `main.dart`: The main entry point for the app.

# Backend Setup

* Navigate to the `backend` directory

`cd backend`

* Install dependencies

`npm install`

* Run the server 

`npm start`

# Flutter Setup

* Navigate to frontend directory

`cd frontend`

* Install dependencies

`flutter pub get`

* Run the app

`flutter run`

# API Endpoints

## **Registration**

### POST /users/register

#### Request

```json
{
  "name": "Test User",
  "email": "testuser@example.com",
  "password": "testpassword",
  "is_admin": true
}
```

#### Response

```json
{
    "message": "User registered successfully with email: testuser@example.com.",
    "user": {
        "id": "658d97664c8643eaaebb37d4",
        "name": "Test User",
        "email": "testuser@example.com"
    }
}
```

## **Login**

### POST /users/login

#### Request

```json
{
  "email": "testuser@example.com",
  "password": "testpassword"
}
```

#### Response

```json
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjY1OGQ5NzY2NGM4NjQzZWFhZWJiMzdkNCIsIm5hbWUiOiJUZXN0IFVzZXIiLCJlbWFpbCI6InRlc3R1c2VyQGV4YW1wbGUuY29tIiwicGFzc3dvcmRfaGFzaCI6IiQyYSQxMCR1ekVXMWM5WHN1MEJwdWU2amw4amR1UnFvaHd1SURuWEpkeFZyZTIxLnRsWUFYUjB1YmExUyIsImlzX2FkbWluIjp0cnVlLCJfX3YiOjB9LCJpYXQiOjE3MDM3NzgxOTR9.CVxRS6QKmfbgKKNIPVy9gE8Xpzu5JXB1ERo4W8Hb45I",
    "user": {
        "_id": "658d97664c8643eaaebb37d4",
        "name": "Test User",
        "email": "testuser@example.com",
        "password_hash": "$2a$10$uzEW1c9Xsu0Bpue6jl8jduRqohwuIDnXJdxVre21.tlYAXR0uba1S",
        "is_admin": true,
        "__v": 0
    }
}
```

## **View All Products**

### GET /products

Authorization: Bearer ACCESS_TOKEN

#### Response

```json
[
    {
        "_id": "658b63ece0995c4d4fdda146",
        "name": "test",
        "description": "test",
        "price": 9,
        "user_id": "658b5f71c2105587a8c7fdd0",
        "__v": 0
    },
    {
        "_id": "658c5ac6b1c78dbe306d6e33",
        "name": "testproduct2EDITED",
        "description": "testproduct2",
        "price": 9,
        "user_id": "658b0d0f7ad01c2cb8eb8593",
        "__v": 0
    },
    {
        "_id": "658c5f7eb1c78dbe306d6e40",
        "name": "test2",
        "description": "test2",
        "price": 9,
        "user_id": "658b0d0f7ad01c2cb8eb8593",
        "__v": 0
    },
    {
        "_id": "658c60eab1c78dbe306d6e46",
        "name": "test3",
        "description": "test3",
        "price": 10,
        "user_id": "658b0d0f7ad01c2cb8eb8593",
        "__v": 0
    },
    {
        "_id": "658c6223b1c78dbe306d6e4d",
        "name": "test4",
        "description": "test4",
        "price": 9,
        "user_id": "658b0d0f7ad01c2cb8eb8593",
        "__v": 0
    },
    {
        "_id": "658c6308b1c78dbe306d6e5e",
        "name": "test5",
        "description": "test5",
        "price": 10,
        "user_id": "658b0d0f7ad01c2cb8eb8593",
        "__v": 0
    }
]
```

## **Create Product**

### POST /products/create

Authorization: Bearer ACCESS_TOKEN

#### Request

```json
{
    "name": "Test Product",
    "description": "A test product",
    "price": 9.99,
    "user_id": "658d97664c8643eaaebb37d4"
}
```

#### Response

```json
{
    "message": "Product created successfully with name: Test Product, description: A test product and price: 9.99.",
    "product": {
        "name": "Test Product",
        "description": "A test product",
        "price": 9.99,
        "user_id": "658d97664c8643eaaebb37d4",
        "_id": "658d9abf4c8643eaaebb37da",
        "__v": 0
    }
}
```

## **Edit Product (requires admin token)**
### PUT /products/edit

#### Request

```json
{
    "_id": "65872ea3cd6f18943c843412",
    "name": "Test Product Edited",
    "description": "A test product",
    "price": 9.99,
    "__v": 0
}
```

#### Response

```json
{
    "message": "Product edited successfully with name: Test Product Edited, description: A test product and price: 9.99."
}
```

# Figma UI Prototype

https://www.figma.com/file/Nje4m7yaF1D4q9yAmKaTGg/Flagak-App-Task



# Elastic Beanstalk Deployment

http://flagak-task-2-env.eba-v47pizxh.eu-north-1.elasticbeanstalk.com/

*Note that this environment is not currently active.*

# Set up Local Test Backend


In order to use a local test backend, ensure you have MongoDB installed and start the MongoDB service

For instance, using homebrew:

`brew services start mongodb-community`

After that navigate to the backend directory

`cd backend`

And start the server

`npm run start`

Ensure that the backend is configured to connect to the local test API (localhost) and not the remote API.

If the connection is successful, you should see "Connected to MongoDB" printed to the console.