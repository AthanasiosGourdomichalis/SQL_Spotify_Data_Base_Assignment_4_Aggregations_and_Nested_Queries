--1
SELECT strftime('%Y', release_date / 1000, 'unixepoch') AS year, count(name) as albums_per_year
from albums
where popularity>40
group by year;

--2
SELECT strftime('%Y', release_date / 1000, 'unixepoch') AS year, count(name) as albums_per_year
from albums
where popularity>40 or album_type = 'single'
group by year;

--3
SELECT album_type, strftime('%Y', release_date / 1000, 'unixepoch') AS year, count(name) as albums_per_type_year
from albums
group by album_type, year;

--4
SELECT ar.name as artist, strftime('%Y', al.release_date / 1000, 'unixepoch') AS year, count(al.name) as albums_per_year
from albums al
join r_albums_artists as raa on al.id = raa.album_id
join artists as ar on raa.artist_id = ar.id 
where ar.name = 'ABBA'
group by year;

--5
SELECT name as album,strftime('%Y', release_date / 1000, 'unixepoch') AS year, max(popularity) as max_popularity
from albums
where popularity <> 0
group by year;

--6
SELECT ar.name as artist
from artists ar
join r_albums_artists as raa on ar.id = raa.artist_id
group by raa.artist_id having count(raa.album_id)>30;

--7
CREATE VIEW USERS(user_id, avg_rating, rating_count) As
select user_id, avg(rating), count(rating)
from Ratings
group by user_id;

--8
SELECT name as album_title, popularity
from albums
ORDER BY popularity DESC
LIMIT 10;

--9
SELECT strftime('%Y', al1.release_date / 1000, 'unixepoch') AS year, al1.name as most_popular_album
from albums AS al1, 
(select strftime('%Y', release_date / 1000, 'unixepoch') AS year2, max(popularity) as popularity
from albums
group by year2 ) AS al2
where year = al2.year2 and al1.popularity = al2.popularity
ORDER by year desc, name;

--10
SELECT DISTINCT ar.name
from artists ar
join r_artist_genre as rag3 on ar.id = rag3.artist_id
where exists(
select rag1.artist_id
from r_artist_genre as rag1
where rag1.genre_id = 'rock' and rag1.artist_id = rag3.artist_id)
and exists(
select rag2.artist_id
from r_artist_genre as rag2
where rag2.genre_id = 'blues' and rag2.artist_id = rag3.artist_id);

--11
SELECT name
from artists ar
join r_artist_genre as rag on ar.id = rag.artist_id
where rag.genre_id = 'rock'
INTERSECT
SELECT name
from artists ar
join r_artist_genre as rag on ar.id = rag.artist_id
where rag.genre_id = 'blues'

--12
SELECT r1.user_id, r2.user_id
FROM ratings r1
JOIN ratings r2 on r1.rating = r2.rating and r1.user_id <> r2.user_id and r1.album_id = r2.album_id
GROUP BY r1.user_id, r2.user_id
having COUNT(r1.user_id) >= 25;
