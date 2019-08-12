SELECT
    pubyear,
    article_type,
    count(*) as total_number_of_items,
    count(CASE WHEN doi is NULL THEN 1 ELSE NULL END) as number_of_nulls,
    count(CASE WHEN doi is not NULL THEN 1 ELSE NULL END) as number_of_dois
FROM
    gesisnfraser.wos_12_17_norm
GROUP BY
    pubyear,
    article_type
