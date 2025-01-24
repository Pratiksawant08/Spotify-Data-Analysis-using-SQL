--1.Calculate the average danceability of tracks in each album.--
select album,avg(Danceability) as Avg_danceability from spotify
group by album
order by 2 desc;

--2.Find the top 5 tracks with the highest energy values.--
select distinct track,max(Energy) from spotify
group by track
order by 2 desc
limit 5;

--3.List all tracks along with their views and likes where official_video = TRUE.--
select track ,Views ,Likes from spotify
where official_video = 'TRUE'
order by Views desc;

--4.For each album, calculate the total views of all associated tracks.--
select distinct album ,track , sum(Views) as Total_views from spotify
group by 1,2
order by Total_views desc;

--5.Retrieve the track names that have been streamed on Spotify more than YouTube.--
select * from 
(select 
	track,
	--most_played_on,
	coalesce(sum(case when most_played_on='Youtube' then stream end),0 ) as stream_on_YT,
	coalesce(sum(case when most_played_on='Spotify' then stream end),0 ) as stream_on_SF
from spotify
group by 1) as t1
where stream_on_SF>stream_on_YT
and stream_on_YT<>0;









