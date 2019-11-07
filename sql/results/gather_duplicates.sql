SELECT
    COUNT(*) AS N
FROM
    GWDGAHOBERT.upw14_wos_matching_results
GROUP BY
    UPW_DOI
HAVING
    COUNT(*) > 1
ORDER BY
    COUNT(*) DESC
