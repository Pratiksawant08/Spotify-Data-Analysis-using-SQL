--1.Retrieve the names of all tracks that have more than 1 billion streams.--

select Track , stream from spotify
where stream>1000000000;

--2.List all albums along with their respective artists.--
select artist,album from spotify;

--3.Get the total number of comments for tracks where licensed = TRUE.--
select sum(comments) as total_comments from spotify
where licensed = 'TRUE';

--4.Find all tracks that belong to the album type single.--
select track from spotify
where album_type = 'single';

--5.Count the total number of tracks by each artist--
select artist ,count(track) as total_track  from spotify
group by artist
order by 2 asc;



