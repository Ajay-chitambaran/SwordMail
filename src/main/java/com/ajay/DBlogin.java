package com.ajay;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mysql.cj.xdevapi.Statement;

/**
 * Servlet implementation class DBlogin
 */
@WebServlet("/DBlogin")
public class DBlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DBlogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		Connection con;
		PreparedStatement pst;
		ResultSet rs;
		JSONArray list=new JSONArray();
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        JSONObject obj=new JSONObject();
        
        try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
			pst=con.prepareStatement("select user_id,user_name,password from users where user_name=? and password=? ");
			pst.setString(1,username);
			pst.setString(2, password);
			rs=pst.executeQuery();
			String msg;
			HttpSession session=request.getSession();
			if(rs.next()) {
				
				session.setAttribute("username",username);
				session.setAttribute("password",password);
				msg="1";
				obj.put("msg", msg);
				list.add(obj);
				out.println(list.toJSONString());
				out.flush();
			}
			else {
		
			msg="3";
			obj.put("msg", msg);
			list.add(obj);
			out.println(list.toJSONString());
			out.flush();
			
			} 
        }	
			catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
}
}
