/* we should take a look at 2012's monthly and weekly volume patterns,to see if we can find any seasonal trends we should plan for in 2013*/


select * from website_session
select * from orders


create view df1 as
select website_session.website_session_id,website_session.created_at,orders.order_id,year(website_session.created_at) as year,month(website_session.created_at) as mo,DATEPART(ww,website_session.created_at) as week from website_session 
left join orders
on website_session.website_session_id=orders.website_session_id
where website_session.created_at<'2013-01-01'



select year,mo,count(website_session_id) as session_month,count(order_id) as order_month from df1
group by year, mo
order by mo



select year,mo,week,count(website_session_id) as session_week,count(order_id) as order_week from df1
group by year,mo,week
order by year,mo,week

--------------------------------
/*We are considering adding live chat support to the website to improve our customer experience.Could you analyze the website session volume,by hour of day and by day week,so that we can staff appropriately?
date range of Sep15-Nov,2012*/




create view df3 as 
select website_session_id,created_at,DATEPART(WEEKDAY,created_at) as day_of_week,DATEPART(HOUR,created_at) as hour from website_session
where created_at>'2012-09-15'  and  created_at<'2012-11-15' 


select day_of_week,COUNT(website_session_id) as session from df3
group by day_of_week
order by day_of_week



select hour,
count(case when day_of_week=1 then website_session_id else null end) as monday,
count(case when day_of_week=2 then website_session_id else null end) as tuesday,
count(case when day_of_week=3 then website_session_id else null end) as wednesday,
count(case when day_of_week=4 then website_session_id else null end) as thursday,
count(case when day_of_week=5 then website_session_id else null end) as friday,
count(case when day_of_week=6 then website_session_id else null end) as saturday,
count(case when day_of_week=7 then website_session_id else null end) as sunday,
count(website_session_id) as total_session

from df3
group by hour
order by hour


