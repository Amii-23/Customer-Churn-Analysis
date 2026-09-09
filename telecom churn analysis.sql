create database telecom_churn;

# Q1 Overall Churn Rate

select count(*) as total_customers,
sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
round(sum(case when churn = "yes" then 1 else 0 end)*100.0/count(*),2) as churned_rate
from customer;

# Q2 Churn by contract

select contract,
         count(*) as total_customers,
         sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
         round(sum(case when churn = "yes" then 1 else 0 end)/count(*)*100,2) as churned_rate
         from 
             customer
		group by contract
        order by churned_rate;
        
        
# Q3 churn by tenure

select 
       case when tenure<=12 then "0-12 months"
			when tenure<=24 then "13-24 months"
            when tenure<=48 then "25-48 months"
            when tenure<=60 then "49-60months"
            else "60+ months"
            end as tenure_group,
            count(*) as total_customers,
        sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
        round(sum(case when churn="yes" then 1 else 0 end)/count(*)*100,2) as churned_rate
from
       customer
group by tenure_group
order by churned_rate desc;


#Q4 churned by payment method

select paymentmethod,
         count(*) as total_customers,
         sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
         round(sum(case when churn ="yes" then 1 else 0 end)/count(*)*100,2) as churned_rate
         from
              customer
		group by paymentmethod
        order by churned_rate desc;
        
        
#Q5 churn by internet service

select internetservice,
        count(*) as total_customers,
        sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
        round(sum(case when churn = "yes" then 1 else 0 end)/count(*)*100,2) as churn_rate
from 
       customer
group by internetservice
order by churn_rate desc;

#Q6 churn by monthlycharges
select 
         case when monthlycharges <=50 then "Low charges"
		 when monthlycharges<=100 then "Medium Charges"
         else "High Charges"
         end as charge_category,
         count(*) as total_charges,
         sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
         concat(round(sum(case when churn = "yes" then 1 else 0 end)/count(*)*100,2),"%") as churn_rate
from 
     customer
group by charge_category
order by churn_rate desc;


#Q7 churn by gender

select gender,
       count(*) as total_customers,
       sum(case when churn = "yes" then 1 else 0 end) as churned_Customers,
	   concat(round(sum(case when churn = "yes" then 1 else 0 end)/count(*)*100,2),"%") as churn_rate
from 
       customer
group by gender
order by churn_rate desc;


#Q8 churn by additional services

select onlinesecurity,
         count(*) as total_customers,
         sum(case when churn = "yes" then 1 else 0 end) as churned_customers,
         concat(round(sum(case when churn = "yes" then 1 else 0 end)/count(*)*100,2),"%") as churn_rate
from  
    customer
    group by onlinesecurity
    order by churn_rate;
    
#Q9 High risk customer identification

select 
        customerid,
        tenure,
        contract,
        monthlycharges,
        internetservice,
        paymentmethod
from 
             customer
where contract = "Month-to-month" and tenure<=12 and monthlycharges > 70 and churn = "yes"
order by monthlycharges desc;