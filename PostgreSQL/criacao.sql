-- Se eu selecionar uma parte do codigo, so essa parte roda
set schema 'public';
	
DROP TABLE department CASCADE; -- deleta todas as relacoes
DROP TABLE funcionarios CASCADE;
DROP TABLE salary_grade CASCADE;

-- 1) Criando as tabelas (relacoes)

CREATE TABLE IF NOT EXISTS public.department (
	dep_id SERIAL NOT NULL,
	dep_name VARCHAR(20) NOT NULL,
	dep_location VARCHAR(15) NOT NULL,
  	PRIMARY KEY (dep_id)
);

CREATE TABLE IF NOT EXISTS public.funcionarios (
	emp_id SERIAL NOT NULL,
	emp_name VARCHAR(20) NOT NULL,
	job_name VARCHAR(10) NOT NULL,
	manager_id INTEGER,
	hire_date DATE,
	salary DECIMAL(10,2),
	commission DECIMAL(7,2),
	dep_id INTEGER,
  	PRIMARY KEY (emp_id),
	FOREIGN KEY (dep_id) REFERENCES department(dep_id) ON DELETE CASCADE
);

ALTER TABLE public.funcionarios
ADD FOREIGN KEY (manager_id)
REFERENCES funcionarios(emp_id);
	
	
CREATE TABLE IF NOT EXISTS public.salary_grade (
	grade INTEGER,
	min_salary INTEGER,
	max_salary INTEGER,
  	PRIMARY KEY (grade)
);


-- 2) Inserindo os dados

DELETE FROM department; -- Deleta todos os dados da relacao
INSERT INTO department VALUES (1001, 'FINANCE', 'SYDNEY');
INSERT INTO department VALUES (2001, 'AUDIT', 'MELBOURNE');
INSERT INTO department VALUES (3001, 'MARKETING', 'PERTH');
INSERT INTO department VALUES (4001, 'PRODUCTION', 'BRISBANE');
SELECT * FROM department ORDER BY dep_id; -- Analisar os itens de departamento

DELETE FROM funcionarios;
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(1, 'KAYLING', 'PRESIDENT', null, '1991-11-18', 6000.00, null, 1001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(2, 'BLAZE', 'MANAGER', 1, '1991-05-01', 2750.00, null, 3001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(3, 'CLARE', 'MANAGER', 1, '1991-06-09', 2550.00, null, 1001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(4, 'JONAS', 'MANAGER', 1, '1991-04-02', 2957.00, null, 2001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(5, 'ADELYN', 'SALESMAN', 2, '1991-02-20', 1700.00, 400.00, 3001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(6,'WADE', 'SALESMAN', 2, '1991-02-22', 1350.00, 600.00, 3001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(7, 'MADDEN', 'SALESMAN', 2, '1991-09-28', 1350.00, 1500.00, 3001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(8, 'TUCKER', 'SALESMAN', 2, '1991-09-08', 1600.00, 0.00, 3001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(9, 'ADNRES', 'CLERK', null, '1997-05-23', 1200.00, null, 2001); -- ADNRES ATUALMENTE SEM MANAGER PQ FOI ADICIONADO DPS
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(10, 'JULIUS', 'CLERK', 2, '1991-12-03', 1050.00, null, 3001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(11, 'MARKER', 'CLERK', 3, '1992-01-23', 1400.00, null, 1001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(12, 'SCARLET', 'ANALYST', 4, '1997-04-19', 3100.00, null, 2001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(13, 'FRANK', 'ANALYST', 4, '1991-12-03', 3100.00, null, 2001);
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(14, 'SANDRINE', 'CLERK', 13, '1990-12-18', 900.00, null, 2001);
UPDATE funcionarios -- SETTANDO MANAGER DO ADNRES AGR, PQ ELE ENTROU NA EMPRESA ANTES DE SEU MANAGER
SET manager_id = 12
WHERE emp_id = 9;
SELECT * FROM funcionarios ORDER BY emp_id;

DELETE FROM salary_grade; -- Deleta todos os dados da relacao
INSERT INTO salary_grade VALUES (1, 800, 1300);
INSERT INTO salary_grade VALUES (2, 1301, 1500);
INSERT INTO salary_grade VALUES (3, 1501, 2100);
INSERT INTO salary_grade VALUES (4, 2101, 3100);
INSERT INTO salary_grade VALUES (5, 3101, 9999);
SELECT * FROM salary_grade ORDER BY grade;




