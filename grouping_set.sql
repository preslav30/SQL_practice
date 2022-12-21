/*
*  Calculate the total amount of employees per department and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/

SELECT de.dept_no, count(de.emp_no)
FROM public.employees AS e
INNER JOIN public.dept_emp AS de USING(emp_no)
GROUP BY 
    GROUPING SETS (
        (de.dept_no),
        ()
    )
ORDER BY de.dept_no ASC;


/*
*  Calculate the total average salary per department and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/

SELECT de.dept_no, AVG(s.salary)
FROM public.dept_emp AS de
INNER JOIN public.salaries AS s USING(emp_no)
GROUP BY
    GROUPING SETS (
    (), 
    (de.dept_no)
    )
ORDER BY de.dept_no