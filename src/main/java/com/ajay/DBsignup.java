package com.ajay;
import java.sql.*;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class DBsignup
 */
@WebServlet("/DBsignup")
public class DBsignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DBsignup() {
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
	 * @throws ClassNotFoundException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void create_boxes(HttpServletRequest request, HttpServletResponse response,String username) throws ServletException, IOException, ClassNotFoundException {
		PrintWriter out=response.getWriter();
		//out.println("function working");
		//System.out.println("fn working"+username);
		JSONArray list=new JSONArray();
		JSONObject obj=new JSONObject();
		Connection con;
		PreparedStatement pst;
		String user_name=username;
		String[] arrOfStr= user_name.split("@");
		System.out.println(arrOfStr[0]);
		ResultSet rs;
		 try {
 			Class.forName("com.mysql.jdbc.Driver");
 			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
 			//String sql="create table "+arrOfStr[0]+" (id int auto_increment PRIMARY KEY,name varchar(20))";
 			//System.out.println(sql);
 			pst=con.prepareStatement("CREATE TABLE "+arrOfStr[0]+"_inbox"+"(ibox_id int PRIMARY KEY AUTO_INCREMENT,user_id varchar(255) default '"+arrOfStr[0]+"',fromm varchar(255),subject varchar(255),message varchar(10240),spam int)");
 			pst.executeUpdate();
 			pst=con.prepareStatement("CREATE TABLE "+arrOfStr[0]+"_sentbox"+"(sbox_id int PRIMARY KEY AUTO_INCREMENT,user_id varchar(255) default '"+arrOfStr[0]+"',too varchar(255),subject varchar(255),message varchar(10240),spam int)");
 			pst.executeUpdate();
 			pst=con.prepareStatement("CREATE TABLE "+arrOfStr[0]+"_spambox"+"(spbox_id int PRIMARY KEY AUTO_INCREMENT,user_id varchar(255) default '"+arrOfStr[0]+"',fromm varchar(255),subject varchar(255),message varchar(10240),spam int)");
 			pst.executeUpdate();
 			pst=con.prepareStatement("CREATE TABLE "+arrOfStr[0]+"_bin"+"(bin_id int PRIMARY KEY AUTO_INCREMENT,user_id varchar(255) default '"+arrOfStr[0]+"',fromm varchar(255),subject varchar(255),message varchar(10240),spam int)");
 			pst.executeUpdate();
 			con.close();
 			//response.sendRedirect(request.getContextPath()+"/index.jsp");
 			
		 }catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		boolean msger=false;
		PrintWriter out=response.getWriter();
		Connection con;
		PreparedStatement pst;
		ResultSet rs;
		JSONArray list=new JSONArray();
		JSONObject obj=new JSONObject();
		String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confpassword=request.getParameter("conf-password");
        if(name.isEmpty() || mobile.isEmpty()||username.isEmpty() || password.isEmpty()	) {
        	System.out.println("Something is empty");
        	String msg="4";
			msger=false;
			obj.put("msg", msg);
			list.add(obj);
			out.println(list.toJSONString());
			out.flush();
        	
        }
        else if(!(username.contains("@swordmail"))){
        	
        	String msg="5";
			msger=false;
			obj.put("msg", msg);
			list.add(obj);
			out.println(list.toJSONString());
			out.flush();
        	
        }
        else if(!(confpassword.equals(password)))
        {
        	String msg="6";
			msger=false;
			obj.put("msg", msg);
			list.add(obj);
			out.println(list.toJSONString());
			out.flush();
        }
        else {
        	

            try {
    			Class.forName("com.mysql.jdbc.Driver");
    			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
    			pst=con.prepareStatement("SELECT user_name from users where user_name=?");
    			pst.setString(1,username);
    			rs=pst.executeQuery();
    			String msg;
    			if(rs.next()) {
    				msg="1";
    				msger=false;
    				obj.put("msg", msg);
    				list.add(obj);
    				out.println(list.toJSONString());
    				out.flush();
    			}
    			else {
    				
    				msg="3";
    				msger=true;
    				obj.put("msg", msg);
    				list.add(obj);
    				out.println(list.toJSONString());
    				out.flush();
    				 if (msger) {
    			        	System.out.println(msger);
    			        	try {
    			        		Class.forName("com.mysql.jdbc.Driver");
    			    			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
    			    			pst=con.prepareStatement("INSERT INTO `users`( `name`, `user_name`, `password`, `mobile`) VALUES (?,?,?,?)");
    			    			pst.setString(1,name);
    			    			pst.setString(2,username);
    			    			pst.setString(3,password);
    			    			pst.setString(4,mobile);
    			    			pst.executeUpdate();
    			    			//String table_data=username+"_inbox";
    			    			//pst=con.prepareStatement("create table fuck (id int primarykey auto_increment,from varchar(255))");
    			    			//pst.setString(1, username);
    			    			//pst.setString(1,domfield+"_"+username+"_"+"inbox");
    			    			//pst.executeUpdate();
    			    			//pst=con.prepareStatement("CREATE TABLE "+"?"+"_"+"sentbox"+"(sbox_id int PRIMARY KEY AUTO_INCREMENT,too varchar(255),subject varchar(255),message varchar(10240),spam int,ham int)");
    			    			//pst.setString(1,domfield+"_"+username+"_"+"inbox");
    			    			//pst.setString(1,username);
    			    			//pst.executeUpdate();
    			    			con.close();
    			    			create_boxes(request,response,username);
    			    			//response.sendRedirect(request.getContextPath()+"/index.jsp");
    			    			
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
    			}
    			catch (ClassNotFoundException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (SQLException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
        	
        	
        }
       // System.out.println(name+mobile+username+password);
        
        
        
        
	}
}
