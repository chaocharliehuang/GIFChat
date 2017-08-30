<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>GIF Chat</title>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/css/materialize.min.css">
    <style>
		body {
		    display: flex;
		    min-height: 100vh;
		    flex-direction: column;
		}
		
		main {
		    flex: 1 0 auto;
		}
    
    		#name, #channel {
    			width: 50%;
    			text-align: center;
    		}
    
		.input-field input:focus {
		    border-bottom: 1px solid #6a1b9a !important;
		    box-shadow: 0 1px 0 0 #6a1b9a !important;
		}
		
		.input-field input.valid {
		    border-bottom: 1px solid #6a1b9a !important;
		    box-shadow: 0 1px 0 0 #6a1b9a !important;
		}
		
		footer {
			margin-top: 20px;
			padding: 5px;
			color: white;
		}
	</style>
</head>
<body>
	<div class="navbar-fixed">
		<nav>
			<div class="nav-wrapper purple darken-3">
				<a class="brand-logo center">
					<i class="material-icons">chat_bubble_outline</i>GIF CHAT<i class="material-icons right">chat_bubble_outline</i>
				</a>
			</div>
		</nav>
	</div>
	
	<main>
	
		<div class="container center">

			<h5>Chat using only GIFs!</h5>
			<p>Enter your name and a unique chat room name.</p>
			<p>Share the chat room name with your friends and start chatting!</p>
			
			<c:if test="${!empty errors}">
				<p style="color:red;"><b>${errors}</b></p>
			</c:if>
			
			<form action="/chat" method="POST">
				<div class="row">
					<div class="input-field">
						<input type="text" name="name" id="name" placeholder="Your Name">
					</div>
				</div>
				<div class="row">
					<div class="input-field">
						<input type="text" name="channel" id="channel" placeholder="Chat Room Name">
						<br>
						<b>*Prohibited characters in chat room name:</b>
						<br>
						comma ( , ), slash ( / ), backslash ( \ ), period ( . ), asterisk ( * ), colon ( : )
					</div>
				</div>
				<button class="btn waves-effect waves-light purple darken-3" type="submit" name="action">
					Join chat room!
				</button>
			</form>
	
		</div>
	
	</main>
	
	<footer class="page_footer purple darken-3">
	    <div class="center">
	        <p>&copy; 2017 <a href="http://github.com/chaocharliehuang" target="_blank">Chao Charlie Huang</a> | Built using Spring Boot, PubNub API, GIPHY API, and Materialize CSS</p>
	    </div>
	</footer>
	
</body>
</html>