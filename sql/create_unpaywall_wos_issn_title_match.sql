CREATE TABLE UPW_WOS_ISSN_TITLE_MATCH AS (
SELECT
    t1.DOI AS UNPAYWALL_DOI, t3.DOI AS WOS_DOI, t1.ARTICLE_TITLE AS UNPAYWALL_TITLE, t3.ARTICLE_TITLE AS WOS_TITLE,
    UTL_MATCH.EDIT_DISTANCE_SIMILARITY(t1.ARTICLE_TITLE, t3.ARTICLE_TITLE) AS TITLE_SIMILARITY,
    t2.ISSN_VALUE AS UNPAYWALL_ISSN, t3.JOURNAL_ISSNS AS WOS_ISSN
FROM
    UPW_14_NORM SAMPLE(0.1) t1
LEFT JOIN
    UPW_14_NORM_ISSNS t2
ON
    t1.DOI = t2.DOI
INNER JOIN
    WOS_12_17_NORM t3
ON
    t2.ISSN_VALUE = t3.JOURNAL_ISSNS
    AND (UTL_MATCH.EDIT_DISTANCE_SIMILARITY(t1.ARTICLE_TITLE, t3.ARTICLE_TITLE) > 80))