# Overview

This repository contains a full-stack Flutter application with a backend built using Node.js, TypeScript, and MongoDB. The Flutter app provides an interface for managing products, while the backend handles data storage and retrieval. Users can register as either admins (can create and update products and view individual products) or regular users (can only view all products, cannot create, update or view individual products).

* [Prerequisites](#prerequisites)
* [Backend Setup](#backend-setup)
* [Flutter Setup](#flutter-setup)
* [API Endpoints](#api-endpoints)
* [UI Prototype](#figma-ui-prototype)

# Prerequisites

Before running the application, ensure you have the following software installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/)
- [MongoDB](https://www.mongodb.com/try/download/community)


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
  "is_admin": 0
}
```

#### Response

```json
{
  "message": "User registered successfully with email: testuser@example.com",
  "user": {
    "id": 3,
    "name": "Test User",
    "email": "testuser@example.com",
    "is_admin": 0
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
  "message": "Logged In Successfully",
  "token": "ACCESS_TOKEN"
}
```

## **Logout**

### POST /users/logout
Authorization: Bearer ACCESS_TOKEN

#### Request

```json
{
  "token": "ACCESS_TOKEN"
}
```

#### Response

```json
{
  "message": "Logged Out Successfully."
}
```

## **View All Products**

### GET /products

#### Response

```json
[
  {
    "name": "Test Product",
    "price": 9.99
  },
  {
    "name": "Test Product 2",
    "price": 13.99
  },
  {
    "name": "Test Product 3",
    "price": 19.99
  }
]
```

## **View One Product**

### GET /products/{id}
Authorization: Bearer ACCESS_TOKEN

#### Request

```json
{
  "id": 1
}
```

#### Response

```json
{
  "id": 1,
  "name": "Test Product",
  "price": 9.99
}
```

## **Create Product**

### POST /products/create

#### Request

```json
{
  "name": "Test Product",
  "price": 9.99
}
```

#### Response

```json
{
  "id": 1,
  "name": "Test Product",
  "price": 9.99
}
```

## **Edit Product (requires admin token)**
### PUT /products/edit

#### Request

```json
{
  "id": "test_id",
  "name": "Test Product",
  "price": 15.99,
  "description": "Test description"
}
```

#### Response

```json
{
  "id": "test_id",
  "name": "Test Product",
  "price": 15.99,
  "description": "Test description"
}
```

# Figma UI Prototype

https://www.figma.com/file/Nje4m7yaF1D4q9yAmKaTGg/Flagak-App-Task

