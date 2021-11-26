package net.codejava;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class JDBC {

	public static void main(String[] args) {
		String jdbcURL = "jdbc:postgresql://localhost:5432/Estudos";
		String username = "postgres";
		String password = "senha"; // Trocar pela sua senha
		
		Connection connection = null;
		
		try {
			connection = DriverManager.getConnection(jdbcURL, username, password);
			connection.setAutoCommit(false); // Desativei o autocommit
			System.out.println("Conectado com o servidor PostgreSQL\n");
			
			 String deletar = "DELETE FROM funcionario"
					  + " WHERE emp_id = 50";
					
			String inserir = "INSERT INTO funcionario"
					+ " VALUES(50, 'jdbc', 'teste', null, '2021-10-06', 0.00, null, 1001)";
			
			
			Statement statement = connection.createStatement();
			
			// statement.executeUpdate(deletar); // Deleto a tupla que eu ja existe
			
			 int linha = statement.executeUpdate(inserir); // Adiciono novamente a tupla que deletei
			 if (linha > 0) {
				System.out.println("O total de " + linha + " linha(s) foram inseridas\n");
			 }
			
			String select = "SELECT * FROM funcionario ORDER BY emp_id ASC";
			
			ResultSet resultado = statement.executeQuery(select); // Vejo todos os funcionarios
			while (resultado.next()) {
				Integer id = resultado.getInt("emp_id");
				String nome = resultado.getString("emp_name");
				String trabalho = resultado.getString("job_name");
				Integer id_g = resultado.getInt("manager_id");
				Date contratacao = resultado.getDate("hire_date");
				Float salario = resultado.getFloat("salary");
				Float comissao = resultado.getFloat("commission");
				Integer id_departamento = resultado.getInt("dep_id");
				
				// connection.commit(); // Se estiver habilitado, altera a base de dados, caso contrario nao.
				connection.rollback(); // Se estiver habilitado, nao altera a base de dados.
				
				System.out.printf("%d - %s - %s - %d - %s - %.2f - %.2f - %d\n", 
						id, nome, trabalho, id_g, contratacao, salario, comissao, id_departamento);
			}
			
			
		} catch (SQLException e) {
			System.out.println("Erro na Conex�o");
            e.printStackTrace();
		} finally {
			try {
				if (connection != null && !connection.isClosed()) {
					connection.close();
					System.out.println("\nDesconectado do servidor PostgreSQL");
				} 
			} catch (SQLException e) {
                e.printStackTrace();
			}
		}

	}

}
