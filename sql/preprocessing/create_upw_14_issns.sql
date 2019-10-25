CREATE TABLE UPW_14_NORM_ISSNS AS WITH UPW_ISSNS AS (select 
    DOI,
    regexp_substr(JOURNAL_ISSNS, '[^,]+', 1, 1) as ISSN_1, 
    regexp_substr(JOURNAL_ISSNS, '[^,]+', 1, 2) as ISSN_2,
    regexp_substr(JOURNAL_ISSNS, '[^,]+', 1, 3) as ISSN_3,
    regexp_substr(JOURNAL_ISSNS, '[^,]+', 1, 4) as ISSN_4
FROM
    GWDGAHOBERT.UPW_14_NORM)
select distinct
    DOI, ISSN
FROM
    UPW_ISSNS
unpivot
(
  ISSN
  for ISSN_NAME in (ISSN_1, ISSN_2, ISSN_3, ISSN_4)
)
