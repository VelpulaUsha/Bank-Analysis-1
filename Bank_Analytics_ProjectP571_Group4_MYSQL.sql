create database Bank_loan_analysis_project;

Use Bank_loan_analysis_project ;

select * from finance_1;
SELECT * from finance_2;
select count(*) from finance_1;


# KPI 1 : YEAR WISE LOAN AMOUNT

select 
 year(issue_d) as Year_of_issue_d , 
sum(loan_amnt) as Total_loan_amnt 
from finance_1
group by Year_of_issue_d
order by Year_of_issue_d;

# KPI 2 : GRADE & SUB-GRADE WISE REVOL_BALANCE

select 
  grade, sub_grade, sum(revol_bal) as total_revol_bal
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by grade, sub_grade
order by grade, sub_grade;

# KPI 3 : TOTAL PAYMENT FOR VERIFIED & NON VERIFIED STATUS

select 
 verification_status , 
 concat("$", format(round(sum(total_pymnt)/1000000,2),2),"M") as total_payment
 from finance_1 inner join finance_2
 on(finance_1.id = finance_2.id)
 group by verification_status ;
 
 # KPI 4 : STATE WISE AND MONTH WISE LOAN STATUS
 
 select  
  addr_state, last_credit_pull_D , loan_status 
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by addr_state, last_credit_pull_D, loan_status
order by last_credit_pull_D;

# KPI 5 : HOME OWNERSHIP VS LAST PAYMENT DATE STATS

select 
 home_ownership, last_pymnt_d,
 CONCAT('$', FORMAT(ROUND(SUM(last_pymnt_amnt) / 10000 , 2), 2), 'K') as total_amount
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by home_ownership, last_pymnt_d
order by last_pymnt_d DESC, home_ownership DESC;