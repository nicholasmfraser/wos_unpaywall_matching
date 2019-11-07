SELECT
    COUNT(distinct CONCAT(upw_doi, wos_doi)) AS total_matches,
    COUNT(DISTINCT CASE WHEN upw_doi = wos_doi THEN upw_doi ELSE NULL END) -1 AS doi_matches
FROM
    GWDGAHOBERT.UPW14_WOS_MATCHING_RES_EVAL
WHERE
    wos_doi is not null
