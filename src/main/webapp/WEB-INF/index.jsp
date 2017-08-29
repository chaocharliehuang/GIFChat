<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gif Chat</title>
</head>
<body>
	<h1>Chat using only Gifs!</h1>
	<h3>Enter your name and a unique channel name. Share the channel name with your friends, and start chatting!</h3>
	<form action="/chat" method="POST">
		<p>
			<label for="name">Name: </label>
			<input type="text" name="name" id="name">
		</p>
		<p>
			<label for="channel">Channel Name: </label>
			<input type="text" name="channel" id="channel">
			<b>*Prohibited characters:</b> comma (,), slash (/), backslash (\), period (.), asterisk (*), colon (:)
		</p>
		<p>
			<input type="submit" value="Start Chatting!">
		</p>
	</form>
</body>
</html>