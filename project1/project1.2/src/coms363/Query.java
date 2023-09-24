package coms363;
import java.sql.*;

public class Query {

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
            ResultSet resultSet = null;
            String sqlQuery = "";
            String outputString = "Query 1: ";

            //query 1
            sqlQuery = "SELECT snum,ssn FROM students where name='Becky';";
            stmt = connect.createStatement();
            resultSet = stmt.executeQuery(sqlQuery);
            while(resultSet.next())
            {
                outputString += "SNUM :"+resultSet.getInt("snum") + "....";
                outputString += "SSN :"+resultSet.getInt("ssn") + "....";
            }
            System.out.println(outputString);

            //query 2
            outputString = "Query 2: ";
            sqlQuery = "select m.name,m.level\n" +
                    "from major m\n" +
                    "where m.snum in (select s.snum\n" +
                    "from students s where s.ssn=123097834);";
            resultSet = stmt.executeQuery(sqlQuery);
            while(resultSet.next())
            {
                outputString += "Name :"+resultSet.getString("name") + "....";
                outputString += "Level :"+resultSet.getString("level") + "....";
            }
            System.out.println(outputString);

            //query 3
            outputString = "Query 3: ";
            sqlQuery = "select c.name from courses c \n" +
                    "where c.department_code in (select d.code from departments d where d.name='Computer Science');";
            resultSet = stmt.executeQuery(sqlQuery);
            while(resultSet.next())
            {
                outputString += "Course Name: "+resultSet.getString("name") + "..\t";
            }
            System.out.println(outputString);

            //query 4
            outputString = "Query 4: ";
            sqlQuery = "select x.name,x.level from degrees x \n" +
                    "where x.department_code in (select d.code from departments d where d.name='Computer Science');";
            resultSet = stmt.executeQuery(sqlQuery);
            while(resultSet.next())
            {
                outputString += "Degree Name: "+resultSet.getString("name") + "....";
                outputString += "Level: "+resultSet.getString("level") + "..\t";
            }
            System.out.println(outputString);

            //query 5
            outputString = "Query 5: ";
            sqlQuery = "select s.name from students s \n" +
                    "where s.snum in (select m.snum from minor m);";
            resultSet = stmt.executeQuery(sqlQuery);
            while(resultSet.next())
            {
                outputString += "Name: "+resultSet.getString("name") + "..\t";
            }
            System.out.println(outputString);

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
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
