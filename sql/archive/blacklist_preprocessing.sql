CREATE TABLE upw_14_norm_preproc as (
SELECT 
  *
FROM GESISNFRASER.upw_14_norm
WHERE
  ARTICLE_TITLE NOT IN (SELECT ARTICLE_TITLE FROM GESISNFRASER.UPW_14_TITLE_BLACKLIST WHERE ARTICLE_TITLE is not null)
  AND NOT EXISTS (
  SELECT
        1
    FROM
        gwdgahobert.title_keyword_blacklist
    WHERE
      regexp_substr(GESISNFRASER.upw_14_norm.article_title, '^[^\. ]+') like GWDGAHOBERT.title_keyword_blacklist.expression || '%'
  )
  AND ARTICLE_TYPE = 'journal-article'
)


CREATE TABLE wos_14_16_norm_preproc as (
SELECT 
    *
FROM
    GESISNFRASER.wos_12_17_norm
WHERE
    ARTICLE_TITLE NOT IN (SELECT ARTICLE_TITLE FROM GESISNFRASER.WOS_12_17_TITLE_BLACKLIST WHERE ARTICLE_TITLE is not null)
  AND NOT EXISTS (
  SELECT
        1
    FROM
        gwdgahobert.title_keyword_blacklist
    WHERE
      regexp_substr(GESISNFRASER.wos_12_17_norm.article_title, '^[^\. ]+') like GWDGAHOBERT.title_keyword_blacklist.expression || '%'
  )
  AND ARTICLE_TYPE IN ('article', 'review')
  AND PUBYEAR in ('2014', '2015', '2016')
)

