# Matching Strategy for connecting Web of Science and Unpaywall

## Overview

This repository documents our approach to developing a procedure for the connection of items covered by the Web of Science (WoS) in-house database of the [German Competence Center for Bibliometrics](http://www.bibliometrie.info/) (KB), to information on their open access status contained in [Unpaywall](https://unpaywall.org/).

As a start, we recommend reading the [report](report.pdf), containing a detailed description of our data selection and methodology to derive, implement and evaluate a matching algorithm. The rendered report is based on the corresponding [R Markdown document](report.Rmd).

All queries we used to retrieve information from the Oracle Environment of the WoS-KB database are stored as separate files in the folder [`sql/`](sql/) Some queries take a while to execute which is why in these cases, we downloaded the aggregated data and stored it in the [`data/`](data) directory.

For now, reproducing the analysis is only possible with valid authentication credentials for the access restricted data infrastructure of the WoS-KB database.

## SQL files

The [`sql/`](sql) directory contains the queries used to interface the WoS-KB database:

- [`motivation/`](sql/motivation) - The query generating the aggregated data [`wos_doi_coverage.csv`](data/wos_doi_coverage.csv) on the DOI coverage of items registered in the WoS-KB database.
- [`criteria/`](sql/criteria) - Several queries used to evaluate the potential of possible matching criteria, namely article title, length of the article title, author count, ISSN, journal title, and publication year, in a matching algorithm.
- [`preprocessing/`](sql/preprocessing) - Queries used to generate the normalised and cleaned tables `upw_14_norm` and `wos_14_16_norm`, which the matching algorithm is then applied on.
- [`matching/`](sql/matching) - Implementation of the matching procedure, performed with ( [`create_upw14_wos_matching_results.sql`](sql/matching/create_upw14_wos_matching_results.sql)) or without ( [`create_upw14_wos_matching_res_eval.sql`](sql/matching/create_upw14_wos_matching_res_eval.sql)) using DOI information.
- [`results/`](sql/results) - Queries used to retrieve the number of matches obtained in order to evaluate the performance of the developed algorithm.

## Data files

The [`data/`](data) directory contains the aggregated data sets as csv files.

- [`wos_doi_coverage.csv`](data/wos_doi_coverage.csv) reports what number of items in the WoS-KB database have or have not DOI information.
- The subdirectory [`data/results/`](data/results) holds the aggregated matching results, where the matching algorithm was performed with ( [`doi_matches_aggr.csv`](data/results/doi_matches_aggr.csv)) or without ( [`doi_matches_eval_aggr.csv`](data/results/doi_matches_eval_aggr.csv)) using DOI information.
- The subdirectory [`data/criteria/`](data/criteria) collectes some of the aggregated data used for testing possible matching criteria for whether or not they are suitable to be implemented in the resulting matching routine. Mostly, the data stored here are applied to investigate how the article title can be used in a matching procedure. One execption is [`publication_years_doi_matches.csv`](data/criteria/publication_years_doi_matches.csv), containing data on how publication years of articles with the same DOI differ in Unpaywall and WoS-KB.
