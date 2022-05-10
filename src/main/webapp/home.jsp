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
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="compose">Compose</a>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="inbox" >Inbox</p>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="sentbox">Sentbox</a>
                    <p class="list-group-item list-group-item-action list-group-item-light p-2" id="spam">Spambox</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle">AI Mode</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                                <li class="nav-item active"><a class="nav-link" href="home.jsp">Refresh</a></li>
                                <li class="nav-item"><a class="nav-link" href="signup.jsp">Add user</a></li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=session.getAttribute("username") %></a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#!">AI settings</a>
                                        <a class="dropdown-item" href="#!">General settings</a>
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
                                              
                                             <p>List our features</p>
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
                                  <div class="modal-content" id="inbox_block">
                                      <div class="modal-header">
                                          <h4 class="modal-title">Inbox</h4>
                                          </div>
                                          <div id="i_table">
                                          <table class="table table-hover" id="t_ibox">
                                          <tr>
                                          <th>#</th>
                                          <th>From</th>
                                          <th>Subject</th>
                                          <th>Message</th>
                                         <th>Spam</th>
                                         <th>Action</th>
                                          </tr>
                                          <%
                                          		String user=session.getAttribute("username").toString();
                                          		
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
                                        				%>
                                        				<tr class="table-hover my-3" onclick="myFunction(this)">
                                        				<td class="mp-3"><%=rs.getString(1) %></td>
                                        				<td><%=rs.getString(3) %></td>
                                        				<td><%=rs.getString(4) %></td>
                                        				<td><%=rs.getString(5) %></td>
                                        				<td><%=rs.getString(6) %></td>
                                        				<td><button type="button" class="btn btn-success">(-) Spam</button>
<button type="button" class="btn btn-danger">(+) Spam</button></td>
                                        				</tr>
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
                                          <h4 class="modal-title">Sentbox</h4>
                                      </div>
                                      <div id="s_table">
                                      <table class="table table-hover">
                                          <tr>
                                          <th>#</th>
                                          <th>To</th>
                                          <th>Subject</th>
                                          <th>Message</th>
                                         <th>Spam</th>
                                         <th>Action</th>
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
                                        				<tr  class="table-hover my-3" ">
                                        				<td class="mp-3"><%=rs.getString(1) %></td>
                                        				<td><%=rs.getString(3) %></td>
                                        				<td><%=rs.getString(4) %></td>
                                        				<td><%=rs.getString(5) %></td>
                                        				<td><%=rs.getString(6) %></td>
                                        				<td><button type="button" class="btn btn-success">(-) Spam</button>
															<button type="button" class="btn btn-danger">(+) Spam</button></td>
                                        				</tr>
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
        
        function myFunction(x) {
          	  alert("Row index is: " + x.rowIndex);
          	  x.setAttribute('id', x.rowIndex);
          	  alert(x.id);
          }
       var i=0;
        var first_block=document.getElementById('first_block');
        var compose_butt=document.getElementById('compose');
        var inbox_butt=document.getElementById('inbox');
        var sent_butt=document.getElementById('sentbox');
        var spam_butt=document.getElementById('spam');
        var icon_butt=document.getElementById('sword-home');
        icon_butt.style.cursor="pointer";
        var compose_block = document.getElementById("compose_block");
        var inbox_block = document.getElementById("inbox_block");
        var sentbox_block = document.getElementById("sentbox_block");
        var spambox_block = document.getElementById("spambox_block");
        
        first_block.style.display="none";
		compose_block.style.display="none";
		inbox_block.style.display="block";
		sentbox_block.style.display="none";
		spambox_block.style.display="none";
        compose_butt.onclick=function(){
        	first_block.style.display="none";
        	compose_block.style.display="block";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	
        }
        inbox_butt.onclick=function(){
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="block";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	
        }
        sent_butt.onclick=function(){
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="block";
        	spambox_block.style.display="none";
        	
        }
        spam_butt.onclick=function(){
        	first_block.style.display="none";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="block";
        	
        }
        icon_butt.onclick=function(){
        	first_block.style.display="block";
        	compose_block.style.display="none";
        	inbox_block.style.display="none";
        	sentbox_block.style.display="none";
        	spambox_block.style.display="none";
        	
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