SELECT 
    COUNT(distinct upw_doi) AS n
FROM
    GWDGAHOBERT.UPW14_WOS_MATCHING_RESULTS
WHERE 
    upw_doi = wos_doi
