<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.io.*,java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>home page: <%=session.getAttribute("username") %> </title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light" id="sword-home"><h3 id="sword-home">Swordmail</h3></div>
                <div class="list-group list-group-flush">
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="compose"><a>Compose</a></p>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="inbox" ><a>Inbox</a></p>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="sentbox">Sent</a></p>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="spam" hidden>Spam</a></p>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="binner">Bin</a></p>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" onclick="activate()" id="sidebarToggle">AI Mode</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                                <li class="nav-item active"><a class="nav-link" href="home.jsp">Refresh</a></li>
                                <!--  li class="nav-item"><a class="nav-link" href="signup.jsp">Add user</a></li-->
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=session.getAttribute("username") %></a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#!" hidden>AI settings</a>
                                        <a class="dropdown-item" href="signup.jsp">Add user</a>
                                        <a class="dropdown-item" href="#!" hidden>General settings</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="logout.jsp">logout</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
                <div class="container-fluid" id="main-block">
                    <!-- open message -->
                    		<div class="modal-content" id="first_block">
                                      <div class="modal-header">
                                          <h4 class="modal-title">Welcome to Sword Mail</h4>
                                      </div>
                                      <div class="modal-body">
                                              
                                             <p>Your new companion for email services</p>
                                             <ul>
                                             <li>ML based Spam classification</li>
                                             <li>Accurate results with upto 99% Accuracy</li>
                                             <li>Easy to use</li>
                                             </ul>
                                      </div>
                                  </div>
                    
                    <!-- compose_block -->
                   					<div class="modal-content flex" id="compose_block">
                                      <div class="modal-header">
                                      
                                          <h4 class="modal-title">Compose</h4>
                                      </div>
                                      <div class="modal-body" >
                                      
                                      <div id="err" style="color:red"></div>
                                         <form id="frm-sent" method="post">
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">To</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputEmail" name="email" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Subject</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputSubject" name="subject" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Message</label>
                                                  <div class="col-lg-10">
                                                      <textarea rows="10" cols="30" class="form-control" id="inputMessage" name="message"></textarea>
                                                  </div>
                                              </div>

                                              <div class="form-group">
                                                  <div class="col-lg-offset-2 col-lg-10">
                                                      <button class="btn btn-primary px-3 my-3" onclick="send_msg()">Send</button>
                                                  </div>
                                              </div>
                                          </form>
                                      </div>
                                  </div>
                                  <!-- inbox -->
                                  <div class="modal-content px-5" id="inbox_block">
                                      <div class="modal-header">
                                          <h4 class="modal-title">Inbox</h4>
                                          </div>
                                          <div id="i_table">
                                          <table class="table table-hover" id="t_ibox">
                                          <tr onclick="myFunction()">
                                          <th hidden>#</th>
                                          <th>From</th>
                                          <th>Subject</th>
                                          <th>Message</th>
                                         <th class='ai_flag'>Spam / Ham</th>
                                         <!-- th>Action</th-->
                                          </tr>
                                          <%
                                          		String user=session.getAttribute("username").toString();
                                          		//boolean g_flag=true;
                                          		String[] arrOfStr=user.split("@");
                                          		String user_name=arrOfStr[0]+"_inbox";
                                          		Connection con;
                                        		PreparedStatement pst;
                                        		ResultSet rs;
                                         		try{
                                         			Class.forName("com.mysql.jdbc.Driver");
                                        			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
                                        			pst=con.prepareStatement("SELECT * from "+user_name);
                                        			//pst.setString(1,user_name);
                                        			rs=pst.executeQuery();
                                        			while(rs.next()){
                                        				//g_flag=false;
                                        				%>
                                        				<tr class="table-hover my-3" onclick="show_content(this)">
                                        				<td class="mp-3" hidden><%=rs.getString(1) %></td>
                                        				<td><%=rs.getString(3) %></td>
                                        				<td><%=rs.getString(4) %></td>
                                        				<td><%=rs.getString(5) %></td>
                                        				<td class='ai_flag'><%
                                        				String spm=rs.getString(6);
                                        				if(spm.equals("3")){
                                        					out.println("<i class='fa fa-warning' style='font-size:35px;color:blue'></i>");
                                        				}
                                        				else if(spm.equals("1")){
                                        					out.println("<i class='fa fa-warning' style='font-size:35px;color:red'></i>");
                                        				}
                                        				else{
                                        					out.println("<i class='fa fa-check-circle' style='font-size:48px;color:green'></i>");
                                        				}
                                        				%></td>
                                        				<!-- td><button type="button" class="btn btn-success" onclick="spamremover(this)">(-) Spam</button>
<button type="button" class="btn btn-danger">(+) Spam</button></td-->
                                        				</tr>
                                        				<%
                                         		}
                                        			//if(g_flag)
                                        			//{
                                        				//out.println("<div class='modal-header'><h4 class='modal-title'>Nothing to Show :)</h4></div>");
                                        			//}
                                        		
                                        			} 
                                        			catch(ClassNotFoundException e) {
                                        				// TODO Auto-generated catch block
                                        				e.printStackTrace();
                                        			}
                                          %>
                                          </table>
                                      </div>
                                      <div class="modal-body">
                                          <!--  form role="form" class="form-horizontal">
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">To</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputEmail1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Subject</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputPassword1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Message</label>
                                                  <div class="col-lg-10">
                                                      <textarea rows="10" cols="30" class="form-control" id="" name=""></textarea>
                                                  </div>
                                              </div>

                                              <div class="form-group">
                                                  <div class="col-lg-offset-2 col-lg-10">
                                                      <button class="btn btn-primary px-3 my-3" type="submit">Send</button>
                                                  </div>
                                              </div>
                                          </form-->
                                      </div>
                                  </div>
                                  <!-- sentbox -->
                                      <div class="modal-content" id="sentbox_block">
                                      <div class="modal-header">
                                          <h4 class="modal-title">Sent</h4>
                                      </div>
                                      <div id="s_table">
                                      <table class="table table-hover" id="t_sbox">
                                          <tr id="heading">
                                          <th>#</th>
                                          <th>To</th>
                                          <th>Subject</th>
                                          <th>Message</th>
                                          </tr>
                                          <%
                                          		String user2=session.getAttribute("username").toString();
                                          		
                                          		String[] arrOfStr2=user.split("@");
                                          		String user_name2=arrOfStr[0]+"_sentbox";
                                          		//Connection con;
                                        		//PreparedStatement pst;
                                        		//ResultSet rs;
                                         		try{
                                         			Class.forName("com.mysql.jdbc.Driver");
                                        			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
                                        			pst=con.prepareStatement("SELECT * from "+user_name2);
                                        			//pst.setString(1,user_name);
                                        			rs=pst.executeQuery();
                                        			while(rs.next()){
                                        				%>
                                        				<tr  class="table-hover my-3" onclick="show_content(this)">
                                        				<td class="mp-3"><%=rs.getString(1) %></td>
                                        				<td><%=rs.getString(3) %></td>
                                        				<td><%=rs.getString(4) %></td>
                                        				<td><%=rs.getString(5) %></td>
                                        				<%
                                         		}
                                        			
                                        			} 
                                        			catch(ClassNotFoundException e) {
                                        				// TODO Auto-generated catch block
                                        				e.printStackTrace();
                                        			}
                                          %>
                                          </table>
                                          </div>
                                      <div class="modal-body">
                                          <!-- form role="form" class="form-horizontal">
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">To</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputEmail1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Subject</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputPassword1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Message</label>
                                                  <div class="col-lg-10">
                                                      <textarea rows="10" cols="30" class="form-control" id="" name=""></textarea>
                                                  </div>
                                              </div>

                                              <div class="form-group">
                                                  <div class="col-lg-offset-2 col-lg-10">
                                                      <button class="btn btn-primary px-3 my-3" type="submit">Send</button>
                                                  </div>
                                              </div>
                                          </form-->
                                      </div>
                                  </div>
                            <!-- spam -->      
                                      <div class="modal-content" id="spambox_block">
                                      <div class="modal-header">
                                          <h4 class="modal-title">Spambox</h4>
                                      </div>
                                      <div class="modal-body">
                                          <!-- form role="form" class="form-horizontal">
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">To</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputEmail1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Subject</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputPassword1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Message</label>
                                                  <div class="col-lg-10">
                                                      <textarea rows="10" cols="30" class="form-control" id="" name=""></textarea>
                                                  </div>
                                              </div>

                                              <div class="form-group">
                                                  <div class="col-lg-offset-2 col-lg-10">
                                                      <button class="btn btn-primary px-3 my-3" onclick="send_msg()">Send</button>
                                                  </div>
                                              </div>
                                          </form-->
                                      </div>
                                  </div>
                                  
                                  <!-- Bin block -->
                                  
                                  <div class="modal-content px-5" id="d_messages">
                                      <div class="modal-header">
                                          <h4 class="modal-title">Deleted messages</h4>
                                          </div>
                                          <div><button type="button" class="btn btn-danger">Clear Bin</button>
                                          <div id="i_table">
                                          <table class="table table-hover" id="t_jbox">
                                          <tr onclick="myFunction()">
                                          <th>#</th>
                                          <th>From</th>
                                          <th>Subject</th>
                                          <th>Message</th>
                                         <!--  th>Spam / Ham</th-->
                                         <!-- th>Action</th-->
                                          </tr>
                                          <%
                                          		String user_bin=session.getAttribute("username").toString();
                                          		//boolean g_flag=true;
                                          		String[] arrOfStr_bin=user_bin.split("@");
                                          		String user_name_bin=arrOfStr_bin[0]+"_bin";
                                          		//Connection con;
                                        		//PreparedStatement pst;
                                        		//ResultSet rs;
                                         		try{
                                         			Class.forName("com.mysql.jdbc.Driver");
                                        			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/swordmail","root","");
                                        			pst=con.prepareStatement("SELECT * from "+user_name_bin);
                                        			//pst.setString(1,user_name);
                                        			rs=pst.executeQuery();
                                        			while(rs.next()){
                                        				//g_flag=false;
                                        				%>
                                        				<tr class="table-hover my-3" onclick="show_content(this)">
                                        				<td class="mp-3"><%=rs.getString(1) %></td>
                                        				<td><%=rs.getString(3) %></td>
                                        				<td><%=rs.getString(4) %></td>
                                        				<td><%=rs.getString(5) %></td>
                                        				<!-- td><%
                                        				String spm=rs.getString(6);
                                        				if(spm.equals("3")){
                                        					out.println("<i class='fa fa-warning' style='font-size:35px;color:blue'></i>");
                                        				}
                                        				else if(spm.equals("1")){
                                        					out.println("<i class='fa fa-warning' style='font-size:35px;color:red'></i>");
                                        				}
                                        				else{
                                        					out.println("<i class='fa fa-check-circle' style='font-size:48px;color:green'></i>");
                                        				}
                                        				%></td-->
                                        				<!-- td><button type="button" class="btn btn-success" onclick="spamremover(this)">(-) Spam</button>
<button type="button" class="btn btn-danger">(+) Spam</button></td-->
                                        				</tr>
                                        				<%
                                         		}
                                        			//if(g_flag)
                                        			//{
                                        				//out.println("<div class='modal-header'><h4 class='modal-title'>Nothing to Show :)</h4></div>");
                                        			//}
                                        		
                                        			} 
                                        			catch(ClassNotFoundException e) {
                                        				// TODO Auto-generated catch block
                                        				e.printStackTrace();
                                        			}
                                          %>
                                          </table>
                                      </div>
                                      <div class="modal-body">
                                          <!--  form role="form" class="form-horizontal">
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">To</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputEmail1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Subject</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputPassword1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label my-2">Message</label>
                                                  <div class="col-lg-10">
                                                      <textarea rows="10" cols="30" class="form-control" id="" name=""></textarea>
                                                  </div>
                                              </div>

                                              <div class="form-group">
                                                  <div class="col-lg-offset-2 col-lg-10">
                                                      <button class="btn btn-primary px-3 my-3" type="submit">Send</button>
                                                  </div>
                                              </div>
                                          </form-->
                                      </div>
                                  </div>
                                  
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script>
        /*var row=document.getElementById("t_ibox").cells;
        var len=row.length;
        for (let i = 1; i < len; i++) {
        	row.rows[i].id=i.toString();
        	  //alert(i);
        	}
        for (let i = 1; i < len; i++) {
        	console.log(row.rows[i].id);
        	  //alert(i);
        	}*/
        //alert(rows);
        var a=1;
        function activate(){
        	a=a+1
        	if(a%2==1){
        		var toggbutt=document.getElementById('sidebarToggle');
        		toggbutt.style.backgroundColor = "#0D6EFD";
        	var temp=document.getElementsByClassName('ai_flag');
        	for (let i = 0; i < temp.length; i++) {
        		//temp[i].id="temp";
        		document.getElementsByClassName('ai_flag')[i].style.visibility = 'visible';
        	    //console.log(temp[i].id);
        	    
        	}
        	alert("AI Activated")
        	}
        	else
        		{
        		var temp=document.getElementsByClassName('ai_flag');
        		var toggbutt=document.getElementById('sidebarToggle');
        		toggbutt.style.backgroundColor = "#808080";
        		for (let i = 0; i < temp.length; i++) {
            		//temp[i].id="temp";
            		document.getElementsByClassName('ai_flag')[i].style.visibility = 'hidden';
            	    //console.log(temp[i].id);
            	    
            	}
        		alert("AI Deactivated")
        		}
        }
    	var i_tab=document.getElementById('t_ibox');
    	  /*alert("Row index is: " + x.rowIndex);
    	  x.setAttribute('id', x.rowIndex);*/
    	  try{
    		if(i_tab.rows.item(1).innerHTML){
    			console.log(i_tab.rows.item(1).innerHTML);
    		}
    	  }
    	catch(err){
    		i_tab.style.display="none";
    		var empty_msg=document.createElement("div");
    		var e_msg=document.createElement("h2");
    		e_msg.innerHTML="Nothing to show :)";
    		empty_msg.appendChild(e_msg);
    		var i_block=document.getElementById("i_table");
    		i_block.appendChild(empty_msg);	
    			//alert("catched"+err);
    	}
    	
    	var s_tab=document.getElementById('t_sbox');
  	  /*alert("Row index is: " + x.rowIndex);
  	  x.setAttribute('id', x.rowIndex);*/
  	  try{
  		if(s_tab.rows.item(1).innerHTML){
  			console.log(s_tab.rows.item(1).innerHTML);
  		}
  	  }
  	catch(err){
  		s_tab.style.display="none";
  		var empty_msg=document.createElement("div");
  		var e_msg=document.createElement("h2");
  		e_msg.innerHTML="Nothing to show :)";
  		empty_msg.appendChild(e_msg);
  		var i_block=document.getElementById("s_table");
  		i_block.appendChild(empty_msg);	
  			//alert("catched"+err);
  	}
  	
  	
  	var j_tab=document.getElementById('t_jbox');
	  /*alert("Row index is: " + x.rowIndex);
	  x.setAttribute('id', x.rowIndex);*/
	  try{
		if(j_tab.rows.item(1).innerHTML){
			console.log(j_tab.rows.item(1).innerHTML);
		}
	  }
	catch(err){
		j_tab.style.display="none";
		var empty_msg=document.createElement("div");
		var e_msg=document.createElement("h2");
		e_msg.innerHTML="Nothing to show :)";
		empty_msg.appendChild(e_msg);
		var j_block=document.getElementById("j_table");
		//j_block.appendChild(empty_msg);	
			//alert("catched"+err);
	}
        
        /*function myFunction() {
        	alert("myfunworking");
        	var i_tab=document.getElementById('t_ibox');
          	  /*alert("Row index is: " + x.rowIndex);
          	  x.setAttribute('id', x.rowIndex);
          	  try{
          		if(i_tab.rows.item(1).innerHTML){
          			alert(i_tab.rows.item(1).innerHTML);
          		}
          	  }
          	catch(err){
          		i_tab.style.display="none";
          		var empty_msg=document.createElement("div");
          		var e_msg=document.createElement("h2");
          		e_msg.innerHTML="Nothing to show :)";
          		empty_msg.appendChild(e_msg);
          		var i_block=document.getElementById("inbox_block");
          		i_block.appendChild(empty_msg);
          		
          			//alert("catched"+err);
          	}
          }
        */
        function show_content(x){
        	//alert(x.parentNode.parentNode.id)
        	if(x.parentNode.parentNode.id=="t_ibox"){
           	// alert('inbox');
           	 //top layer navigation
           	var inbox_block = document.getElementById("inbox_block");
        	inbox_block.style.display="None";
        	var sent_block=document.getElementById("sentbox_block");
        	sent_block.style.display="None";
        	var main_block=document.getElementById("main-block");
        	//back button
        	var back_butt=document.createElement("BUTTON");
        	back_butt.setAttribute('id','butt_id');
        	back_butt.innerHTML="< Back ";
        	back_butt.setAttribute('class','btn btn-info px-3');
        	main_block.appendChild(back_butt);
        	//spam button
        	var addSpam=document.createElement("BUTTON");
        	addSpam.innerHTML="Mark as Spam ";
        	addSpam.setAttribute('type','submit');
        	addSpam.setAttribute('class','btn btn-danger');
        	main_block.appendChild(addSpam);
        	//remove spam utton
        	var remSpam=document.createElement("BUTTON");
        	remSpam.setAttribute('type','submit');
        	remSpam.innerHTML="Mark as Not Spam ";
        	remSpam.setAttribute('class','btn btn-success');
        	main_block.appendChild(remSpam);
        	
        	//delete spam button
        	var del=document.createElement("BUTTON");
        	del.setAttribute('type','submit');
        	del.innerHTML="Delete ";
        	del.setAttribute('class','btn btn-secondary');
        	main_block.appendChild(del);
        	
        	//msg content
        	
        	var from_div=document.createElement("div");
        	from_div.setAttribute('id','content_div');
        	var from_addr_h=document.createElement("h5");
        	from_addr_h.innerHTML="From:"
        	var from_addr=document.createElement("p");
        	from_addr.setAttribute('class','modal-body');
        	from_addr.innerHTML=x.cells[1].innerHTML;
        	from_addr_h.appendChild(from_addr);
        	
        	var subj=document.createElement("h5");
        	subj.innerHTML="subject:";
        	var sub_content=document.createElement("p");
        	sub_content.setAttribute('class','modal-body');
        	sub_content.innerHTML=x.cells[2].innerHTML;
        	subj.appendChild(sub_content);
        	
        	var msg=document.createElement("h5");
        	msg.innerHTML="Message:"
        	var msg_cont=document.createElement("p");
        	msg_cont.setAttribute('class','modal-body');
        	msg_cont.innerHTML=x.cells[3].innerHTML;
        	msg.appendChild(msg_cont);
        	
        	var classi=document.createElement("h5");
        	classi.innerHTML="Classified as :";
        	var classi_cont=document.createElement("p");
        	classi_cont.setAttribute('class','modal-body');
        	classi_cont.innerHTML=x.cells[4].innerHTML;
    		classi.appendChild(classi_cont);
    		
    		
    		//linking message components
    		from_div.appendChild(from_addr_h);
        	from_div.appendChild(subj);
        	from_div.appendChild(msg);
        	from_div.appendChild(classi);
        	main_block.appendChild(from_div);
    		
    		
    		//back button function
    		
    		back_butt.onclick=function(){
    			inbox_block.style.display="block";
        		from_div.style.display="None";
        		back_butt.style.display="None";
        		addSpam.style.display="None";
        		remSpam.style.display="None";
        		sent_block.style.display="None";
        		del.style.display="none";
    			
    		}
    		
    		//add spam function
    		
				addSpam.onclick=function(){
        		var form1 = document.createElement("form");
        	    form1.setAttribute("method", "post");
        	    form1.setAttribute("action", "spamconverter.jsp");
        	    form1.setAttribute("id", "frm-12");
        	    var helper=1;
        	    var field1= document.createElement("INPUT");
        	    field1.setAttribute("value","<%=session.getAttribute("username")%>");
        	    field1.setAttribute("name","username");
        	    field1.setAttribute("id","username");
        	    //field1.setAttribute("type", "hidden");
        	    
        	    var field2= document.createElement("INPUT");
        	    field2.setAttribute("name","type");
        	    field2.setAttribute("value",helper);
        	    //field2.setAttribute("type", "hidden");
        	    
        	    var field3= document.createElement("INPUT");
        	    field3.setAttribute("name","index");
        	    field3.setAttribute("value",x.cells[0].innerHTML);
        	    //field3.setAttribute("type", "hidden");
        	    //alert(field1.value);
        	    document.body.appendChild(form1);
        	    form1.appendChild(field1);
        	    form1.appendChild(field2);
        	    form1.appendChild(field3);
        	    form1.submit();
    		
        	    
        	
           	}// add spam closes
    		
				remSpam.onclick=function(){
	        		var form1 = document.createElement("form");
	        	    form1.setAttribute("method", "post");
	        	    form1.setAttribute("action", "spamconverter.jsp");
	        	    form1.setAttribute("id", "frm-12");
	        	    var helper=2;
	        	    var field1= document.createElement("INPUT");
	        	    field1.setAttribute("value","<%=session.getAttribute("username")%>");
	        	    field1.setAttribute("name","username");
	        	    field1.setAttribute("id","username");
	        	    //field1.setAttribute("type", "hidden");
	        	    
	        	    var field2= document.createElement("INPUT");
	        	    field2.setAttribute("name","type");
	        	    field2.setAttribute("value",helper);
	        	    //field2.setAttribute("type", "hidden");
	        	    
	        	    var field3= document.createElement("INPUT");
	        	    field3.setAttribute("name","index");
	        	    field3.setAttribute("value",x.cells[0].innerHTML);
	        	    //field3.setAttribute("type", "hidden");
	        	    //alert(field1.value);
	        	    
	        	    
	        	    document.body.appendChild(form1);
	        	    form1.appendChild(field1);
	        	    form1.appendChild(field2);
	        	    form1.appendChild(field3);
	        	    form1.submit();
	    		
	        	    
	        	
	           	}//remove spam ends here
    		del.onclick=function()
    		{
	           		//alert("working");
    			var form1 = document.createElement("form");
        	    form1.setAttribute("method", "post");
        	    form1.setAttribute("action", "spamconverter.jsp");
        	    form1.setAttribute("id", "frm-12");
        	    var helper=3;
        	    var field1= document.createElement("INPUT");
        	    field1.setAttribute("value","<%=session.getAttribute("username")%>");
        	    field1.setAttribute("name","username");
        	    field1.setAttribute("id","username");
        	    //field1.setAttribute("type", "hidden");
        	    
        	    var field2= document.createElement("INPUT");
        	    field2.setAttribute("name","type");
        	    field2.setAttribute("value",helper);
        	    //field2.setAttribute("type", "hidden");
        	    
        	    var field3= document.createElement("INPUT");
        	    field3.setAttribute("name","index");
        	    field3.setAttribute("value",x.cells[0].innerHTML);
        	    //field3.setAttribute("type", "hidden");
        	    //alert(field1.value);
        	    
        	     var field4= document.createElement("INPUT");
        	    field4.setAttribute("name","from_addr");
        	    field4.setAttribute("value",x.cells[1].innerHTML);
        	    
        	    var field5= document.createElement("INPUT");
        	    field5.setAttribute("name","subject");
        	    field5.setAttribute("value",x.cells[2].innerHTML);
        	    
        	    var field6= document.createElement("INPUT");
        	    field6.setAttribute("name","cont");
        	    field6.setAttribute("value",x.cells[3].innerHTML);
        	    
        	    
        	    
        	    document.body.appendChild(form1);
        	    form1.appendChild(field1);
        	    form1.appendChild(field2);
        	    form1.appendChild(field3);
        	    form1.appendChild(field4);
        	    form1.appendChild(field5);
        	    form1.appendChild(field6);
        	    form1.submit();
	           		
    		}
    		}//inbox_closes
    		else if(x.parentNode.parentNode.id=="t_sbox"){
        		//alert("sentbox");
        		var inbox_block = document.getElementById("inbox_block");
            	inbox_block.style.display="None";
            	var sent_block=document.getElementById("sentbox_block");
            	sent_block.style.display="None";
            	var main_block=document.getElementById("main-block");
            	//back button
            	var back_butt=document.createElement("BUTTON");
            	back_butt.setAttribute('id','butt_id');
            	back_butt.innerHTML="< Back ";
            	back_butt.setAttribute('class','btn btn-info px-3');
            	main_block.appendChild(back_butt);
            	
            	var from_div=document.createElement("div");
            	from_div.setAttribute('id','content_div');
            	var from_addr_h=document.createElement("h5");
            	from_addr_h.innerHTML="From:"
            	var from_addr=document.createElement("p");
            	from_addr.setAttribute('class','modal-body');
            	from_addr.innerHTML=x.cells[1].innerHTML;
            	from_addr_h.appendChild(from_addr);
            	
            	var subj=document.createElement("h5");
            	subj.innerHTML="subject:";
            	var sub_content=document.createElement("p");
            	sub_content.setAttribute('class','modal-body');
            	sub_content.innerHTML=x.cells[2].innerHTML;
            	subj.appendChild(sub_content);
            	
            	var msg=document.createElement("h5");
            	msg.innerHTML="Message:"
            	var msg_cont=document.createElement("p");
            	msg_cont.setAttribute('class','modal-body');
            	msg_cont.innerHTML=x.cells[3].innerHTML;
            	msg.appendChild(msg_cont);
            	
            	/*var classi=document.createElement("h5");
            	classi.innerHTML="Classified as :";
            	var classi_cont=document.createElement("p");
            	classi_cont.setAttribute('class','modal-body');
            	classi_cont.innerHTML=x.cells[4].innerHTML;
        		classi.appendChild(classi_cont);*/
        		
        		
        		//linking message components
        		from_div.appendChild(from_addr_h);
            	from_div.appendChild(subj);
            	from_div.appendChild(msg);
            	//from_div.appendChild(classi);
            	main_block.appendChild(from_div);
        		
    		}
        	    
        	}//show content ends here
        	
        	
        	/*var remSpam=document.createElement("BUTTON");
        	remSpam.innerHTML="Mark as Not Spam ";
        	remSpam.setAttribute('class','btn btn-success');
        	main_block.appendChild(remSpam);*/
        	
        	
        	/*var from_div=document.createElement("div");
        	var from_addr_h=document.createElement("h5");
        	from_addr_h.innerHTML="From:"
        	var from_addr=document.createElement("p");
        	from_addr.setAttribute('class','modal-body');
        	from_addr.innerHTML=x.cells[1].innerHTML;
        	from_addr_h.appendChild(from_addr);
        	
        	var subj=document.createElement("h5");
        	subj.innerHTML="subject:";
        	var sub_content=document.createElement("p");
        	sub_content.setAttribute('class','modal-body');
        	sub_content.innerHTML=x.cells[2].innerHTML;
        	subj.appendChild(sub_content);
        	
        	var msg=document.createElement("h5");
        	msg.innerHTML="Message:"
        	var msg_cont=document.createElement("p");
        	msg_cont.setAttribute('class','modal-body');
        	msg_cont.innerHTML=x.cells[3].innerHTML;
        	msg.appendChild(msg_cont);
        	
        	var classi=document.createElement("h5");
        	classi.innerHTML="Classified as :";
        	var classi_cont=document.createElement("p");
        	classi_cont.setAttribute('class','modal-body');*/
        	//alert(x.cells[3].innerHTML);
        	
        	
        	        	
        	
        	//from_div.appendChild(from_addr_h);
        	//from_div.appendChild(subj);
        	//from_div.appendChild(msg);
        	//from_div.appendChild(classi);
        	//main_block.appendChild(from_div);
        	/*back_butt.onclick=function(){
        		if(x.parentNode.parentNode.id=="t_ibox"){
        			//alert("inbox");
        			inbox_block.style.display="block";
            		from_div.style.display="None";
            		back_butt.style.display="None";
            		addSpam.style.display="None";
            		remSpam.style.display="None";
            		sent_block.style.display="None";
        		}
        		
        	if(x.parentNode.parentNode.id=="t_sbox"){
        		//alert("sentbox");
        		sent_block.style.display="block";
        		inbox_block.style.display="None";
        		from_div.style.display="None";
        		back_butt.style.display="None";
        		addSpam.style.display="None";
        		remSpam.style.display="None";
        	}
        		
        		//history.back();
        	}*/
        	
        	//alert();
        	
        //}
        /*function spamadder(x){
        	var data=x;
        	alert("working..");
        	$.ajax({
      		  type:'POST',
      		  url:'Spamupdate',
      		  data:data,
      		  dataType:'JSON',
      		  success:function(data){
      			 msg=data[0].msg 
      			 if(msg==1)
      				 {
      				 alert("one is working");
      				 window.location.replace('index.jsp');
      				 }
      			 else{
      				 alert("failed");
      			 }
      		  }
        }
        )}*/
        function avoider(x){
        //alert(x);	
        	
        }
        
       var i=0;
        var first_block=document.getElementById('first_block');
        var compose_butt=document.getElementById('compose');
        var inbox_butt=document.getElementById('inbox');
        var sent_butt=document.getElementById('sentbox');
        var spam_butt=document.getElementById('spam');
       	var icon_butt=document.getElementById('sword-home');
        var bin_butt=document.getElementById('binner');
        icon_butt.style.cursor="pointer";
        var compose_block = document.getElementById("compose_block");
        var inbox_block = document.getElementById("inbox_block");
        var sentbox_block = document.getElementById("sentbox_block");
        var spambox_block = document.getElementById("spambox_block");
        var d_block=document.getElementById("d_messages");
        //alert(d_block);
        first_block.style.display="none";
		compose_block.style.display="none";
		inbox_block.style.display="block";
		sentbox_block.style.display="none";
		spambox_block.style.display="none";
		d_block.style.display="none";
        compose_butt.onclick=function(){
        	//avoider(this);
        	first_block.style.display="none";
        	compose_block.style.display="block";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	d_block.style.display="none";
        	var temp=document.getElementById('content_div');
        	//alert(temp);
        	temp.style.display="none";
        	var butt_ids=document.getElementById('butt_id');
        	butt_ids.style.display='none';
        	
        }
        inbox_butt.onclick=function(){
        	d_block.style.display="none";
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="block";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	var temp=document.getElementById('content_div');
        	//alert(temp);
        	temp.style.display="none";
        	var butt_ids=document.getElementById('butt_id');
        	butt_ids.style.display='none';
        	
        	
        }
        sent_butt.onclick=function(){
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="block";
        	spambox_block.style.display="none";
        	var temp=document.getElementById('content_div');
        	//alert(temp);
        	d_block.style.display="none";
        	temp.style.display="none";
        	var butt_ids=document.getElementById('butt_id');
        	butt_ids.style.display='none';
        	
        	
        	
        }
        spam_butt.onclick=function(){
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="block";
        	var temp=document.getElementById('content_div');
        	//alert(temp);
        	d_block.style.display="none";
        	temp.style.display="none";
        	var butt_ids=document.getElementById('butt_id');
        	butt_ids.style.display='none';
        	
        	
        }
        
        icon_butt.onclick=function(){
        	first_block.style.display="block";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	var temp=document.getElementById('content_div');
        	//alert(temp);
        	d_block.style.display="none";
        	temp.style.display="none";
        	var butt_ids=document.getElementById('butt_id');
        	butt_ids.style.display='none';
        	
        	
        }
        bin_butt.onclick=function(){
        	//alert('working');
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	var temp=document.getElementById('content_div');
        	//alert(temp);
        	d_block.style.display="block";
        	temp.style.display="none";
        	var butt_ids=document.getElementById('butt_id');
        	butt_ids.style.display='none';
        }
        var msg=null;
        
        function send_msg()
        {
        	/*if(!($('#inputEmail1').val().includes("@swordmail.com")))
        	{
        		return false;
        	}*/
        		console.log(i);
        	var data=$('#frm-sent').serialize();
        	
        	 $.ajax({
       		  type:'POST',
       		  url:'SentMsg',
       		  data:data,
       		  dataType:'JSON',
       		  success:function(data){
       			 msg=data[0].msg 
    			 if(msg==3)
    				 {
    				// i=i-1;
    				 console.log("User not from our domain retry with other email");
    				 alert("User not from our domain,kindly retry with other email");
    				 var errs=document.getElementById('inputEmail');
    				 errs.value="Invalid";
    				 
    				 }
    			 else if(msg==1)
    				 {
    				 console.log(msg);
    				 //$('#err').hide().html("our user").fadeIn('slow');
    				 alert("The Message has been delivered");
    				 window.location.replace('home.jsp');
    				 }
    			 else{
    				 alert("Soemthing went wrong");
    			 }
    		  }
    	  });
       		  
        	//alert("ceee");
        	//console.log("working");
        }
        /* 
        var i=0;
        var compose_butt=document.getElementById('compose');
        var main_block=document.getElementById('main-block');
        
        compose_butt.onclick=function(){
        	i=i+1;
        	var comm_area=document.createElement("div");
        	comm_area.style.height="590px";
        	comm_area.style.width="1100px";
        	comm_area.style.backgroundColor="grey";
        	main_block.appendChild(comm_area);
        	var heading=document.createElement("div");
        	heading.style.height="70px";
        	heading.style.width="1100px";
        	//heading.style.backgroundColor="red";
        	//heading.innerHTML="Compose";
        	var h=document.createElement("h1");
        	h.innerHTML="Compose";
        	heading.appendChild(h);
        	var to_subject=document.createElement("div");
            var to_=document.createElement("div");
            var from_=document.createElement("div");
        	to_subject.style.height="70px";
        	to_subject.style.width="1100px";
        	//to_subject.style.backgroundColor="green";
        	var label=document.createElement("label");
        	label.innerHTML="To";
        	var ip_to=document.createElement("input");
        	ip_to.setAttribute('type','email');
            from_.style.height="70px";
        	from_.style.width="1100px";
        	from_.style.backgroundColor="green";
            var label2=document.createElement("label");
        	label2.innerHTML="Subject";
        	var ip_sub=document.createElement("input");
        	ip_sub.setAttribute('type','input');
        	to_.appendChild(label);
        	to_.appendChild(ip_to);
            from_.appendChild(label2);
            from_.appendChild(ip_sub);
            to_subject.appendChild(to_);
            to_subject.appendChild(from_); 
            var bd=document.createElement("div");
            bd.style.height="140px";
            bd.style.width="1100px";
            bd.style.backgroundColor="yellow";
            var msg_content=document.createElement("input");
            msg_content.setAttribute('type','input');
            bd.appendChild(msg_content);
            var butt=document.createElement("div");
            butt.style.height="70px";
            butt.style.width="1100px";
            butt.style.backgroundColor="blue";
            var buttons=document.createElement("button");
            buttons.setAttribute('value','Send');
            butt.appendChild(buttons);
        	comm_area.appendChild(heading);
        	comm_area.appendChild(to_subject);
        	 comm_area.appendChild(bd);
        	 comm_area.appendChild(butt);
        	//alert("clicked");
        }
        //alert("working");*/
        </script>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <!--  script src="js/scripts.js"></script-->
    </body>
</html>