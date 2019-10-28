CREATE TABLE UPW_14_NORM AS
    WITH TITLES AS (
      SELECT 
          LOWER(TRIM(TITLE)) AS ARTICLE_TITLE
      FROM 
          GWDGAHOBERT.UPW_APR19_MATCHINGTEST_14
      WHERE
          GENRE = 'journal-article'
          AND TITLE IS NOT NULL
          AND NOT EXISTS (
            SELECT
                  1
              FROM
                  gwdgahobert.title_keyword_blacklist
              WHERE
                regexp_substr(LOWER(TRIM(TITLE)), '^[^\. ]+') like GWDGAHOBERT.title_keyword_blacklist.expression || '%'
          )
      GROUP BY
          LOWER(TRIM(TITLE))
      HAVING
          COUNT(*) = 1
    )
SELECT
    LOWER(TRIM(DOI)) AS DOI,
    YEAR AS PUBYEAR,
    LOWER(TRIM(TITLE)) AS ARTICLE_TITLE,
    LENGTH(LOWER(TRIM(TITLE))) AS LENGTH_ARTICLE_TITLE,
    AUTHORCOUNT,
    LOWER(TRIM(JOURNAL_NAME)) AS JOURNAL_NAME,
    JOURNAL_ISSNS
FROM
    GWDGAHOBERT.UPW_APR19_MATCHINGTEST_14
WHERE
    GENRE = 'journal-article'
    AND LOWER(TRIM(TITLE)) IN (SELECT ARTICLE_TITLE FROM TITLES)