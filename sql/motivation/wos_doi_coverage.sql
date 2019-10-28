SELECT
    PUBYEAR,
    lower(trim(DOCTYPE)) AS article_type,
    count(*) AS total_number_of_items,
    count(CASE WHEN doi is NULL THEN 1 ELSE NULL END) AS number_of_nulls,
    count(CASE WHEN doi is not NULL THEN 1 ELSE NULL END) AS number_of_dois
FROM
    wos_b_2019.items
GROUP BY
    pubyear,
    lower(trim(DOCTYPE))