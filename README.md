# PizzaHut-RFM-analysis
This RFM analysis project aims to segment Pizza Hut's customer base based on Recency, Frequency, and Monetary Value (RFM) to gain insights into customer behavior, identify high-value customers, and inform targeted marketing strategies.

I. Data from Excel file: Purchasing data
- BillID: Bill ID
- Channel: Method of order: Take away/ Delivery/ Dine in
- OrderFrom: Order from: Call Center/ Website/ Store/ App
- TransactionDate: Transaction Date
- SalesAmount
- CustomerID
- CustomerGender: Male / Female / Blank
- VoucherStatus: 0 - if the customer did not use a discount voucher and 1 - if the customer did use a discount voucher
- Province: Location of the customer

II. Steps:
  1. Data Preparation and Precision
  - 1.1: Trim excess
  - 1.2: Format TransactionDate data type to DateTime
  - 1.3: Fix misspelled values

  2. Data Analysis and Insights: Calculate RFM score based on Recency, Frequency, and Monetary
  - 2.1: Recency: Calculate the date difference between the latest Purchase_Date and 1/9/2022 (Which is the report date)
  - 2.2: Frequency: Count distinct Purchase_Date
  - 2.3: Monetary: Sum GMV
  - 2.4: Grade the Recency, Frequency, and Monetary based on the IQR (Interquartile Range) method
  - 2.5: Concatenate the Scores of R, F, and M into RFM, then count distinct these combinations.
  - 2.6: Categorize customers into different segmentations based on their RFM scores.

  3. Business questions:
  - 3.1: Describe the portrait of customers and provide insights into their behavior: Who are the people buying products? Which location do they live in? Which channel are they purchasing from? What makes them buy?
  - 3.2: Using the RFM Model, segment customers into different groups
  - 3.3: Calculate customer life value (CLV)
  - 3.4: Recommendations: How to engage and attract new customers or lapers? How to increase frequency for repeated users?

  4. Generate the report
  - 4.1: Write a completed report based on what we have found.
  - 4.2: Combine with Domain Knowledge (BCG Matrix)

III. Tools:
- SQL
- Power BI Desktop
- PowerPoint
