-- Exploring  the tables
SELECT * FROM Ruca_zipcode LIMIT 30;
SELECT * FROM General LIMIT 30;
SELECT * FROM Timely LIMIT 30;
SELECT * FROM HCAHPS LIMIT 30;


--Query 1(H1): For Clustered Bar Chart that coulb filtered by States or cities
SELECT 
    case--grouping Hospital Ownership in two categories
    	when g.`Hospital Ownership` like 'Government%' then 'Government'
    	else 'Private'
    end as Ownership_Group,
    g.`City/Town`,
    g.State,
    h.`start Date`,
    h.`End Date`,
    CASE --creating different area types
        WHEN r.RUCA1 >= 7 THEN 'Rural'
        WHEN r.RUCA1 BETWEEN 4 AND 6 THEN 'Suburban'
        ELSE 'Urban'
    END AS Area_Type,
    ROUND(AVG(CAST(h.`Patient Survey Star Rating` AS DECIMAL)), 2) AS Avg_Star_Rating
FROM General g
JOIN HCAHPS h ON g.`Facility ID` = h.`Facility ID`--joiging the three datasets
JOIN Ruca_zipcode r ON r.ZIP_CODE = g.`ZIP Code` 
WHERE g.`Hospital Type` = 'Acute Care Hospitals' and h.`Patient Survey Star Rating`<> "Not Applicable" 
GROUP BY Ownership_Group, g.State, g.`City/Town`, Area_Type
having Avg_Star_Rating>0
ORDER BY Ownership_Group, g.State, Area_Type;



--Query 2(H1): For Scatter plot
--Survey response rate vs. number of better READM outcomes (colored by ownership and could be filtered or split by area)

SELECT 
    g.`City/Town`,
    g.State,
    h.`start Date`,
    h.`End Date`,
    CASE 
        WHEN r.RUCA1 >= 7 THEN 'Rural'
        WHEN r.RUCA1 BETWEEN 4 AND 6 THEN 'Suburban'
        ELSE 'Urban'
    END AS Area_Type,
    case when g.`Hospital Ownership` like 'Government%' then 'Government'
    	else 'Private'
    end as Ownership_Group,
    cast(g.`Count of READM Measures Better` as integer) as READM_better_count,
    cast(h.`Survey Response Rate Percent` as interger) as Survey_response_rate
from General g
join HCAHPS h on g.`Facility ID` = h.`Facility ID`
join Ruca_zipcode r ON r.ZIP_CODE = g.`ZIP Code`
where  
    h.`Survey Response Rate Percent`<> "Not Applicable" and 
    g.`Count of READM Measures Better`<> "Not Applicable" and 
    cast(g.`Count of READM Measures Better`as integer)>0 and
    cast(h.`Survey Response Rate Percent`as integer)>0
ORDER BY Ownership_Group, g.State, Area_Type;



--Querry 3(H1):Heatmap or Treemap: Ownership × location × mortality rating categories
SELECT
    CASE 
        WHEN g.`Hospital Ownership` LIKE 'Government%' THEN 'Government'
        else'Private'
    END AS Ownership_Group,
    CASE 
        WHEN r.RUCA1 >= 7 THEN 'Rural'
        WHEN r.RUCA1 BETWEEN 4 AND 6 THEN 'Suburban'
        ELSE 'Urban'
    END AS Area_Type,
    CASE 
        WHEN CAST(`Count of MORT Measures Better` AS INTEGER) > 
             CAST(`Count of MORT Measures Worse` AS INTEGER) AND 
             CAST(`Count of MORT Measures Better` AS INTEGER) > 
             CAST(`Count of MORT Measures No Different` AS INTEGER) THEN 'Better' 
        WHEN CAST(`Count of MORT Measures Worse` AS INTEGER) > 
             CAST(`Count of MORT Measures Better` AS INTEGER) AND 
             CAST(`Count of MORT Measures Worse` AS INTEGER) > 
             CAST(`Count of MORT Measures No Different` AS INTEGER) THEN 'Worse'
        ELSE 'No Different'
    END AS Mortality_Category,
    COUNT(*) AS Hospital_Count
FROM General g
JOIN Ruca_zipcode r ON r.ZIP_Code = g.`ZIP Code`
WHERE g.`Hospital Type` = 'Acute Care Hospitals'
  AND `Count of MORT Measures Better` <> 'Not Applicable'
  AND `Count of MORT Measures Worse` <> 'Not Applicable'
  AND `Count of MORT Measures No Different` <> 'Not Applicable'
GROUP BY Ownership_Group, Area_Type, Mortality_Category
ORDER BY Ownership_Group, Area_Type, Mortality_Category;



--Querry 4(H2): Grouped Bar Chart Average clinical care scores (calculation field will be used in tableau for the average) by care type  across patient engagement tiers (High, Medium, Low)
-- Box Plot: Distribution of clinical performance scores within each engagement tier and
-- Scatter Plot: Survey response rate vs. clinical score, colored by care type
SELECT
    h.`Facility ID`,
    h.`City/Town`,
    h.State,
    h.`Survey Response Rate Percent`,
    h.`start Date`,
    h.`End Date`,
    CASE
        WHEN CAST(h.`Patient Survey Star Rating` AS FLOAT) >= 4 then 'High'
        WHEN CAST(h.`Patient Survey Star Rating` AS FLOAT) BETWEEN 3 AND 3.9 THEN 'Medium'
        ELSE 'Low'
    END AS Engagement_Tier,
    CASE
        WHEN t.Condition LIKE '%Emergency%' OR t.Condition LIKE '%Sepsis%' THEN 'Emergency'
        WHEN t.Condition LIKE '%Cataract%' THEN 'Surgical'
        WHEN t.Condition LIKE '%Colonoscopy%' THEN 'Chronic'
        ELSE 'Other'
    END AS Care_Type,
   CAST(t.Score AS FLOAT)AS Clinical_Score
FROM Timely t
JOIN HCAHPS h ON t.`Facility ID` = h.`Facility ID`
WHERE
    t.Score NOT IN ('Not Available', 'Not Applicable', 'Low', 'Medium', 'High') AND
    h.`Patient Survey Star Rating` NOT IN ('Not Available', 'Not Applicable') AND
    h.`Survey Response Rate Percent` NOT IN ('Not Available', 'Not Applicable')
ORDER BY Engagement_Tier, Care_Type;































