SELECT 
  ROUND((SUM(CASE WHEN TITLE IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*))*100, 2) AS PCT_COVERAGE 
FROM 
  GWDGAHOBERT.UPW_APR19_MATCHINGTEST_14
WHERE
  GENRE = 'journal-article'
