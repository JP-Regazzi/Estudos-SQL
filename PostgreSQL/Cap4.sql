-- Inner Join (Mais importante): Junta as colunas quando algum fator eh igual/verdadeiro nas duas (intercecao)

-- 1) Encontrar cada funcionario, relacionado com o id, nome e localizacao de seu departamento
SELECT funcionarios.emp_id, funcionarios.emp_name, funcionarios.dep_id, department.dep_name, department.dep_location
FROM funcionarios
JOIN department ON funcionarios.dep_id = department.dep_id; -- OBS: JOIN = INNER JOIN;

-- 2) Encontrar cada funcionario e seu nivel salarial na empresa
SELECT funcionarios.emp_id, funcionarios.emp_name, funcionarios.salary, salary_grade.grade
FROM funcionarios
JOIN salary_grade ON funcionarios.salary >= salary_grade.min_salary AND funcionarios.salary <= salary_grade.max_salary;

select * from funcionarios ORDER BY salary;
select * from salary_grade ORDER BY grade;



-- Left Join: Todos da "esquerda" sao incluidos, todos da direita que fazem parte da intercesao tambem.
-- Se algo da "esquerda" nao possui correspondente da "direita", o campo da "direita" eh preenchido com null.

-- Adicionei de teste um funcionario que nao estaria em nenhuma faixa salarial da empresa
INSERT INTO funcionarios(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
VALUES(15, 'Regazzi', 'estudante', null, '2020-03-17', 400.00, null, 2001);
-- Podemos perceber que eu nao apareco na busca do exercicio (2). Se realizarmos uma LEFT JOIN, o resultado seria diferente
SELECT funcionarios.emp_id, funcionarios.emp_name, funcionarios.salary, salary_grade.grade
FROM funcionarios
LEFT JOIN salary_grade ON funcionarios.salary >= salary_grade.min_salary AND funcionarios.salary <= salary_grade.max_salary;
-- Agora meu nome aparece nos resultados, com uma faixa salarial null



-- Right Join: Oposto do left join, todos da "direita" sao incluidos, todos da esquerda que fazem parte da intercesao tambem.
-- Se algo da "direita" nao possui correspondente da "esquerda", o campo da "esquerda" eh preenchido com null.

-- Adicionei de teste uma faixa salarial que nenhum funcionario pertence
INSERT INTO salary_grade VALUES(-1, 100, 200);
-- Podemos perceber que a nova faixa salarial nao aparece na busca do exercicio (2). Se realizarmos uma RIGHT JOIN, o resultado seria diferente
SELECT funcionarios.emp_id, funcionarios.emp_name, funcionarios.salary, salary_grade.grade
FROM funcionarios
RIGHT JOIN salary_grade ON funcionarios.salary >= salary_grade.min_salary AND funcionarios.salary <= salary_grade.max_salary;
-- Agora a nova faixa salarial aparece, com um funcionario null


/* Se quiser, utilizar esse codigo para deletar o funcionario extra e a faixa extra que criei

DELETE FROM funcionarios 
WHERE emp_id = 15; 

DELETE FROM salary_grade 
WHERE grade = -1; 
*/



-- View: Com view podemos criar uma nova "tabela" com apenas o que desejarmos.
-- (Nem sempre vale a pena visualizar todas as colunas da relacao.)

CREATE VIEW empregados as
SELECT emp_id, emp_name, job_name, hire_date
FROM funcionarios;

SELECT * FROM empregados;



-- Integrity Constraints (Restricoes de Integridade): NOT NULL, UNIQUE, DEFAULT, AUTO_INCREMENT, CHECK, PRIMARY KEY

-- ON DELETE/ ON UPDATE: CASCADE, SET NULL, SET DEFAULT (n sei pq so o cascade ta funfando)

-- DATA TYPES: date, time, timestamp, interval, blob, clob. (Tbm da pra criar os proprios tipos)
