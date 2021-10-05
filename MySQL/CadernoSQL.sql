-- Shortcuts: 
-- Execute (All or Selection) = Ctrl+Shift+Enter:
-- Execute (Current Statement) = Ctrl+Enter:

-- Data types:
-- INT
-- DECIMAL(10,4)  m= digitos do numero, n= num casas decimais
-- VARCHAR(1)  no parenteses tem o tamanho maximo da string
-- BLOB Binary Large Object
-- DATE 'YYYY-MM-DD'
-- TIMESTAMP 'YYYY-MM-DD HH:MM:SS'

use teste;

-- Criando tabelas: 
CREATE TABLE estudantes(  -- usamos capslock por convencao
id_estudante INT, 
nome VARCHAR(20),
curso VARCHAR(20),
PRIMARY KEY(id_estudante)
); 
DESCRIBE estudantes;
DROP TABLE estudantes; -- deleta a tabela
ALTER TABLE estudantes ADD cra DECIMAL(3, 2); -- add coluna
ALTER TABLE estudantes DROP COLUMN cra; -- deleta coluna

-- Inserindo dados: (posso alterar a linha abaixo pra cada insercao)
INSERT INTO estudantes VALUES(4, 'Matheus', 'Geologia');
INSERT INTO estudantes(id_estudante, nome) VALUES(3, 'Tai'); -- Inserir dado sem todas colunas 
SELECT * FROM estudantes; -- solicita todas colunas da tabela

-- Constraints (Restricoes): NOT NULL, UNIQUE, DEFAULT, AUTO_INCREMENT 
DROP TABLE estudantes; -- Vamos refazer a tabela de forma diferente
CREATE TABLE estudantes(  -- usamos capslock por convencao
id_estudante INT AUTO_INCREMENT, 
nome VARCHAR(20) DEFAULT 'Vagabundo', -- nao pode ser null
curso VARCHAR(20) UNIQUE, -- nao pode ter iguais na tabela 
PRIMARY KEY(id_estudante)
); 
INSERT INTO estudantes(nome, curso) VALUES('Ana', 'CVV');
INSERT INTO estudantes(nome) VALUES('Nicholas');

-- Update & Delete (operadores: =, <>, >, <, >=, <=)
SELECT * FROM estudantes;
UPDATE estudantes -- tabela atualizada
SET curso = 'CC', nome = 'TaiChola' -- oq muda
WHERE id_estudante = 2 OR id_estudante = 10; -- onde muda
DELETE FROM estudantes -- qual tabela vai deletar
WHERE id_estudante = 20; -- oq vai deletar da tabela

-- Basic Queries (solicitacoes basicas) 
SELECT nome, curso FROM estudantes -- quais colunas de q tabela
WHERE curso <> 'Geo' -- onde? (pode n existir) (p usar varios: WHERE IN ('c1', 'c2', 'c3'))
ORDER BY nome DESC, curso -- qual ordem (pode n existir)
LIMIT 3; -- qual limite de linhas (pode n existir)

-- More Basic Queries (mais solicitacoes basicas) (usando EmpresaTeste)
SELECT * FROM employee ORDER BY salary DESC LIMIT 5;
SELECT * FROM employee ORDER BY sex, salary DESC;
SELECT first_name as nome, last_name as sobrenome FROM employee;
SELECT DISTINCT sex FROM employee;

-- Functions (Funcoes)
SELECT COUNT(emp_id) FROM employee; -- conta a quantidade de empregados
SELECT COUNT(emp_id) FROM employee WHERE sex = 'F' AND birth_day > '1971-01-01';
SELECT SUM(salary) FROM employee; -- salario pago pra todos funcionarios
SELECT COUNT(sex), sex FROM employee GROUP BY sex; -- quantos homens e mulheres contratados
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id; -- quanto cada vendedor arrecadou

-- Wildcards (Coringas)  (% = qualquer num de caracteres, _ = um caracter)
SELECT * FROM client WHERE client_name LIKE '%LLC'; -- Se termina com LLC
SELECT * FROM branch_supplier WHERE supplier_name LIKE '%Label%'; -- Se tem Label no nome
SELECT first_name, last_name FROM employee WHERE birth_day LIKE '____-06%'; -- quem nasceu em junho

