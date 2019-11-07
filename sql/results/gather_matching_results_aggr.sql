SELECT
    COUNT(*) AS TOTAL_MATCHES,
    SUM(CASE WHEN UPW_DOI = WOS_DOI THEN 1 ELSE 0 END)  AS DOI_MATCHES,
    SUM(CASE WHEN WOS_DOI IS NULL THEN 1 ELSE 0 END) AS WOS_NULLS,
    SUM(CASE WHEN UPW_DOI <> WOS_DOI AND WOS_DOI IS NOT NULL THEN 1 ELSE 0 END) AS DIFF_DOIS
FROM
    GWDGAHOBERT.UPW14_WOS_MATCHING_RESULTS
    