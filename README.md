# Exploring Hospital Performance Through Ownership, Geography, and Patient Engagement

This project explores how hospital ownership, geographic location (urban vs. rural), and patient engagement levels impact clinical outcomes and patient experience across U.S. acute care hospitals.
Using SQL for data extraction and preparation, and Tableau for visual storytelling, I tested two hypotheses using datasets from CMS (Centers for Medicare & Medicaid Services).

# Objectives

1. Evaluate whether private vs. government-owned hospitals differ in performance across urban and rural areas.
2. Explore how patient engagement (survey response rate + star ratings) relates to clinical care performance in different service areas (e.g., emergency, surgical, chronic).

# Datasets

|   Dataset                      |                 Description	                                                        |            Link                                                                    |
|--------------------------------|--------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
|    HCAHPS                      | Hospital Consumer Assessment of Healthcare Providers and Systems (patient experience)|<https://data.cms.gov/provider-data/search?fulltext=HCAHPS>                         |
|Hospital General Information    |Includes ownership, location, and mortality/readmission counts                        |<https://data.cms.gov/provider-data/dataset/xubh-q36u>                              |
|Timely and Effective Care       |Condition-specific care measures and scores                                           |<https://data.cms.gov/provider-data/search?fulltext=Timely%20and%20Effective%20Care>|
|rural-urban-commuting-area-codes| Maps ZIP codes to urban/rural categories                                             |<https://www.ers.usda.gov/data-products/rural-urban-commuting-area-codes>           |

# Hypotheses

**Hypothesis 1:** Among acute care hospitals, privately owned facilities in urban areas have significantly higher patient experience scores and more favorable readmission/mortality ratings compared to government-owned hospitals — but this advantage diminishes in rural settings.
**Hypothesis 2:** Hospitals with higher patient engagement (high response rates and star ratings) tend to perform significantly better in emergency and surgical care measures — but this relationship weakens for chronic condition treatments like heart failure or pneumonia.

# SQL processing

I used DBeaver CE with SQLite to clean and join datasets, categorize hospitals, and extract relevant metrics. Full SQL queries (with comments) can be found here:[queries.sql](https://github.com/Heritier1990/Hospital_performance_SQL-Tableau/blob/main/Hospital_analysis.sql)

**Techniques used:**
 -Data cleaning & filtering (e.g., removing "Not Applicable")
 -Joins across datasets (INNER and LEFT JOINs)
 -Derived fields (e.g., Urban/Rural classification from RUCA codes)
 -Aggregations & groupings
 -CASE statements for classification (ownership group, engagement tier, care type)

 # Visualizations (Tableau)

 Published dashboard: [Tableau Public: Hospital Performance Story](https://public.tableau.com/app/profile/henri.heritier/viz/ExploringHospitalPerformanceThroughOwnershipGeographyandPatientEngagement/Story1?publish=yes )

 # Key Dashboards
 
***Hypothesis 1***
-Clustered Bar Chart: Avg. patient experience score by ownership and area (Urban/Rural)
-Scatter Plot: Survey response rate vs. count of favorable readmission outcomes
-Treemap/Heatmap: Ownership × Area × Mortality performance

***Hypothesis 2***
-Grouped Bar Chart: Avg. clinical score by engagement tier and care type
-Box Plot: Clinical score distribution by engagement level
-Scatter Plot: Survey response rate vs. clinical performance (colored by care type)

# Key Insights

- Private hospitals in urban areas outperform government-owned ones in both experience and outcomes, but this advantage diminishes in rural regions.
- Emergency, surgical, and chronic care areas show higher and more consistent performance across all hospitals.
- Patient engagement positively correlates with clinical scores, especially in emergency and surgical care.
- Score distributions are right-skewed, with most hospitals clustering at moderate performance levels.

# How to Use This Project

1. Explore queries in queries.sql to see how the data was transformed.
2. View the published dashboard on Tableau Public.
3. Clone this project for inspiration or replication using your own data or tools.
4. Feel free to share your own interpretations or observations.
Data is rich with stories — your perspective might uncover patterns I haven’t considered!

# Contact
Feel free to reach out if you have questions or feedback!
Henri Simo – [LinkedIn](www.linkedin.com/in/henrisimo) | [Email](henrisimo1990@gmail.com)
