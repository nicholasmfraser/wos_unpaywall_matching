CREATE TABLE UPW14_WOS_MATCHING_RESULTS_4 AS
WITH DOI_MATCHES AS (SELECT
    t1.DOI AS DOI
FROM
    GESISNFRASER.UPW_14_NORM t1
INNER JOIN
    GESISNFRASER.WOS_12_17_NORM t2
ON
    t1.DOI = t2.DOI
    AND t1.ARTICLE_TYPE = 'journal-article'
    AND t2.ARTICLE_TYPE IN ('article', 'review'))
SELECT
    t1.doi as upw_doi, t1.pubyear as upw_pubyear, t1.article_type as upw_article_type, t1.article_title as upw_article_title, t1.authorcount as upw_authorcount,
    t1.first_author_name as upw_first_author_name, t1.last_author_name as upw_last_author_name, t1.journal_name as upw_journal_name, t1.journal_issns as upw_journal_issns,
    t3.pk_items as wos_pk_items, t3.doi as wos_doi, t3.pubyear as wos_pubyear, t3.article_type as wos_article_type, t3.article_title as wos_article_title, t3.authorcount as wos_authorcount,
    t3.journal_name as wos_journal_name, t3.journal_issns as wos_journal_issns
FROM
    GWDGAHOBERT.UPW_14_NORM_PREPROC t1
LEFT JOIN
    GESISNFRASER.UPW_14_NORM_ISSNS t2
ON
    t1.DOI = t2.DOI
INNER JOIN
    GWDGAHOBERT.WOS_14_16_NORM_PREPROC t3
ON
    (t2.ISSN_VALUE = t3.JOURNAL_ISSNS OR t1.JOURNAL_NAME = t3.JOURNAL_NAME)
    AND t1.AUTHORCOUNT = t3.AUTHORCOUNT
    AND ABS(LENGTH(t1.ARTICLE_TITLE)- LENGTH(t3.ARTICLE_TITLE)) < 10
    AND UTL_MATCH.EDIT_DISTANCE_SIMILARITY(t1.ARTICLE_TITLE, t3.ARTICLE_TITLE) > 80
    AND t1.DOI NOT IN (SElECT DOI FROM DOI_MATCHES)
    AND t3.DOI is null
UNION
SELECT
    t1.doi as upw_doi, t1.pubyear as upw_pubyear, t1.article_type as upw_article_type, t1.article_title as upw_article_title, t1.authorcount as upw_authorcount,
    t1.first_author_name as upw_first_author_name, t1.last_author_name as upw_last_author_name, t1.journal_name as upw_journal_name, t1.journal_issns as upw_journal_issns,
    t3.pk_items as wos_pk_items, t3.doi as wos_doi, t3.pubyear as wos_pubyear, t3.article_type as wos_article_type, t3.article_title as wos_article_title, t3.authorcount as wos_authorcount,
    t3.journal_name as wos_journal_name, t3.journal_issns as wos_journal_issns
FROM
    GESISNFRASER.UPW_14_NORM t1
INNER JOIN
    GESISNFRASER.WOS_12_17_NORM t3
ON
    t1.DOI = t3.DOI
    AND t1.ARTICLE_TYPE = 'journal-article'
    AND t3.ARTICLE_TYPE IN ('article', 'review');
