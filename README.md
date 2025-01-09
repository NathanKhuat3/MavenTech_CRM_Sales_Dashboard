# MavenTech CRM Sales Dashboard

### PROJECT BACKGROUND

Maven Tech is a company that specializes in selling computer hardware to large businesses. They've been using a new CRM system to track their sales opportunities but have no visibility of the data outside of the platform. As a BI Developer in the company, I am working with the Sales Managers to create an interactive dashboard that allow them to track their team's quarterly performance.

### SQL ANALYSIS
[SQL queries](https://github.com/NathanKhuat3/MavenTech_CRM_Sales_Dashboard/blob/main/queries.sql)  

**Sector Analysis**
- Retail: Consistently the best-performing sector, followed by Technology and Medical.
- **Recommendation**: Focus on strengthening partnerships in Retail and exploring growth opportunities in Technology and Medical.

**Regional Analysis**
- Top Regions: Korea, Jordan, and Panama.
- In detail, Poland led in Q1 revenue, Jordan in Q2, Korea in Q3, Panama in Q4.
- **Recommendation**: Tailor regional strategies to maximize seasonal strengths.
  
- Most teams derive 15% of revenue from international clients (non-USA clients) with the exceptions of Brinkmann and Marxen teams exceed 20%, leading in international revenue.
- **Recommendation**: Share best practices from Brinkmann and Marxen teams to improve other teams’ international client relationships.
![image](https://github.com/user-attachments/assets/c798b5b0-2a62-4e49-af7c-cfd87db1958c)


**Product Analysis**
- The average transaction revenue for Won deals for most products are performing slight worse compared to expected retail price, with the exception of MG Special and GTX Plus Pro
- The GTX Plus Basic is a clear example of underperformance to expectation as the average transaction prices is 1.46% below target.
- **Recommendation**: Reassess GTX Plus Basic pricing to align with market demand and improve sales.
![image](https://github.com/user-attachments/assets/cb39d060-1166-4664-9614-f9a62533e92d)


**KPI Analysis**  
Revenue Performance: Quarterly team performance comparisons.
![image](https://github.com/user-attachments/assets/8ef6e085-6f34-49b7-be8b-b87ccdc6023e)


Account Conversion:
- Rouche and Seawald have a high number of deals in the Engaging Phase, indicating deferred revenue.
- Marxen and Brinkmann lead in Prospecting deals (>200), while other teams have none.
- **Recommendation**: Encourage improvements on Prospecting deals at the end of each year by the other four teams

Turnaround Time: Varies by quarter; reducing overall turnaround time is a priority.

### DASHBOARD
![image](https://github.com/user-attachments/assets/2b6ae39d-151b-4229-ba76-7d9353368b79)


### EXECUTIVE SUMMARY

The sales data highlights strong seasonality, with Q2 driving the highest revenue while Q1 generate substantially less revenue than other quarters. Despite having the highest average close value per transaction and the highest conversion rate, the low number of closed accounts and the long average turnaround time per transaction means that the First Quarter was unable to yield significant revenue. In terms of product, GTX Basic has the highest number of transactions but GTX Plus Pro and MG Advanced are more important for revenue. 

### INSIGHTS DETAILS

Revenue:
- On average, the other three quarters more than double the revenue of the First Quarter, with the Second Quarter being the highest revenue generating quarter, indicating strong seasonality. 
- The average close value per closed transaction is roughly $1,300 for Quarter 1 but only $1,100 for the remaining 3 quarters

Turn Around Time
- The average Turnaround Time for a transaction is 1.6 months
- On average, the first quarter takes about 2.2 months to close a transaction but the remaining quarters only take 1.5 months. However the first quarter witness a significantly higher Won/Lost ratio in deals
- Out of 8800 transactions recorded, 5564 accounts (63%) were Closed and 3236 accounts (37%) were either in the Engaging phase or Prospecting Phase
- Other quarters close roughly 3 times the number of accounts closed in the First Quarter, once again suggesting seasonality effect. 

Product
- The product with the highest number of transactions is GTX Basic and this is true for all quarters and all teams. GTX Basic is the Flag Ship Product
- Despite GTX Basic being the most popular product, the GTX Plus Pro and MG Advanced were the main revenue contributors across all quarters, together accounting for more than 70% of the year's total revenue


### RECOMMENDATIONS

Optimized Product Pricing
- Review and ensure that GTX Basic's pricing is optimized as there is high demand for this product
- Bundle the MG Advanced and the GTX Plus Pro with complementary products to induce higher sales volme

Incentive Program
- Provide quarterly and annual bonuses to employees as a fraction of their generated sales

Client
- Assign high performing employees to big-revenue client deals, ensure high level of quality check and customer service for important customers
- Identify medium-sized clients and target them with customized offerings and loyalty programs to encourage repurchase

Off-season Exploitation
- Utilize the off-season in the First Quarter to focus on formulating sales strategy, restocking inventory and providing training. This time of low demand can also be used for identifying leads and laying the groundwork for relationships without the immediate goal of a sale.

[Data Source](https://mavenanalytics.io/challenges/maven-sales-challenge/8f59bcfa-d310-4947-b3d8-917b3cce270e)  
[Tableau Link](https://public.tableau.com/app/profile/minh.quang.khuat.duy/viz/MavenTechCRMAnalytics/Dashboard1)
