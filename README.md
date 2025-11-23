# Social Media Engagement Analysis System

This project analyzes social media engagement data to derive insights and recommendations for optimizing content performance.

## Project Overview

An end-to-end analytics system that identifies what drives engagement on social media platforms and provides actionable recommendations to improve content performance. The system processes raw social media posts, cleans and standardizes the data, analyzes engagement patterns, and visualizes insights for decision-making.

## Folder Structure

- `data/`: Contains raw and cleaned data files
  - `raw_posts.csv`: Raw social media posts data
  - `cleaned_posts.csv`: Cleaned and standardized posts data
- `notebooks/`: Jupyter notebooks for data cleaning, analysis, and visualization
  - `01_data_cleaning.ipynb`: Data validation, cleaning, and standardization
  - `02_eda_analysis.ipynb`: Exploratory Data Analysis
  - `03_visualizations.ipynb`: Visualization creation
- `sql/`: SQL scripts for data processing
  - `create_tables.sql`: Database schema creation
  - `sample_data.sql`: Sample data for testing
  - `cleaning_transformations.sql`: Data cleaning and transformation logic
  - `aggregations.sql`: Data aggregation queries for dashboard
  - `run_pipeline.sql`: Master script to execute entire pipeline
- `dashboards/`: Tableau dashboard files
  - `tableau_dashboard.twb`: Interactive dashboard
- `reports/`: Final reports and recommendations
  - `insights_summary.md`: Key findings and insights
  - `recommendations.md`: Actionable recommendations
  - `insights_summary.pdf`: Key findings and insights (PDF version)
  - `recommendations.pdf`: Actionable recommendations (PDF version)

## Setup Instructions

### Python Environment Setup
1. Install required packages:
   ```
   pip install -r requirements.txt
   ```

### SQL Pipeline Execution
The SQL pipeline implements a professional-level data processing workflow with the following steps:

#### Step 1: Create Staging Table
Creates the [stage_posts_raw](file:///c%3A/Users/HP%201/Desktop/social-media-engagement/sql/create_tables.sql#L5-L15) table to hold raw data

#### Step 2: Data Profiling Query
Profiles the data to understand its quality and characteristics:
- Total row count
- Unique post count
- Missing timestamps
- Invalid likes values

#### Step 3: Clean + Normalize
Transforms raw data into clean, standardized format:
- Converts timestamps to proper format
- Standardizes text fields to lowercase
- Trims caption text
- Converts string values to integers

#### Step 4: Feature Engineering
Calculates derived metrics:
- Total interactions (likes + comments + shares)
- Engagement rate (interactions / reach)

#### Step 5: Time Dimensions
Extracts time-based features:
- Hour of day
- Day of week
- Date

#### Step 6: Aggregations for EDA
Generates aggregated datasets for analysis:
- Average engagement by day
- Average engagement by hour
- Top 10 posts by engagement
- Post type comparisons
- Platform comparisons

The SQL pipeline can be executed in two ways:

##### Option 1: Execute scripts individually
1. Run `sql/create_tables.sql` to create database schema
2. Run `sql/sample_data.sql` to insert sample data (optional)
3. Run `sql/cleaning_transformations.sql` to clean and transform data
4. Run `sql/aggregations.sql` to generate aggregated data for visualization

##### Option 2: Execute master pipeline script
Run `sql/run_pipeline.sql` to execute all steps in the correct order

## Python EDA Notebooks

### Notebook 01: Cleaning
- Load raw CSV
- Check missing values
- Standardize timestamps
- Export cleaned data

### Notebook 02: EDA
- Distribution of engagement
- Correlation heatmaps
- Time-of-day analysis
- Caption-length vs engagement
- Word cloud for captions
- Post-type comparison

### Notebook 03: Insights & Visualizations
- Bar charts
- Line plots
- Heatmaps
- Scatter plots

## Tableau Dashboard

The dashboard suite includes three main dashboards:

### Dashboard 1: Engagement Overview
- Total interactions over time
- Daily/weekly trend
- Platform comparison
- Post type distribution

### Dashboard 2: Timing Insights
- Best time to post
- Best day
- Heatmap: hour vs weekday

### Dashboard 3: Content Insights
- Caption length vs engagement
- Word cloud
- Top-performing posts

To use the dashboard:
1. Open `dashboards/tableau_dashboard.twb` in Tableau Desktop
2. Connect to the data sources in the `data/` folder
3. The dashboard includes filters for platform, post type, and date range

## Insights & Recommendations

### Key Insights
1. Video posts generate 2× more engagement than images
2. Evening uploads (6–9 PM) have the highest interaction rate
3. Short captions (< 40 characters) outperform long captions by ~30%
4. Reels drive 3× shares compared to static posts
5. Weekdays outperform weekends for business accounts

### Actionable Recommendations
1. Shift posting schedule to evenings and weekdays
2. Focus on video-first strategy
3. Reduce caption length
4. Increase posting during peak hours
5. Prioritize reel content for higher shares

## Data Schema

### Input Data Fields
- `post_id` (string): Unique identifier
- `timestamp` (string): Original post time
- `platform` (string): Instagram / Facebook / etc
- `post_type` (string): image/video/reel/story
- `caption` (text): Post caption
- `likes` (int): Likes count
- `comments` (int): Comments count
- `shares` (int): Shares count
- `reach` (int): Total reach

### Derived Fields
- `interactions`: likes + comments + shares
- `engagement_rate`: interactions / reach
- `hour`: posting hour
- `weekday`: day of week
- `caption_length`: number of characters
- `day`: posting date

## Acceptance Criteria

- [ ] Data is cleaned & standardized (No missing timestamps, no non-numeric likes/comments, no duplicates)
- [ ] SQL transforms run without errors (All fields created correctly)
- [ ] Python notebooks show EDA (At least 8–10 meaningful visualizations)
- [ ] Tableau dashboard is interactive (With filters for platform, post_type, and date range)
- [ ] Final report includes actionable insights (At least 4 insights + recommendations backed by data)
- [ ] Project is reproducible (README explains setup, steps, and execution order)