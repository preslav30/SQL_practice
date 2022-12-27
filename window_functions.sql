/*
*  Show the population per continent
*  Database: World
*  Table: Country
*/

SELECT 
    DISTINCT continent, 
    sum(population) OVER continents AS "sum_per_continent"
FROM public.country
WINDOW continents AS (PARTITION BY continent);

/*
*  To the previous query add on the ability to calculate the percentage of the world population
*  What that means is that you will divide the population of that continent by the total population and multiply by 100 to get a percentage.
*  Make sure you convert the population numbers to float using `population::float` otherwise you may see zero pop up
*  Try to use CONCAT AND ROUND to make the data look pretty
*/

SELECT 
    DISTINCT continent, 
    sum(population) OVER continents AS "sum_per_continent",
    round((sum(population::FLOAT) OVER continents / sum(population::FLOAT) OVER()) * 100)AS "percentage"
FROM public.country
WINDOW continents AS (PARTITION BY continent);

/*
*  Count the number of towns per region
*  Database: France
*  Table: Regions (Join + Window function)
*/

SELECT
    DISTINCT r.id,
    r.name,
    count("t"."name") OVER regions AS "number of towns"    
FROM public.regions AS r
INNER JOIN public.departments AS d ON d.region = r.code
INNER JOIN public.towns AS t ON t.department = d.code
WINDOW regions AS (PARTITION BY r.id)
ORDER BY r.id ASC;
