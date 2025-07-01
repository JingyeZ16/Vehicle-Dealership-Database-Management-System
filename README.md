# Vehicle Dealership Database Management System
A comprehensive SQL-based relational database system designed for car dealership management, supporting vehicle sales, maintenance, inventory tracking, and supplier operations with integrated business logic and Tableau visualizations.

# 📊 Project Overview

Purpose:

To support car sales, maintenance services, inventory management, and parts procurement through a centralized and structured database. The system improves operational efficiency, facilitates data-driven decisions, and enables insightful analytics.

Business Problems Addressed:

Real-time vehicle inventory tracking

Efficient scheduling and management of vehicle maintenance

Sales performance reporting and trend identification

Customer Relationship Management for targeted marketing

Inventory optimization and cost-effective supplier management

# 🛠️ Features

Designed and implemented a Relational Database using advanced SQL, including:

Complex joins, nested queries, views, and stored procedures

Computed columns and constraints for data integrity

Normalized to 3rd Normal Form (3NF) ensuring consistency

Developed comprehensive ER diagrams to model data relationships and business logic

Created Tableau Dashboards to visualize:

10K+ rows of sales, customer, and operational data

Insights into regional performance, customer demographics, and channel effectiveness

Conducted Funnel Analysis to identify key drop-off points from inquiry to purchase, informing sales and marketing strategies

# 📂 Project Structure

├── DAMG_Database_Design_ERD.pdf   # Full database design document & ER diagrams

├── Dealer_Database.sql      # SQL scripts for schema creation, data population

├── Tableau_Dashboards/            # Folder for Tableau visualizations (optional upload)

├── README.md                      # Project documentation


# 🗃️ Entity Relationship Model

Entities Included:

Customer – Stores buyer and prospect information

Employee – Includes sales, service, and managerial staff

Vehicle_Information – Tracks vehicle details, ownership, and configurations

Order – Records vehicle orders and associated details

Sales – Captures transactions, payment methods, billing, and sales channels

Shipment – Manages shipping status, addresses, and logistics

Service – Tracks service appointments, teams, and part usage

Supplier – Manages supplier details for both vehicles and parts

Previous_Owners – Tracks ownership history for used vehicles

Configuration & Inventory – Supports vehicle specification and stock levels

Quote – Facilitates pricing inquiries and sales quoting

Team – Defines service teams to manage many-to-many staff relationships

Address – Manages shipping locations for logistics

Example ER Diagram
Refer to DAMG_Database_Design_ERD.pdf for full visual representation.

# 🧩 Views & Functions Implemented

Most Valuable Salesperson – Ranks employees by sales orders handled

Most Valuable Team – Tracks team performance by service tickets completed

Sales Channel Distribution – Calculates sales percentages across channels (In-store, Online, Phone, Third-party)

Inventory Level Status – Computed stock status: High, Normal, Low

Service with Part Info – View to identify parts used per service

Quote vs Sale Difference – Highlights pricing discrepancies

Data Constraints:

Validations on:

Phone number formats

Date of birth (cannot exceed present date)

Order, shipment, and delivery date sequencing

# 📊 Tableau Visualizations

Delivery Status Bar Chart – Tracks shipment completion

Sales Channels Pie Chart – Breaks down purchasing channel preferences

Geographic Order Distribution – Heatmap of regional sales performance

Age Distribution Bar Chart – Visualizes customer demographics

Monthly Vehicle Sales Trends – Identifies peak and low sales periods


