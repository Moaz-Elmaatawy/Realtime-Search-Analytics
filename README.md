# Real-Time Search and Analytics

## Introduction
This document provides comprehensive documentation for the Real-Time Search and Analytics web application. This application allows users to search articles in real time and view analytics based on search queries.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Live Demo
Try on [Realtime-Search-App](https://realtime-search-enbi.onrender.com/)

## Prerequisites
Ruby on Rails
PostgreSQL

## Installation
### Clone the repository:

```git clone https://github.com/Moaz-Elmaatawy/Realtime-Search-Analytics.git```
### Install dependencies:

```bundle install```

### Setup the database

```
rails db:create
rails db:migrate
rails db:seed
```

## Running the Application Locally
Start the Rails server:
```rails server```
Access the application at: ```http://localhost:3000```


# *Key Features*
- ## Search Functionality
  - ### User Experience
    As users type in the search box, the application provides real-time search results.
    The search is responsive and designed to handle partial queries, updating results as the query is typed.
  - ### Technical Implementation
    The search functionality is implemented in the SearchesController.
    When a user inputs a search term, a POST request is made to the create action.
    The search query is matched against the title field of the Article model using a case-insensitive (ILIKE) query.
  - ### Saving Search Queries
    - #### Logic for Saving Queries
    Search queries are saved based on a combination of factors:
    - **Query Uniqueness**: Utilizing the FuzzyStringMatch gem, the application checks the similarity of the current query against the user's last query.
    - **Time Facto**r: A new query is considered if it's been more than 2 minutes since the last query was made.
    - **Query Length Consideration**: Different thresholds are set for fuzzy matching based on the query length.
    - #### Conditions for Query Logging
    - **First-Time Queries**: If no previous query exists for a user, the new query is saved.
    - **Different Queries**: If the new query is significantly different from the last query (based on the fuzzy matching threshold), it is saved.
    - **Time Gap**: If the new query is input after a sufficient time gap (e.g., 2 minutes from the last query), it is saved.
    - **Overwriting Similar Queries**: If a new query is similar but surpasses the threshold, it replaces the last query.


- ## Analytics Features
  ### Overview
  The application provides analytics to understand and interpret user search behavior. This feature is key for gaining insights into the most popular search terms, trends, and individual user preferences.
  
  ### Key Analytics Metrics
  
  - **Top Searches**: Aggregates the most common queries across all users. This metric provides insights into the most popular search terms that are being used in the application.
  
  - **Recent Searches**: Displays the latest search queries made by users. This helps in understanding the current interests or immediate information needs of the user base.
  
  - **User-Specific Analytics**: Shows search patterns and frequent queries for individual users based on their identifier (e.g., IP address). This personalized data is crucial for understanding user behavior on an individual level, allowing for more targeted content and features.
  
  - **Search Trends Over Time**: Analyzes how search queries evolve and change over time, providing insights into shifting user interests and behaviors. This trend analysis can be instrumental in predicting future content needs or in making strategic decisions for the platform.

## Testing

### Overview

This section outlines the testing strategies employed in the project, including unit and performance testing.

### Unit Tests

- **RSpec**: Utilized for unit and integration testing.

Run these tests with the following command:

```bash
bundle exec rspec
```

### Performance Testing with JMeter
Performance tests were conducted using Apache JMeter to assess the application's behavior under various user loads.
These tests are carried on the localhost environment. 

#### Test Results
- **Throughput**: Achieved on average 80 to 100 requests per second.

## Improvements for Scalability
### Introduction
While the current implementation of the Real-Time Search Analytics application serves its purpose effectively, there are several enhancements that can be made to improve scalability, especially under high-traffic conditions. Key among these improvements are the integration of Elasticsearch and the use of caching mechanisms.

### Using Elasticsearch for Enhanced Search Capabilities
#### Why Elasticsearch?
Elasticsearch is a powerful, open-source search engine that supports full-text search, scalable up to petabytes of structured and unstructured data. Its speed and scalability make it ideal for enhancing the search functionality in our application.

### Implementing Caching for Performance
#### Why Caching?
Caching can significantly reduce the load on the database and improve response times by storing frequently accessed data in a faster storage system.

### Implementing a Lambda architecture for the analytics system

### small improvements
  - pagination.
  - using batch loading where appropriate.
  - Implement asynchronous operations in the frontend.


