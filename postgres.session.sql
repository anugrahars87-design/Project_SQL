CREATE table jobpplied
(job_id int,
job_name varchar(60)
)
insert into jobpplied(job_id,job_name)
values(45,'daata')

 alter table  company_dim
rename column name to new_name;

sELECT * from jobpplied
insert into jobpplied(contact)
values (7435237383)


update jobpplied
set contact =907485748
where job_id=45


select
count(job_id),
extract (month from job_posted_date)  as month
from job_postings_fact
where job_title_short ='Data Analyst'
group by month
order by count(job_id)


create table april as
    select *
     from job_postings_fact
    where extract (month from job_posted_date)=4

    select *
    from april



select 
count(job_title_short) as tyjpe,
    case
        when job_title_short = 'Data Analyst' THEN 'urs' 
        when job_title_short = 'Data Scientist' then 'future' 
        else 'optional'
    end  as finding
from 
job_postings_fact
where job_no_degree_mention = true
group by finding


with  april as (
    select* from job_postings_fact
    where extract(months from job_posted_date)=4
)
select*from april



select new_name
from company_dim
where company_id in (
        select company_id,job_no_degree_mention
        from job_postings_fact
    where job_no_degree_mention = true
)




select   link,job_postings_fact.job_no_degree_mention
 from company_dim
left join  job_postings_fact 
on company_dim.company_id=job_postings_fact.company_id
where job_no_degree_mention = true
limit 50




with count_company as (
select company_id,count(*) as contjob
from job_postings_fact
 group by company_id)
    select company_dim.new_name,contjob from company_dim
    left join count_company
    on count_company.company_id= company_dim.company_id
order by contjob



select job_id,skill_id from skills_job_dim
left j





