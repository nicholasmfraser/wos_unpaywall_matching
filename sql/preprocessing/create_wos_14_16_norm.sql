CREATE TABLE WOS_14_16_NORM AS
    WITH TITLES AS (
        SELECT 
            LOWER(TRIM(ARTICLE_TITLE)) AS ARTICLE_TITLE
        FROM 
            WOS_B_2019.ITEMS
        WHERE
            LOWER(DOCTYPE) in ('article', 'review')
            AND PUBYEAR in ('2014', '2015', '2016')
            AND ARTICLE_TITLE IS NOT NULL
            AND NOT EXISTS (
            SELECT
                  1
              FROM
                  gwdgahobert.title_keyword_blacklist
              WHERE
                regexp_substr(LOWER(TRIM(ARTICLE_TITLE)), '^[^\. ]+') like GWDGAHOBERT.title_keyword_blacklist.expression || '%'
            )
        GROUP BY
            LOWER(TRIM(ARTICLE_TITLE))
        HAVING
            COUNT(*) = 1
    )
SELECT
    t1.PK_ITEMS,
    LOWER(TRIM(DOI)) AS DOI,
    PUBYEAR,
    LOWER(t1.DOCTYPE) AS ARTICLE_TYPE,
    LOWER(TRIM(ARTICLE_TITLE)) AS ARTICLE_TITLE,
    D_AUTHOR_CNT AS AUTHORCOUNT,
    LOWER(TRIM(SOURCETITLE)) AS JOURNAL_NAME,
    ISSN AS JOURNAL_ISSNS
FROM
    WOS_B_2018.ITEMS t1
INNER JOIN
    WOS_B_2018.SOURCES t2
ON
    t1.FK_SOURCES = t2.PK_SOURCES
WHERE
    LOWER(TRIM(ARTICLE_TITLE)) IN (SELECT ARTICLE_TITLE FROM TITLES)
    LOWER(DOCTYPE) in ('article', 'review')
    AND PUBYEAR in ('2014', '2015', '2016')
