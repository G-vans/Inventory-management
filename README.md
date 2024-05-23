# Inventory Management System

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Setup Instructions](#setup-instructions)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Database Setup](#database-setup)
  - [Running the Application](#running-the-application)
  - [Running Tests](#running-tests)
- [Design Decisions](#design-decisions)
- [Assumptions](#assumptions)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Inventory Management System is a simple application developed for a retail store to manage their inventory. It allows administrators to add, update, and delete products, as well as track stock levels in real-time.

## Features

- CRUD operations on products
- Display product information including name, description, price, quantity, and image
- Search for products by name
- Display notifications for low stock products
- Real-time updates using Hotwire
- Image upload functionality using Active Storage

## Setup Instructions

### Prerequisites

- Ruby 3.0.0 or later
- Rails 7.0 or later
- PostgreSQL

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/G-vans/inventory-management.git
    cd inventory-management
    ```

2. Install the required gems:

    ```bash
    bundle install
    ```

### Database Setup

1. Create and migrate the database:
    Sign in into postgresql and create username 'postgres' with password ''
    then:

    ```bash
    rails db:create
    rails db:migrate
    ```

### Running the Application

1. Start the Rails server:

    ```bash
    rails server
    ```

2. Open your browser and navigate to `http://localhost:3000` to see the application running.

### Running Tests

To run the test suite, use the following command:

```bash
rails test
```

## Design Decisions

1. **Architecture**: The application follows the MVC (Model-View-Controller) pattern provided by Rails.

   - **Model**: 
     - `Product` model with attributes: `name`, `description`, `price`, `quantity`, and `image`.
     - Validations for data integrity.
     - Active Storage for image uploads.

   - **View**:
     - ERB templates styled with Bootstrap.
     - Key views: `index.html.erb` (product list, low-stock and search), `show.html.erb` (product details), `new.html.erb` and `edit.html.erb` (product forms).
     - Hotwire for real-time updates and notifications.

   - **Controller**:
     - `ProductsController` handles product-related actions.
     - Actions: `index`, `show`, `new`, `create`, `edit`, `update`, `destroy`, `increase_stock`, `decrease_stock`.
     - Strong parameters ensure safe attribute handling.

   - **Routes**:
     - Resourceful routing for standard actions.
     - Custom routes for stock adjustments.

   - **Real-Time Functionality**:
     - Hotwire with Turbo Streams and Turbo Frames for dynamic updates.
     - Real-time low stock notifications.

   - **Database**:
     - PostgreSQL with Active Record for ORM.
     - Migrations manage schema changes.

## Assumptions

1. **Admin-Only Access**: The application assumes that only administrators will use it. Therefore, no user authentication or authorization is implemented.
2. **Stock Level Threshold**: A stock level of 10 or below is considered low, and a notification is displayed to the user.
3. **Simple Search**: The search functionality is based on the product name only. More advanced search features could be added as needed.

## Usage

1. **Adding a New Product**:
   - At the homepage, navigate to the "New product" button and click on it.
   - Fill in the product details including name, description, price, quantity, and upload an image.
   - Click "Save" to save the product on to the database.

2. **Editing a Product**:
   - Click on Edit button of the product you wish to edit.
   - Update the product details and click "Update Product" to save changes.

3. **Deleting a Product**:
   - Navigate to the product you wish to delete.
   - Click on the "Delete" button and confirm the action.

4. **Searching for a Product**:
   - Use the search form at the top of the products page to search for products by name.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
