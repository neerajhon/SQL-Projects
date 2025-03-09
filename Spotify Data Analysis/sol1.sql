use spotify;

SELECT * FROM spotify.spotify;


#A. General Song Information

#1.What are the top 5 most streamed songs in 2023?

select track_name,streams
from spotify
where released_year = '2023'
order by streams desc
limit 5;

#2.How many unique artists contributed to the dataset?

SELECT COUNT(DISTINCT artist_name) AS unique_artists_count
FROM   spotify;

#3.What is the distribution of songs across different release years?

SELECT 
    CASE 
        WHEN released_year >= 2020 THEN '2020-2024'  -- Handle the last decade separately
        ELSE CONCAT(FLOOR(released_year / 10) * 10, '-', FLOOR(released_year / 10) * 10 + 11 ) 
    END AS decade_range, 
    COUNT(*) AS songs_count
FROM spotify
WHERE released_year <= 2024  -- Ensure we only include years up to 2024
GROUP BY 1
ORDER BY 1;

#4.Who are the top 10 artists based on popularity, and what are their tracks' average danceability and energy?

select artist_name,
sum(streams) as streams,
avg(`danceability_%`) as avg_danceability,
avg(`energy_%`) as avg_energy
from spotify
group by artist_name
order by sum(streams) desc
limit 10;

	
