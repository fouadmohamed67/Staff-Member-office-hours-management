package ass2;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/register_ajax"})
public class register_Ajax extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:1234/projectWeb";
                String user = "root";
                String password = "1234";
                Connection Con = null;
                Statement Stmt = null;
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                String email = request.getParameter("email");
                ResultSet RS = null;
                String line = "select email from user where email=\""+email+"\";";
                RS = Stmt.executeQuery(line);
                String em="";
                if(RS.first())
                {
                	//em=RS.getString("email");
                	//System.out.print(em);
                    out.print("true");
                   
                }
                else
                {
                    out.print("false");
                }
                Con.close();
            } catch (Exception ex) {
                 out.println("Exception: :(");
            }
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}