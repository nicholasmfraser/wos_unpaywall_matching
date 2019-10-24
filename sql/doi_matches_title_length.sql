SELECT
    DIFF, COUNT(*)
FROM (
    SELECT
        ABS(LENGTH(t1.ARTICLE_TITLE)-LENGTH(t2.ARTICLE_TITLE)) AS DIFF 
    FROM
        UPW_14_NORM t1
    INNER JOIN
        WOS_12_17_NORM t2
    ON
        t1.DOI = t2.DOI AND
        t1.ARTICLE_TYPE = 'journal-article' AND
        t2.ARTICLE_TYPE IN ('article', 'review'))
GROUP BY DIFF
ORDER BY DIFF
