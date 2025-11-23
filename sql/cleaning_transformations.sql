-- Data cleaning and transformation script for Social Media Engagement Analysis

-- Step 2: Data Profiling Query
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT post_id) AS unique_posts,
    SUM(CASE WHEN timestamp IS NULL OR timestamp = '' THEN 1 ELSE 0 END) AS missing_timestamps,
    SUM(CASE WHEN likes NOT REGEXP '^[0-9]+$' THEN 1 ELSE 0 END) AS invalid_likes
FROM stage_posts_raw;

-- Step 3: Clean + Normalize
INSERT INTO posts_cleaned (
    post_id,
    ts,
    platform,
    post_type,
    caption,
    likes,
    comments,
    shares,
    reach
)
SELECT 
    post_id,
    STR_TO_DATE(timestamp, '%Y-%m-%d %H:%i:%s') AS ts,
    LOWER(platform) AS platform,
    LOWER(post_type) AS post_type,
    TRIM(caption) AS caption,
    CASE WHEN likes REGEXP '^[0-9]+$' THEN CAST(likes AS UNSIGNED) ELSE NULL END AS likes,
    CASE WHEN comments REGEXP '^[0-9]+$' THEN CAST(comments AS UNSIGNED) ELSE NULL END AS comments,
    CASE WHEN shares REGEXP '^[0-9]+$' THEN CAST(shares AS UNSIGNED) ELSE NULL END AS shares,
    CASE WHEN reach REGEXP '^[0-9]+$' THEN CAST(reach AS UNSIGNED) ELSE NULL END AS reach
FROM stage_posts_raw
WHERE post_id IS NOT NULL;

-- Step 4: Feature Engineering
-- Add columns for interactions and engagement rate
ALTER TABLE posts_cleaned
ADD COLUMN interactions INT,
ADD COLUMN engagement_rate FLOAT;

-- Update with calculated values
UPDATE posts_cleaned
SET interactions = COALESCE(likes,0) + COALESCE(comments,0) + COALESCE(shares,0),
    engagement_rate = (COALESCE(likes,0) + COALESCE(comments,0) + COALESCE(shares,0)) / NULLIF(reach, 0);

-- Step 5: Time Dimensions
-- Add columns for time dimensions
ALTER TABLE posts_cleaned
ADD COLUMN hour INT,
ADD COLUMN weekday INT,
ADD COLUMN day DATE;

-- Update with extracted time values
UPDATE posts_cleaned
SET hour = HOUR(ts),
    weekday = WEEKDAY(ts),
    day = DATE(ts);