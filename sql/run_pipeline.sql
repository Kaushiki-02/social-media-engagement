-- Master SQL script to run the entire social media engagement analysis pipeline
-- Execute scripts in the correct order

-- 1. Create tables
SOURCE create_tables.sql;

-- 2. Insert sample data (for testing)
SOURCE sample_data.sql;

-- 3. Clean and transform data
SOURCE cleaning_transformations.sql;

-- 4. Generate aggregations
SOURCE aggregations.sql;

-- 5. Verify results
SELECT 'Staging Table Count' as metric, COUNT(*) as value FROM stage_posts_raw
UNION ALL
SELECT 'Cleaned Posts Count' as metric, COUNT(*) as value FROM posts_cleaned
UNION ALL
SELECT 'Daily Aggregations' as metric, COUNT(*) as value FROM agg_engagement_by_day
UNION ALL
SELECT 'Hourly Aggregations' as metric, COUNT(*) as value FROM agg_engagement_by_hour
UNION ALL
SELECT 'Post Type Comparisons' as metric, COUNT(*) as value FROM agg_post_type_comparison
UNION ALL
SELECT 'Platform Comparisons' as metric, COUNT(*) as value FROM agg_platform_comparison
UNION ALL
SELECT 'Top Posts' as metric, COUNT(*) as value FROM top_posts;