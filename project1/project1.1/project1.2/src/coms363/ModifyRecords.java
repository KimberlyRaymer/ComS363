package coms363;
import java.sql.*;

public class ModifyRecords {

    public static Connection connect = null;

    public static void main(String[] args) {

        try {
            //Set up connection parameters
            String userName = "coms363";
            String password = "password";
            String dbServer = "jdbc:mysql://localhost:3306/project1";
            //String dbServer = "jdbc:mysql://mysql.cs.iastate.edu/[schema]";
            //Set up connection
            connect = DriverManager.getConnection(dbServer, userName, password);
            System.out.println("Connection established!");
        } catch (Exception e) {
            System.out.println("Connection failed");
        }

        Statement stmt = null;

        try{
            stmt = connect.createStatement();
            stmt.addBatch("UPDATE students SET name='Scott' where ssn=746897816;");

            stmt.addBatch("UPDATE major SET name='Computer Science', level='MS' where snum in \n " +
                    "(select snum from students where ssn=746897816);");

            stmt.addBatch("SET SQL_SAFE_UPDATES=0;");
            stmt.addBatch("DELETE FROM register where register.regtime='Spring2021';");
            stmt.addBatch("SET SQL_SAFE_UPDATES=1;");


        } catch (SQLException e) {
            e.printStackTrace();
        }

        try{
            stmt.executeBatch();
            System.out.println("Records Modified Successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                // Close connection
                if (stmt != null) {
                    stmt.close();
                }
                if (connect != null) {
                    connect.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
