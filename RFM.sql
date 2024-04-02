WITH RFM_calculation AS (SELECT *,
                                DATEDIFF(CURDATE(), MAX(TransactionDate)) AS recency,
                                COUNT(DISTINCT TransactionDate)           AS frequency,
                                SUM(SalesAmount)                          AS monetary
                         FROM data
                         GROUP BY CustomerID),

     RFM_rn AS (SELECT *,
                       ROW_NUMBER() over (ORDER BY recency DESC) AS rn_recency,
                       ROW_NUMBER() over (ORDER BY frequency)    AS rn_frequency,
                       ROW_NUMBER() over (ORDER BY monetary)     AS rn_monetary
                FROM RFM_calculation),

     RFM_chart AS (SELECT *,
                          CASE
                              WHEN rn_recency < (SELECT COUNT(DISTINCT CustomerID) * 0.25
                                                 FROM data) then '1'
                              WHEN rn_recency >= (SELECT COUNT(DISTINCT CustomerID) * 0.25
                                                  FROM data) AND rn_recency < (SELECT COUNT(DISTINCT CustomerID) * 0.5
                                                                               FROM data) then '2'
                              WHEN rn_recency >= (SELECT COUNT(DISTINCT CustomerID) * 0.5
                                                  FROM data) and rn_recency < (SELECT COUNT(DISTINCT CustomerID) * 0.75
                                                                               FROM data) then '3'
                              ELSE '4' END AS R,

                          CASE
                              WHEN rn_frequency < (SELECT COUNT(DISTINCT CustomerID) * 0.25
                                                   FROM data) then '1'
                              WHEN rn_frequency >= (SELECT COUNT(DISTINCT CustomerID) * 0.25
                                                    FROM data) AND
                                   rn_frequency < (SELECT COUNT(DISTINCT CustomerID) * 0.5
                                                   FROM data) then '2'
                              WHEN rn_frequency >= (SELECT COUNT(DISTINCT CustomerID) * 0.5
                                                    FROM data) and
                                   rn_frequency < (SELECT COUNT(DISTINCT CustomerID) * 0.75
                                                   FROM data) then '3'
                              ELSE '4' END AS F,


                          CASE
                              WHEN rn_monetary < (SELECT COUNT(DISTINCT CustomerID) * 0.25
                                                  FROM data) then '1'
                              WHEN rn_monetary >= (SELECT COUNT(DISTINCT CustomerID) * 0.25
                                                   FROM data) AND rn_monetary < (SELECT COUNT(DISTINCT CustomerID) * 0.5
                                                                                 FROM data) then '2'
                              WHEN rn_monetary >= (SELECT COUNT(DISTINCT CustomerID) * 0.5
                                                   FROM data) and
                                   rn_monetary < (SELECT COUNT(DISTINCT CustomerID) * 0.75
                                                  FROM data) then '3'
                              ELSE '4' END AS M
                   FROM RFM_rn),
     RFM_concat AS (SELECT *,
                           CONCAT(R, F, M) AS RFM
                    FROM RFM_chart)
SELECT *,
       CASE
           WHEN RFM = 444 THEN 'Champion'
           WHEN RFM IN (344, 244, 343, 443, 234) THEN 'Loyal'
           WHEN RFM IN (412, 413) THEN ' Promising'
           WHEN RFM = 411 THEN 'New Customers'
           WHEN RFM IN (311, 321, 322, 312) THEN 'Should Not lose'
           WHEN RFM IN (232, 323, 233, 231) THEN 'Need Attention'
           WHEN RFM IN (122, 121, 123) THEN 'Sleepers'
           WHEN RFM IN (111, 112) THEN 'Lost'
           ELSE 'Non Category' END AS Segmentation
FROM RFM_concat;

SET @report_date = '2022-09-01';
SELECT @report_date