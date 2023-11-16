SELECT CONCAT(a.first_name, ' ', a.last_name) as full_name, 
		a.title AS employee_title, 
        ROUND((a.hire_date -a.birth_date)/365.25, 0) employee_age, 
        ROUND((current_date - a.hire_date)/365.25, 0) employee_tenure, 
        CONCAT(B.first_name, ' ', B.last_name) as manager_full_name, 
        B.title AS manager_title
        
FROM employees A
LEFT JOIN employees B 
ON a.reports_to = b.employee_id
ORDER BY 3, 1 