-- Union (Uniao) (1-cada SELECT deve ter o mesmo numero de colunas 2-os dados devem ser de tipos similares)
SELECT supplier_name as nomes_terceiros, branch_id FROM branch_supplier
UNION
SELECT client_name, branch_id FROM client;

-- Joins (Selecionar colunas: LEFT JOIN, RIGHT JOIN, OUTER JOIN, INNER JOIN)
INSERT INTO branch VALUES (4, 'MC_Donald', NULL, NULL);
SELECT * FROM branch;
SELECT employee.emp_id, employee.first_name, branch.branch_name FROM employee
JOIN branch ON employee.emp_id = branch.mgr_id; -- Encontra os administradores de cada branch
-- OBS: JOIN = INNER JOIN (mesma coisa)
SELECT employee.emp_id, employee.first_name, branch.branch_name FROM employee
LEFT JOIN branch ON employee.emp_id = branch.mgr_id; -- Todos os empregados aparecem
SELECT employee.emp_id, employee.first_name, branch.branch_name FROM employee
RIGHT JOIN branch ON employee.emp_id = branch.mgr_id; -- Todas as branches aparecem

-- Nested Queries
SELECT employee.first_name, employee.last_name  -- nomes de quem vendeu mais q 30k 
FROM employee 
WHERE employee.emp_id IN (
	SELECT works_with.emp_id 
	FROM works_with 
	WHERE works_with.total_sales >= 30000) ; 
SELECT client.client_name -- Encontrar todos os clientes administrados pelo Michael
FROM client
WHERE client.branch_id = ( -- branch_id que o manager eh o Michael
	SELECT branch.branch_id
	FROM branch
	WHERE branch.mgr_id = ( -- emp_id que do Michael
		SELECT employee.emp_id
        FROM employee
        WHERE employee.first_name = 'Michael' AND employee.last_name = 'Scott'
        LIMIT 1)
    LIMIT 1);

-- On Delete (SET NULL = valor fica nulo, CASCADE = deleta a linha)
DELETE FROM employee WHERE emp_id = 102;
SELECT * FROM branch; -- mgr_id ficou null, pq setamos ON DELETE SET NULL
SELECT * FROM employee; -- varios super_id ficaram nulo, pelo mesmo motivo
-- (Demitir um cara n significa que vamos demitir os outros)
DELETE FROM branch WHERE branch_id = 2; -- Ao deletar a branch, deleta o supplier
SELECT * FROM branch_supplier; -- As linhas com branch_id=2 sumiram
-- (N precisamos de vendedor pra branch q n existe)

-- Trigger (Gatilho)
CREATE TABLE trigger_test ( -- criei uma tabela de trigger de teste
	message VARCHAR(100));
    
DELIMITER $$ -- mudei pq usei um ; dentro do statement
CREATE -- Criei um trigger: faz algo quando algo acontece
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		INSERT INTO trigger_test VALUES('empregado adicionado com exito');
	END $$
DELIMITER ;

INSERT INTO employee -- adicionamos alg aleatorio de teste
VALUES (109, 'Regazzi', 'Ferreira', '2002-06-03', 'M', 120000, 106, 3);
SELECT * FROM trigger_test; -- a mensagem apareceu

DELIMITER $$
CREATE 
	TRIGGER terceiro_trigger BEFORE INSERT -- pode ser AFTER INSERT, AFTER DELETE, BEFORE DELETE
    ON employee
    FOR EACH ROW BEGIN
		IF NEW.sex ='M' THEN
			INSERT INTO trigger_test VALUES('Pai ta on');
		ELSE
			INSERT INTO trigger_test VALUES('Mae ta on');
		END IF;
	END $$
DELIMITER ;

INSERT INTO employee -- adicionamos alg aleatorio de teste
VALUES (111, 'Carlos', 'Alberto', '1970-02-05', 'F', 9999, 106, 3);
SELECT * FROM trigger_test; -- nome aparece (n apareceu pq antes tava errado)
SELECT * FROM employee;

DROP TRIGGER outro_trigger;