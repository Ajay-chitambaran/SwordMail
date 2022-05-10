<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">

    <title>Sign up Form</title>
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
        <h2 class="text-center text-dark mt-5">Sword Mail - Sign Up</h2>
        <div class="text-center mb-5 text-dark">Your New Email Companion</div>
        <div class="card my-5">

          <form  name="frm-signup" id="frm-signup" class="card-body cardbody-color p-lg-5">

            
			<div id="err" style="color:red" class="mb-3">
            
            </div>
            <div class="mb-3">
              <input type="text" class="form-control" name="name" id="name" aria-describedby="emailHelp"
                placeholder="Name"  required>
            </div>
            <div class="mb-3">
              <input type="phone" class="form-control" name="mobile" id="mobile" aria-describedby="emailHelp"
                placeholder="Mobile"  required>
            </div>
            <div class="mb-3">
              <input type="email" class="form-control" name="username" id="username" aria-describedby="emailHelp"
                placeholder="Username"  required>
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="password" id="password" placeholder="password" required>
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="conf-password" id="conf-password" placeholder="Confirm password" required>
            </div>
            <div class="text-center" align="center">
            <!--  input type="submit" class="btn btn-color px-5 mb-5 w-100" value="Login"-->
            <button type="button" class="btn btn-primary" onclick="signup()">Sign Up</button>
            </div>
            <div id="emailHelp" class="form-text text-center mb-5 text-dark">Already
              Registered? <a href="index.jsp" class="text-dark fw-bold">
              Login</a>
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
  function signup()
  {
	  
	  if($('#name').val()=="" || $('#mobile').val()==""  || $('#username').val()==""  || $('#password').val()=="" || $('#conf-password').val()=="")
		  {
		  //var temp;
		  $('#err').hide().html("Some fields cannot be  empty").fadeIn('slow');
		//alert('signup working');
		  }
	  var data=$('#frm-signup').serialize();
	  $.ajax({
		  type:'POST',
		  url:'DBsignup',
		  data:data,
		  dataType:'JSON',
		  success:function(data){
			 msg=data[0].msg 
			 if(msg==1)
				 {
				 $('#err').hide().html("Username already used").fadeIn('slow');
				 window.setTimeout( function() {
					  window.location.reload();
					}, 3000);
				 //
				 }
			 else if(msg==3)
				 {
				 alert("inserted successfully");
				 window.location.replace('index.jsp');
				 //$('#err').hide().html("Username or Password  Mismatch").fadeIn('slow');
				 }
			 else if(msg==4)
			 {
			 alert("some fields are empty");
			// window.location.replace('index.jsp');
			 $('#err').hide().html("Some fields cannot be empty").fadeIn('slow');
			 window.setTimeout( function() {
				  window.location.reload();
				}, 3000);
			 }
			 else if(msg==5)
			 {	
			 alert("Invalid email use swordmail");
			// window.location.replace('index.jsp');
			 $('#err').hide().html("Not a valid email use swordmail").fadeIn('slow');
			 
			 window.setTimeout( function() {
				  window.location.reload();
				}, 3000);
			 }
			 else if(msg==6)
			 {
			 alert("Password fields not a match");
			// window.location.replace('index.jsp');
			 $('#err').hide().html("Password fields are not the same !").fadeIn('slow');
			 window.setTimeout( function() {
				  window.location.reload();
				}, 3000);
			 }
			 else if(msg==7)
			 {
			 alert("user created successfully");
			// window.location.replace('index.jsp');
			 window.location.replace('index.jsp');
			 }
		  }
	  });
  }
 /*
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
	  
	  
	
	  
  }*/  
  
  
  </script>
  
  
  </body>
</html>