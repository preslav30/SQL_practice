/*
*  Show me all the employees, hired after 1991, that have had more than 2 titles
*  Database: Employees
*/

SELECT e.emp_no, e.hire_date, concat(e.first_name, ' ', e.last_name) AS "name", count(t.title) AS "titles"
FROM public.employees AS e
INNER JOIN public.titles AS t USING(emp_no)
WHERE EXTRACT(YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
HAVING count(e.emp_no) > 2;


/*
*  Show me all the employees that have had more than 15 salary changes that work in the department development
*  Database: Employees
*/

SELECT e.emp_no, count(s.from_date) AS "salary changes", concat(e.first_name, ' ', e.last_name) AS "name"
FROM public.employees AS e
INNER JOIN public.salaries AS s USING(emp_no)
INNER JOIN public.dept_emp AS de USING(emp_no)
INNER JOIN public.departments AS d USING(dept_no)
WHERE d.dept_name = 'Development'
GROUP BY e.emp_no
HAVING count(s.from_date) > 15;


/*
*  Show me all the employees that have worked for multiple departments
*  Database: Employees
*/


SELECT e.emp_no, concat(e.first_name, ' ', e.last_name) AS "name", count(de.dept_no) AS "number of departments"
FROM public.employees AS e
INNER JOIN public.dept_emp AS de USING(emp_no)
INNER JOIN public.departments AS d USING(dept_no)
GROUP BY e.emp_no 
HAVING count(de.dept_no) > 1;
