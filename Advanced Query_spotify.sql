--1.Find the top 3 most-viewed tracks for each artist using window functions.--

with ranking_artist as(
select 
	artist ,
	track,
	sum(Views) as Total_views,
	dense_rank() over(partition by artist order by sum(Views) desc) as rank
from spotify
group by 1,2
order by 1,3 desc)
select *from ranking_artist
where rank <=3

--2.Write a query to find tracks where the liveness score is above the average.
select  track ,liveness
 from spotify 
where liveness >(select avg(liveness) from spotify);

--3.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.--

WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC

--4.Find tracks where the energy-to-liveness ratio is greater than 1.2.--
SELECT artist, track, energy, liveness, 
       CASE 
           WHEN liveness = 0 THEN NULL  -- Avoid division by zero
           ELSE (energy / liveness) 
       END AS energy_to_liveness_ratio
FROM spotify
WHERE liveness != 0  -- Ensure no zero liveness values
  AND (energy / liveness) > 1.2;

--5.Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.--
SELECT artist, track, views, likes,
       SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify
ORDER BY views desc;

