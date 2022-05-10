<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.io.*,java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="java.sql.DriverManager"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">

    <title>Login Form</title>
  </head>
  <body>
  <style>
  .btn-color{
  background-color: #0e1c36;
  color: #fff;
  
}

.profile-image-pic{
  height: 200px;
  width: 200px;
  object-fit: cover;
}



.cardbody-color{
  background-color: #ebf2fa;
}

a{
  text-decoration: none;
}
  </style>
    <div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <h2 class="text-center text-dark mt-5">Sword Mail</h2>
        <div class="text-center mb-5 text-dark">Your New Email Companion</div>
        <div class="card my-5">

          <form  name="frm-login" id="frm-login" class="card-body cardbody-color p-lg-5">

            <div class="text-center">
              <img src="https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397__340.png" class="img-fluid profile-image-pic img-thumbnail rounded-circle my-3"
                width="200px" alt="profile">
            </div>
			<div id="err" style="color:red" class="mb-3">
            
            </div>
            <div class="mb-3">
              <input type="email" class="form-control" name="username" id="username" aria-describedby="emailHelp"
                placeholder="Username"  required>
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="password" id="password" placeholder="password" required>
            </div>
            <div class="text-center" align="center">
            <!--  input type="submit" class="btn btn-color px-5 mb-5 w-100" value="Login"-->
            <button type="button" class="btn btn-primary" onclick="login()">Sign in</button>
            </div>
            <div id="emailHelp" class="form-text text-center mb-5 text-dark">Not
              Registered? <a href="signup.jsp" class="text-dark fw-bold"> Create an
                Account</a>
            </div>
          </form>
        </div>

      </div>
    </div>
  </div>
   
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
  
  var msg=null;
  var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  function inp_val()
  {
	  
  }
  function login(){
	 
	  if($('#username').val()==""){
		  //alert("Username Should'nt be empty !");
		  $('#err').hide().html("Username Should'nt be empty !").fadeIn('slow');
		  
		  $('#username').parent('div').addClass('has-error');
		  return false;
	  }
	  else if($('#password').val()==""){
		  //alert("password Should'nt be empty !");
		  $('#err').hide().html("Password Should'nt be empty !").fadeIn('slow');
		  
		  $('#password').parent('div').addClass('has-error');
		  return false;
	  }
	  var data=$('#frm-login').serialize();
	  $.ajax({
		  type:'POST',
		  url:'DBlogin',
		  data:data,
		  dataType:'JSON',
		  success:function(data){
			 msg=data[0].msg 
			 if(msg==1)
				 {
				 window.location.replace('home.jsp');
				 }
			 else if(msg==3)
				 {
				 $('#err').hide().html("Username or Password  Mismatch").fadeIn('slow');
				 }
		  }
	  });
	  
	  
	  
	  
  }
  
  
  </script>
  
  
  </body>
</html>