--SQL max and min
SELECT MAX(column_name) AS max_value, MIN(column_name) AS min_value FROM table_name;


--SQL mean
SELECT AVG(my_column) AS mean_value FROM my_table;


--SQL median
SELECT AVG(my_column) AS median_value
FROM (
  SELECT my_column, ROW_NUMBER() OVER (ORDER BY my_column) AS RowNum, COUNT(*) OVER () AS TotalRows
  FROM my_table
) sub
WHERE RowNum IN (CEILING(TotalRows/2.0), FLOOR(TotalRows/2.0) + 1);

--SQL mode
SELECT my_column AS mode_value, COUNT(*) AS mode_frequency
FROM my_table
GROUP BY my_column
ORDER BY mode_frequency DESC
LIMIT 1;


--SQL decile
SELECT id, SUM(volume) AS total_volume
FROM my_table
GROUP BY id;


SELECT PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY total_volume) AS decile1,
       PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY total_volume) AS decile2,
       PERCENTILE_CONT(0.3) WITHIN GROUP (ORDER BY total_volume) AS decile3,
       PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY total_volume) AS decile4,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_volume) AS decile5,
       PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY total_volume) AS decile6,
       PERCENTILE_CONT(0.7) WITHIN GROUP (ORDER BY total_volume) AS decile7,
       PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_volume) AS decile8,
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_volume) AS decile9
FROM (
  SELECT id, SUM(volume) AS total_volume
  FROM my_table
  GROUP BY id
) sub;


SELECT id, total_volume,
       CASE 
         WHEN total_volume <= decile1 THEN '1st Decile'
         WHEN total_volume <= decile2 THEN '2nd Decile'
         WHEN total_volume <= decile3 THEN '3rd Decile'
         WHEN total_volume <= decile4 THEN '4th Decile'
         WHEN total_volume <= decile5 THEN '5th Decile'
         WHEN total_volume <= decile6 THEN '6th Decile'
         WHEN total_volume <= decile7 THEN '7th Decile'
         WHEN total_volume <= decile8 THEN '8th Decile'
         WHEN total_volume <= decile9 THEN '9th Decile'
         ELSE '10th Decile'
       END AS decile
FROM (
  SELECT id, SUM(volume) AS total_volume,
         PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY total_volume) AS decile1,
         PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY total_volume) AS decile2,
         PERCENTILE_CONT(0.3) WITHIN GROUP (ORDER BY total_volume) AS decile3,
         PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY total_volume) AS decile4,
         PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_volume) AS decile5,
         PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY total_volume) AS decile6,
         PERCENTILE_CONT(0.7) WITHIN GROUP (ORDER BY total_volume) AS decile7,
         PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_volume) AS decile8,
         PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_volume) AS decile9
  FROM my_table
  GROUP BY id
) sub;


--SQL compute mean, sum by group
SELECT group_id, AVG(value) AS mean_value, SUM(value) AS total_value
FROM table_name
GROUP BY group_id;


--SQL compute the difference between 2 cols
SELECT A - B AS difference
FROM my_table;


--SQL abs
SELECT ABS(column_name) FROM table_name;


--SQL conditional select
SELECT * FROM employees WHERE department = 'Sales';

SELECT * FROM employees WHERE salary > 50000 AND department = 'Sales';


--SQL text query
SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern;

SELECT *
FROM customers
WHERE name LIKE '%John%';

--SQL text search case sensitive
SELECT *
FROM customers
WHERE name COLLATE Latin1_General_CS_AS LIKE '%John%';


--SQL substring
SUBSTRING(string_expression, start, length)

SELECT SUBSTRING(text_string, 1, 4) AS first_four_chars
FROM your_table;


/*
Regular expressions can be used in SQL to perform advanced pattern matching and search operations. Here are some steps to use regular expressions in SQL:

Check if your SQL database supports regular expressions. Most modern databases like MySQL, Oracle, and PostgreSQL support regular expressions.
Use the REGEXP operator or the LIKE operator with the ESCAPE clause to specify a regular expression pattern. The syntax for using regular expressions with the REGEXP operator is:
SELECT * FROM table_name WHERE column_name REGEXP 'pattern';
The syntax for using regular expressions with the LIKE operator and the ESCAPE clause is:
SELECT * FROM table_name WHERE column_name LIKE 'pattern' ESCAPE 'escape_character';
In this syntax, you need to replace the "pattern" with your regular expression pattern, and "escape_character" with the character you want to use to escape special characters in the regular expression.
Use regular expression metacharacters to build your regular expression pattern. Some commonly used metacharacters in regular expressions are:
"." (dot) matches any single character
"^" (caret) matches the beginning of a line
"$" (dollar) matches the end of a line
"*" (asterisk) matches zero or more occurrences of the previous character
"+" (plus) matches one or more occurrences of the previous character
"?" (question mark) matches

*/

--SQL regexp examples

--SQL REGEXP_LIKE to match a pattern
SELECT *
FROM my_table
WHERE REGEXP_LIKE(my_column, '^[A-Za-z]+$');

--SQL REGEXP_REPLACE to replace a pattern
SELECT REGEXP_REPLACE(my_column, '[^0-9]', '') as my_column_numeric
FROM my_table;

--SQL REGEXP_INSTR to find the position of a pattern
SELECT REGEXP_INSTR(my_column, '[0-9]{3}-[0-9]{2}-[0-9]{4}') as ssn_position
FROM my_table;





