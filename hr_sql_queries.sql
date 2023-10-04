create database hr;
use hr;

select * from hr_data;
alter table hr_data change column `Employee Number` employee_count int;
alter table hr_data change column `Education Field` education_field varchar(50);
alter table hr_data change column `cf_age band` ageband varchar(50);

# Number of Employees
select count(employee_count) as Employee_Count from  hr_data;     


# Attrition Count
select count(attrition) as Attrition_Count from hr_data
where attrition = "yes";


# Attrition Rate
select concat(round((select count(attrition) as Attrition_Count from hr_data
where attrition = "yes") / count(employee_count)*100,2),"% ") as Attrition_Rate from hr_data;


# Active Employee
select count(employee_count) - (select count(attrition) as Attrition_Count from hr_data
where attrition = "yes") as Active_Employee from hr_data;


# Average Age
select round(avg(age),0) Avg_Age from hr_data;


# Attrition by Gender
select gender, count(attrition) as Attrition_Count from hr_data
where attrition = "yes"  
group by gender
order by Attrition_Count desc;


# Department wise Attrition
select department, count(attrition) Attrition_Count,
concat(round((count(attrition) / (select count(attrition) from hr_data where attrition = "yes"))*100,2),"%") as pct              # pct -> percentage of total
from hr_data where attrition = "yes"
group by department
order by Attrition_Count desc ;


# No. of Employee by Age Group (Making Bins)
select
case
when age between 18 and 28 then "[18-28]"
when age between 29 and 38 then "[29-38]"
when age between 39 and 48 then "[39-48]"
when age between 49 and 60 then "[49-60]"
else "[60+]"
end as Age_Bin,
count(*) Age_Count
from hr_data
group by 1
order by 1;


# Education Field wise Attrition
select education_field, count(attrition) as Attrition_Count from hr_data
where attrition = "yes"  
group by education_field
order by Attrition_Count desc;


select * from hr_data;
# Attrition by Gender for Different Age Group

select ageband, gender, count(attrition) as Attrition_Count,
concat(round((count(attrition) / (select count(attrition) from hr_data where attrition = "yes"))*100,2),"%") pct
from hr_data
where attrition = "yes"  
group by ageband, gender
order by ageband, gender;



