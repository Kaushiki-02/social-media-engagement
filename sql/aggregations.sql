-- Aggregation queries for Social Media Engagement Analysis

-- Create tables for aggregations
CREATE TABLE IF NOT EXISTS agg_engagement_by_day (
    day DATE,
    avg_engagement_rate FLOAT,
    post_count INT
);

CREATE TABLE IF NOT EXISTS agg_engagement_by_hour (
    hour INT,
    avg_engagement_rate FLOAT,
    post_count INT
);

CREATE TABLE IF NOT EXISTS top_posts (
    post_id VARCHAR(255),
    engagement_rate FLOAT,
    interactions INT
);

CREATE TABLE IF NOT EXISTS agg_post_type_comparison (
    post_type VARCHAR(50),
    avg_engagement_rate FLOAT,
    post_count INT
);

CREATE TABLE IF NOT EXISTS agg_platform_comparison (
    platform VARCHAR(50),
    avg_engagement_rate FLOAT,
    post_count INT
);

-- Clear existing data
DELETE FROM agg_engagement_by_day;
DELETE FROM agg_engagement_by_hour;
DELETE FROM top_posts;
DELETE FROM agg_post_type_comparison;
DELETE FROM agg_platform_comparison;

-- Aggregation 1: Avg engagement by day
INSERT INTO agg_engagement_by_day (day, avg_engagement_rate, post_count)
SELECT 
    day,
    AVG(engagement_rate) AS avg_engagement_rate,
    COUNT(*) AS post_count
FROM posts_cleaned
WHERE engagement_rate IS NOT NULL
GROUP BY day
ORDER BY day;

-- Aggregation 2: Avg engagement by hour
INSERT INTO agg_engagement_by_hour (hour, avg_engagement_rate, post_count)
SELECT 
    hour,
    AVG(engagement_rate) AS avg_engagement_rate,
    COUNT(*) AS post_count
FROM posts_cleaned
WHERE engagement_rate IS NOT NULL
GROUP BY hour
ORDER BY hour;

-- Aggregation 3: Top 10 posts
INSERT INTO top_posts (post_id, engagement_rate, interactions)
SELECT 
    post_id,
    engagement_rate,
    interactions
FROM posts_cleaned
WHERE engagement_rate IS NOT NULL
ORDER BY engagement_rate DESC
LIMIT 10;

-- Aggregation 4: Post type comparisons
INSERT INTO agg_post_type_comparison (post_type, avg_engagement_rate, post_count)
SELECT 
    post_type,
    AVG(engagement_rate) AS avg_engagement_rate,
    COUNT(*) AS post_count
FROM posts_cleaned
WHERE engagement_rate IS NOT NULL AND post_type IS NOT NULL
GROUP BY post_type
ORDER BY avg_engagement_rate DESC;

-- Aggregation 5: Platform comparisons
INSERT INTO agg_platform_comparison (platform, avg_engagement_rate, post_count)
SELECT 
    platform,
    AVG(engagement_rate) AS avg_engagement_rate,
    COUNT(*) AS post_count
FROM posts_cleaned
WHERE engagement_rate IS NOT NULL AND platform IS NOT NULL
GROUP BY platform
ORDER BY avg_engagement_rate DESC;