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

/**
 * Servlet implementation class SentMsg
 */
@WebServlet("/SentMsg")
public class SentMsg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SentMsg() {
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
		//doGet(request, response);
		PrintWriter out=response.getWriter();
		Connection con;
		PreparedStatement pst;
		ResultSet rs;
		JSONArray list=new JSONArray();
		JSONObject obj=new JSONObject();
		String username = request.getParameter("email");
		String subject = request.getParameter("subject");
		String message = request.getParameter("message");
		System.out.println(username+subject+message);
		HttpSession session=request.getSession();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
			pst=con.prepareStatement("SELECT user_name from users where user_name=?");
			pst.setString(1,username);
			rs=pst.executeQuery();
			String sess_user=session.getAttribute("username").toString();
			String[] arrOfStr= username.split("@");
			String user_name=arrOfStr[0]+"_inbox";
			//System.out.println(sess_user);
			if(rs.next()) {
				
				pst=con.prepareStatement("INSERT INTO "+user_name+"( `fromm`, `subject`, `message`, `spam`) VALUES (?,?,?,?)");
				//pst.setString(1, user_name);
				pst.setString(1, sess_user);
				pst.setString(2, subject);
				pst.setString(3, message);
				pst.setString(4, "0");
				pst.executeUpdate();
				String[] arrOfStr2= sess_user.split("@");
				String user_name2=arrOfStr2[0]+"_sentbox";
				System.out.println(user_name2);
				pst=con.prepareStatement("INSERT INTO "+user_name2+"( `too`, `subject`, `message`, `spam`) VALUES (?,?,?,?)");
				//pst.setString(1, user_name);
				pst.setString(1, username);
				pst.setString(2, subject);
				pst.setString(3, message);
				pst.setString(4, "0");
				pst.executeUpdate();
				String msg="1";
				obj.put("msg", msg);
				list.add(obj);
				out.println(list.toJSONString());
				out.flush();
				
				
			}else
			{
				String msg="3";
				obj.put("msg", msg);
				list.add(obj);
				out.println(list.toJSONString());
				out.flush();
			}
		
	}catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		
	}
}
