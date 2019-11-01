CREATE TABLE UPW14_WOS_MATCHING_RES_EVAL AS
SELECT
    t1.doi as upw_doi,
    t1.pubyear as upw_pubyear,
    t1.article_title as upw_article_title,
    t1.length_article_title as upw_title_length,
    t1.authorcount as upw_authorcount,
    t1.journal_name as upw_journal_name,
    t1.journal_issns as upw_journal_issns,
    t3.pk_items as wos_pk_items,
    t3.doi as wos_doi,
    t3.pubyear as wos_pubyear,
    t3.article_type as wos_article_type,
    t3.article_title as wos_article_title,
    t3.length_article_title as wos_title_length,
    t3.authorcount as wos_authorcount,
    t3.journal_name as wos_journal_name,
    t3.journal_issns as wos_journal_issns
FROM
    GWDGAHOBERT.UPW_14_NORM t1
LEFT JOIN
    GWDGAHOBERT.UPW_14_NORM_ISSNS t2
ON
    t1.DOI = t2.DOI
INNER JOIN
    GWDGAHOBERT.WOS_14_16_NORM t3
ON
    (t2.ISSN = t3.JOURNAL_ISSNS OR t1.JOURNAL_NAME = t3.JOURNAL_NAME)
    AND t1.AUTHORCOUNT = t3.AUTHORCOUNT
    AND ABS(t1.LENGTH_ARTICLE_TITLE - t3.LENGTH_ARTICLE_TITLE) < 10
    AND UTL_MATCH.EDIT_DISTANCE_SIMILARITY(t1.ARTICLE_TITLE, t3.ARTICLE_TITLE) > 80
    