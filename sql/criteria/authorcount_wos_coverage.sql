SELECT 
  ROUND((SUM(CASE WHEN D_AUTHOR_CNT IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*))*100, 2) AS PCT_COVERAGE 
FROM 
  WOS_B_2019.ITEMS
WHERE
  DOCTYPE IN ('Article', 'Review')
  AND PUBYEAR >= 2014
  AND PUBYEAR <= 2016
