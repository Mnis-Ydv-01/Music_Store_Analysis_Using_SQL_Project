create database musicdb;
use musicdb;

                                      -- SQL PROJECT- MUSIC STORE DATA ANALYSIS --
  
  -- Who is the senior most employee based on job title?                                    
select *  from employee
order by levels desc limit 1;

-- Which countries have the most Invoices?
select count(*) as most , billing_country
  from invoice group by billing_country order by most desc;
  
-- What are top 3 values of total invoice?
select total from invoice
   order by total desc limit 3;

-- Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
select city , sum(total) as invoice_total from invoice i join customer c on i.customer_id=c.customer_id
group by city order by invoice_total desc limit 1;

-- Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the most money
select c.customer_id,concat(first_name, ' ',last_name) as full_name , 
sum(total) as most_money from invoice i join customer c on i.customer_id=c.customer_id
group by c.customer_id ,full_name order by most_money desc limit 1;

-- Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A
select * from customer;
select * from genre;
select * from invoice_line;
select * from invoice;
select * from track;

select c.first_name,c.last_name,c.email,g.name from customer c join invoice i on c.customer_id=i.customer_id
       join invoice_line il on i.invoice_id=il.invoice_id
       join track t on il.track_id=t.track_id
       join genre g on t.genre_id=g.genre_id
       where g.name ='Rock'
       order by c.email asc;
     
-- Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands                       
select * from track;
select * from artist;
select * from album2;
select * from genre;
select at.artist_id , at.name , count(at.artist_id) number_of_song
from track t
JOIN album2 al ON al.album_id = t.album_id
JOIN artist at ON at.artist_id = al.artist_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name LIKE 'Rock'
GROUP BY at.artist_id ,at.name
ORDER BY number_of_song DESC
LIMIT 10;

-- Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first
select * from track;
select name , milliseconds from track
where milliseconds >(
                     select avg(milliseconds) as avg_milliseconds from
                     track)
                     order by milliseconds;

-- Find how much amount spent by each customer on artists? Write a query to return
-- customer name, artist name and total spent

SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;



























































































