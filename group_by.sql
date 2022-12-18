/*
*  Show me all the employees, hired after 1991 and count the amount of positions they've had
*  Database: Employees
*/


-- select e.emp_no, count(p.title) as "number of positions"
-- from public.employees as e
-- inner join public.titles as p USING (emp_no)
-- where extract(YEAR from e.hire_date) > 1991
-- GROUP BY e.emp_no
-- ORDER BY "number of positions" DESC

/*
*  Show me all the employees that work in the department development and the from and to date.
*  Database: Employees
*/

SELECT emp.emp_no, concat(emp.first_name, ' ', emp.last_name) AS "Name", emp.emp_no, dep.*, dep_emp.*
FROM public.departments AS "dep"
INNER JOIN public.dept_emp AS "dep_emp" USING(dept_no)
INNER JOIN public.employees AS "emp"  USING(emp_no)
WHERE dep.dept_no = 'd005'
