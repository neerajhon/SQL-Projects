

#5.Which song is present in the highest number of Spotify playlists?
USE spotify;

SELECT 
    track_name, 
    artist_name, 
    in_spotify_playlists AS highest_playlist_count
FROM spotify
ORDER BY in_spotify_playlists DESC
LIMIT 1;

#6.Is there a correlation between the number of streams and a song's presence in Spotify charts?

SELECT   ROUND((
           COUNT(*) * SUM(streams * in_spotify_charts) -
           SUM(streams) * SUM(in_spotify_charts)
         ) /
         SQRT(
           (COUNT(*) * SUM(streams * streams) - (SUM(streams) * SUM(streams))) *
           (COUNT(*) * SUM(in_spotify_charts * in_spotify_charts) - (SUM(in_spotify_charts) * SUM(in_spotify_charts)))
         ), 4) AS correlation_coeff
FROM  spotify;


#7.What is the average BPM (Beats Per Minute) of songs on Spotify?

select avg(bpm) as avg_bpm
from spotify;

#8.What is the average danceability of the top 15 most popular songs?

SELECT AVG(`danceability_%`) AS top15_avg_danceability
FROM (
    SELECT   track_name, streams, `danceability_%`
    FROM     spotify
    ORDER BY streams DESC
    LIMIT    15
) AS top_15_songs;

#C. Apple Music Metrics:

#9.How many songs made it to both Apple Music charts and Spotify charts?

select count(*) as common_songs_count
from spotify
where in_spotify_charts is not null and in_apple_charts is not null;

#.D. Deezer Metrics:

#10.Are there any trends in the presence of songs on Deezer charts based on the release month?
select released_month,
		COUNT(*) as total_Songs
from spotify
where in_deezer_charts is not null
group by 1
order by 1;

#11.How many songs are common between Deezer and Spotify playlists?
 select count(*) as common_songs_count
 from spotify
 where in_spotify_playlists is not null and in_deezer_playlists is not null;

#E. Shazam Metrics:

 
 #12.Do songs that perform well on Shazam charts have higher danceability percentages? (not sure about the solution)
 
select 
	`danceability_%`,
    count(*) as songs_count
from spotify
where in_shazam_charts is not null
group by `danceability_%`
order by 2 desc
limit 20;

#13.What is the distribution of speechiness percentages for songs on Shazam charts?

select
	concat(floor(`speechiness_%`/5)*5,'-',floor(`speechiness_%`/5)*5+5) as speechiness_distribution,
    count(*) as no_of_songs
from spotify
where in_shazam_charts is not null
group by 1
order by 1



 
 




