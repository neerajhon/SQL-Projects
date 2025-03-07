# Spotify Data Analysis Queries

---

## 📌 Project Overview
This project explores **Spotify song metrics** using SQL queries to uncover trends, correlations, and insights from the dataset. The dataset includes information on song popularity, artist impact, musical features, and chart presence across platforms like **Spotify, Apple Music, Deezer, and Shazam**.

## 🎯 Objectives
- **Identify trends** in song popularity, energy, danceability, and other audio features.
- **Compare artist impact** based on the number of contributions, playlists, and streaming counts.
- **Analyze chart presence** across multiple platforms to understand market reach.
- **Explore correlations** between various musical and popularity metrics.

## 📊 Insights & Applications
- Helps **music streaming platforms** understand which song features drive popularity.
- **Artists and producers** can use the findings to optimize their music for **higher engagement**.
- Provides a **data-driven approach** to understanding **listener preferences** and market trends.

## Dataset Description 

The [dataset](https://www.kaggle.com/datasets/nelgiriyewithana/top-spotify-songs-2023) provides a comprehensive set of features, including song attributes, popularity metrics, and presence on various music platforms like Spotify, Apple Music, Deezer, and Shazam. 

The dataset empowers users to delve into music analysis, platform comparison, artist impact, temporal trends, and cross-platform presence.

### Key Features 


1. `track_name`: Name of the song

2. `artist(s)_name`: Name of the artist(s) of the song

3. `artist_count`: Number of artists contributing to the song

4. `released_year`: Year when the song was released

5. `released_month`: Month when the song was released

6. `released_day`: Day of the month when the song was released

7. `in_spotify_playlists`: Number of Spotify playlists the song is included in

8. `in_spotify_charts`: Presence and rank of the song on Spotify charts

9. `streams`: Total number of streams on Spotify

10. `in_apple_playlists`: Number of Apple Music playlists the song is included in

11. `in_apple_charts`: Presence and rank of the song on Apple Music charts

12. `in_deezer_playlists`: Number of Deezer playlists the song is included in

13. `in_deezer_charts`: Presence and rank of the song on Deezer charts

14. `in_shazam_charts`: Presence and rank of the song on Shazam charts

15. `bpm`: Beats per minute, a measure of song tempo

16. `key`: Key of the song

17. `mode`: Mode of the song (major or minor)

18. `danceability_%`: Percentage indicating how suitable the song is for dancing

19. `valence_%`: Positivity of the song's musical content

20. `energy_%`: Perceived energy level of the song

21. `acousticness_%`: Amount of acoustic sound in the song

22. `instrumentalness_%`: Amount of instrumental content in the song

23. `liveness_%`: Presence of live performance elements

24. `speechiness_%`: Amount of spoken words in the song

## Database Selection
```sql
USE spotify;
SELECT * FROM spotify.spotify;
```

---

## A. General Song Information

#### 1️⃣ Top 5 Most Streamed Songs in 2023
```sql
SELECT track_name, streams
FROM spotify
WHERE released_year = '2023'
ORDER BY streams DESC
LIMIT 5;
```

#### 2️⃣ Unique Artists Count
```sql
SELECT COUNT(DISTINCT artist_name) AS unique_artists_count
FROM spotify;
```

#### 3️⃣ Distribution of Songs Across Release Years
```sql
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
```

#### 4️⃣ Top 10 Artists by Popularity with Average Danceability and Energy
```sql
SELECT artist_name,
       SUM(streams) AS streams,
       AVG(`danceability_%`) AS avg_danceability,
       AVG(`energy_%`) AS avg_energy
FROM spotify
GROUP BY artist_name
ORDER BY SUM(streams) DESC
LIMIT 10;
```
---
## B. Audio Features

#### 5️⃣ Danceability Differences Between Major and Minor Modes
```sql
SELECT
    DISTINCT mode,
    AVG(`danceability_%`) AS avg_danceability
FROM spotify
GROUP BY 1;
```

#### 6️⃣ Distribution of Acousticness Percentages Across Keys
```sql
SELECT 
    spotify.key,
    AVG(`acousticness_%`) AS avg_acousticness
FROM spotify
GROUP BY 1;
```

#### 7️⃣ Trends in Energy Levels Over the Years
```sql
SELECT
    CASE 
        WHEN released_year >= 2020 THEN '2020-2024'
        ELSE CONCAT(FLOOR(released_year/10)*10, '-', FLOOR(released_year/10)*10+10) 
    END AS decade_range,
    AVG(`energy_%`) AS avg_energy
FROM spotify        
GROUP BY 1
ORDER BY 1;
```

#### 8️⃣ Most Common Song Keys in the Dataset
```sql
SELECT
    `key`,
    COUNT(*) AS tot_songs
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

---

## C. Artist Impact

#### 9️⃣ Average Number of Artists in Charting Songs
```sql
SELECT
    AVG(artist_count) AS avg_artist_count
FROM spotify
WHERE track_name IN (in_spotify_charts, in_apple_charts, in_deezer_charts, in_shazam_charts);
```

#### 🔟 Relationship Between Artist Count and Danceability
```sql
SELECT
    artist_count,
    AVG(`danceability_%`) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 1 DESC;
```
#### 1️⃣1️⃣ Common Songs Between Deezer and Spotify Playlists
```sql
SELECT COUNT(*) AS common_songs_count
FROM spotify
WHERE in_spotify_playlists IS NOT NULL AND in_deezer_playlists IS NOT NULL;
```

---

## D. Shazam Metrics

#### 1️⃣2️⃣ Danceability of Songs Performing Well on Shazam Charts
```sql
SELECT `danceability_%`,
       COUNT(*) AS songs_count
FROM spotify
WHERE in_shazam_charts IS NOT NULL
GROUP BY `danceability_%`
ORDER BY 2 DESC
LIMIT 20;
```

#### 1️⃣3️⃣ Distribution of Speechiness Percentages for Shazam Chart Songs
```sql
SELECT CONCAT(FLOOR(`speechiness_%` / 5) * 5, '-', FLOOR(`speechiness_%` / 5) * 5 + 5) AS speechiness_distribution,
       COUNT(*) AS no_of_songs
FROM spotify
WHERE in_shazam_charts IS NOT NULL
GROUP BY 1
ORDER BY 1;
```

---

## E. Audio Features

#### 1️⃣4️⃣ Danceability Differences Between Major and Minor Modes
```sql
SELECT DISTINCT mode,
       AVG(`danceability_%`) AS avg_danceability
FROM spotify
GROUP BY 1;
```

#### 1️⃣5️⃣ Distribution of Acousticness Percentages Across Keys
```sql
SELECT spotify.key,
       AVG(`acousticness_%`) AS avg_acousticness
FROM spotify
GROUP BY 1;
```

#### 1️⃣6️⃣ Trends in Energy Levels Over the Years
```sql
SELECT CASE 
           WHEN released_year >= 2020 THEN '2020-2024'
           ELSE CONCAT(FLOOR(released_year / 10) * 10, '-', FLOOR(released_year / 10) * 10 + 10) 
       END AS decade_range,
       AVG(`energy_%`) AS avg_energy
FROM spotify        
GROUP BY 1
ORDER BY 1;
```

#### 1️⃣7️⃣ Most Common Song Keys in the Dataset
```sql
SELECT `key`,
       COUNT(*) AS tot_songs
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

---

## F. Artist Impact

#### 1️⃣8️⃣ Average Number of Artists in Charting Songs
```sql
SELECT AVG(artist_count) AS avg_artist_count
FROM spotify
WHERE track_name IN (in_spotify_charts, in_apple_charts, in_deezer_charts, in_shazam_charts);
```

#### 1️⃣9️⃣ Relationship Between Artist Count and Danceability
```sql
SELECT artist_count,
       AVG(`danceability_%`) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 1 DESC;
```
## G. Temporal Trends

### 2️⃣0️⃣ Distribution of Song Valence Over Months in 2023
```sql
SELECT released_month,
       AVG(`valence_%`) AS avg_valence
FROM spotify
WHERE released_year = '2023'
GROUP BY 1
ORDER BY 1;
```

---

## H. Correlation Analysis

### 2️⃣1️⃣ Correlation Between BPM and Danceability
```sql
SELECT ROUND((
           COUNT(*) * SUM(bpm * `danceability_%`) -
           SUM(bpm) * SUM(`danceability_%`)
         ) /
         SQRT(
           (COUNT(*) * SUM(bpm * bpm) - (SUM(bpm) * SUM(bpm))) *
           (COUNT(*) * SUM(`danceability_%` * `danceability_%`) - (SUM(`danceability_%`) * SUM(`danceability_%`)))
         ), 4) AS correlation_coeff
FROM spotify;
```
