#H. Temporal Trends:

#20.How has the distribution of song valence percentages changed over the months in 2023?

select
	released_month,
    avg(`valence_%`) as avg_valence
from spotify
where released_year = '2023'
group by 1
order by 1;

#correlation analysis

#21.Is there a correlation between BPM and danceability percentages?

select
ROUND((
           COUNT(*) * SUM(bpm * `danceability_%`) -
           SUM(bpm) * SUM(`danceability_%`)
         ) /
         SQRT(
           (COUNT(*) * SUM(bpm * bpm) - (SUM(bpm) * SUM(bpm))) *
           (COUNT(*) * SUM(`danceability_%` * `danceability_%`) - (SUM(`danceability_%`) * SUM(`danceability_%`)))
         ), 4) AS correlation_coeff
from spotify;

#22.How does the presence of live performance elements (liveness) correlate with acousticness percentages?

SELECT   ROUND((
           COUNT(*) * SUM(`liveness_%` * `acousticness_%`) -
           SUM(`liveness_%`) * SUM(`acousticness_%`)
         ) /
         SQRT(
           (COUNT(*) * SUM(`liveness_%` * `liveness_%`) - (SUM(`liveness_%`) * SUM(`liveness_%`))) *
           (COUNT(*) * SUM(`acousticness_%` * `acousticness_%`) - (SUM(`acousticness_%`) * SUM(`acousticness_%`)))
         ), 4) AS correlation_coeff
FROM     spotify;

#J. Popularity Analysis:

#23.Do songs with higher valence percentages tend to have more streams on Spotify?

SELECT
    (SUM(`valence_%` * streams) - SUM(`valence_%`) * SUM(streams) / COUNT(*)) / 
    SQRT((SUM(`valence_%` * `valence_%`) - POW(SUM(`valence_%`), 2) / COUNT(*)) * 
    (SUM(streams * streams) - POW(SUM(streams), 2) / COUNT(*))) AS valence_streams_correlation
FROM spotify;

#24.Is there a relationship between the number of Spotify playlists and the presence on Apple Music charts?
SELECT
    (SUM(in_spotify_playlists * in_apple_charts) - SUM(in_spotify_playlists) * SUM(in_apple_charts) / COUNT(*)) / 
    SQRT((SUM(in_spotify_playlists * in_spotify_playlists) - POW(SUM(in_spotify_playlists), 2) / COUNT(*)) * 
    (SUM(in_apple_charts * in_apple_charts) - POW(SUM(in_apple_charts), 2) / COUNT(*))) AS correlation
FROM spotify;




