-- EXERCICIOS QUERIES COMUNS

-- Encontrar funcionarios que foram contratados em janeiro
SELECT * FROM funcionarios WHERE to_char(hire_date, 'mon')='jan';

-- Encontrar funcionarios com nome que comeca com M
SELECT * FROM funcionarios WHERE emp_name LIKE 'M%';

-- Encontrar funcionarios que trabalham como admnistrador ou analista
SELECT * FROM funcionarios WHERE job_name = 'ANALYST' or job_name = 'MANAGER';

-- Retornar o nome dos trabalhos feitos na empresa, de forma decrescente
SELECT DISTINCT job_name FROM funcionarios ORDER BY job_name DESC;

-- Encontrar funcionarios contratados nos dias 1 de maio de 1991, 3 de dezembro de 1991 ou 19 de janeiro de 1990
SELECT * FROM funcionarios WHERE hire_date IN ('1991-5-01', '1991-12-03', '1990-01-19');

-- Encontrar o ID, nome e data de contratacao de funcionarios em ordem crescente de experiencia
SELECT emp_id, emp_name, hire_date, CURRENT_DATE, age(CURRENT_DATE, hire_date) as EXP FROM funcionarios ORDER BY EXP ASC;
-- ^Nessa questao usei funcao age ( , )

-- Encontrar todos funcionarios que nao sao 'CLERK' e ordena-los por seus respectivos salarios de forma decrescente
SELECT * FROM funcionarios WHERE job_name <> 'CLERK' ORDER BY salary DESC;

-- Encontrar os chefes que estao a mais tempo na empresa que seus comandados
SELECT * FROM funcionarios i, funcionarios j WHERE i.manager_id = j.emp_id and j.hire_date > i.hire_date; -- data maior = mais antiga?

-- Encontrar quanto foi gasto por ano para cada tipo de trabalho na empresa
SELECT job_name, sum(12*salary) AS spent FROM funcionarios GROUP BY job_name;

-- Encontrar funcionarios que trabalham no departamento de id 1001 ou 2001, retornar emp_id, emp_name, dep_id, dep_location e dep_name
SELECT funcionarios.emp_id, funcionarios.emp_name, department.dep_id, department.dep_name, department.dep_location
FROM funcionarios, department
WHERE (funcionarios.dep_id = 1001 AND department.dep_id = 1001) OR (funcionarios.dep_id = 2001 AND department.dep_id = 2001)
ORDER BY dep_id, emp_id;


-- EXERCICIOS NESTED QUERIES
