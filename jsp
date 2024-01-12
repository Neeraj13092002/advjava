<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,javax.servlet.*"%>

<html>
<head>
    <title>CRUD Process</title>
</head>
<body>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/db", "root", "");

        int id = Integer.parseInt((request.getParameter("sid")!="")?request.getParameter("sid"):"0");
        String name = request.getParameter("sname");
        String email = request.getParameter("semail");
        int op = Integer.parseInt(request.getParameter("op"));

        switch (op) {
            case 1:
                // Create operation
                pstmt = conn.prepareStatement("INSERT INTO student (id, name, email) VALUES (?, ?, ?)");
                pstmt.setInt(1, id);
                pstmt.setString(2, name);
                pstmt.setString(3, email);
                pstmt.executeUpdate();
                out.println("Data added successfully");
                break;

            case 2:
                // Read operation
                pstmt = conn.prepareStatement("SELECT * FROM student");
                rs = pstmt.executeQuery();
                out.println("<h2>Read Operation Result:</h2>");
                while (rs.next()) {
                    out.println("ID: " + rs.getInt("id") + "<br>");
                    out.println("Name: " + rs.getString("name") + "<br>");
                    out.println("Email: " + rs.getString("email") + "<br>");
                    out.println("<hr>");
                }
                break;

            case 3:
                // Update operation
                pstmt = conn.prepareStatement("UPDATE student SET name = ?, email = ? WHERE id = ?");
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setInt(3, id);
                pstmt.executeUpdate();
                out.println("Data updated successfully");
                break;

            case 4:
                // Delete operation
                pstmt = conn.prepareStatement("DELETE FROM student WHERE id = ?");
                pstmt.setInt(1, id);
                pstmt.executeUpdate();
                out.println("Data deleted successfully");
                break;
        }
    } catch (Exception e) {
        out.println(e);
    } finally {
        out.print("Hello");
    }
%>

</body>
</html>
