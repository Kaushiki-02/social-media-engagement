-- Create tables for Social Media Engagement Analysis System

-- Step 1: Create Staging Table
CREATE TABLE stage_posts_raw (
    post_id VARCHAR(255),
    timestamp VARCHAR(255),
    platform VARCHAR(50),
    post_type VARCHAR(50),
    caption TEXT,
    likes VARCHAR(50),
    comments VARCHAR(50),
    shares VARCHAR(50),
    reach VARCHAR(50)
);

-- Step 2: Create Cleaned Table (will be populated in cleaning script)
CREATE TABLE posts_cleaned (
    post_id VARCHAR(255) PRIMARY KEY,
    ts TIMESTAMP,
    platform VARCHAR(50),
    post_type VARCHAR(50),
    caption TEXT,
    likes INTEGER,
    comments INTEGER,
    shares INTEGER,
    reach INTEGER
);

-- Step 3: Create Aggregation Tables for Dashboard Performance
CREATE TABLE agg_engagement_by_hour (
    hour INTEGER,
    avg_engagement_rate DECIMAL(10,4),
    post_count INTEGER
);

CREATE TABLE agg_engagement_by_weekday (
    weekday INTEGER,
    weekday_name VARCHAR(10),
    avg_engagement_rate DECIMAL(10,4),
    post_count INTEGER
);

CREATE TABLE agg_engagement_by_post_type (
    post_type VARCHAR(50),
    avg_engagement_rate DECIMAL(10,4),
    post_count INTEGER
);

CREATE TABLE agg_platform_performance (
    platform VARCHAR(50),
    avg_engagement_rate DECIMAL(10,4),
    total_posts INTEGER,
    total_interactions INTEGER
);

CREATE TABLE top_performing_posts (
    post_id VARCHAR(255),
    platform VARCHAR(50),
    post_type VARCHAR(50),
    engagement_rate DECIMAL(10,4),
    interactions INTEGER,
    caption TEXT
);