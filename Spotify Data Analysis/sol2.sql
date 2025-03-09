use spotify;

#F. Audio Features:

#14.Is there a noticeable difference in danceability percentages between songs in major and minor modes?

select
	distinct mode,
    avg(`danceability_%`) as avg_danceability
from spotify
group by 1;

#15.How does the distribution of acousticness percentages vary across different keys?

select 
	spotify.key,
    avg(`acousticness_%`) as avg_acousticness
from spotify
group by 1;

#16.Are there any trends in the energy levels of songs over the years?1

select
	case 
		when released_year>=2020 then '2020-2024'
        else concat(floor(released_year/10)*10,'-',floor(released_year/10)*10+10) end as decade_range,
	avg(`energy_%`) as avg_energy
from spotify        
group by 1
order by 1;

#17.What are the most common song keys for the entire dataset?

select
	`key`,
    count(*) as tot_songs
from spotify
group by 1
order by 2 desc
limit 5;


#G. Artist Impact:

#18.What is the average number of artists contributing to a song that makes it to the charts?

select
	avg(artist_count) as avg_artist_count
from spotify
where track_name in (in_spotify_charts, in_apple_charts, in_deezer_charts, in_shazam_charts);

#19.Do songs with a higher number of artists tend to have higher or lower danceability percentages?

select
	artist_count,
    avg(`danceability_%`) as Avg_danceability
from spotify
group by 1
order by 1 desc;

