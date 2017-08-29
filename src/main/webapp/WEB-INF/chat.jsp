<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Gif Chat</title>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/css/materialize.min.css">
	<style>
		.window_height {
			height: 90vh;
			overflow-y: scroll;
		}
	
		.right_align {
			text-align: right;
		}
		
		#form_send, #selected_img {
			display: none;
		}
		
		.input-field input:focus {
		    border-bottom: 1px solid #6a1b9a !important;
		    box-shadow: 0 1px 0 0 #6a1b9a !important;
		}
		
		.input-field input.valid {
		    border-bottom: 1px solid #6a1b9a !important;
		    box-shadow: 0 1px 0 0 #6a1b9a !important;
		}
		
		
		.clicked {
			outline: 10px solid #6a1b9a;
			outline-offset: -10px;
		}
	</style>
</head>
<body>

	<div class="navbar-fixed">
		<nav>
			<div class="nav-wrapper purple darken-3">
				<ul class="left">
					<li>&emsp;Current chat room name: <b><u>${channel}</u></b></li>
				</ul>
				<a class="brand-logo center">
					<i class="material-icons">chat_bubble_outline</i>GIF CHAT<i class="material-icons right">chat_bubble_outline</i>
				</a>
				<ul class="right">
					<li><a href="/" target="_blank">Join a different chat room</a>&emsp;</li>
				</ul>
			</div>
		</nav>
	</div>

	<main>
	
		<div class="container">
		
			<div class="row">
			
				<div class="col s12 m6 window_height" id="chat_side">
					
					<div id="chatroom"></div>
					
					<!-- <h4>Current users:</h4>
					<div id="users"></div> -->
				
				</div>
				
				<div class="col s12 m6 window_height" id="search_side">
					
					<div id="selected_img"></div>
					
					<form id="form_send">
						<input type="hidden" name="message" id="message">
						<button class="btn waves-effect waves-light purple darken-3" type="submit" name="action">Send GIF
							<i class="material-icons left">send</i>
						</button>
					</form>
					
					<h5>Search for GIFs:</h5>
					<form id="form_search">
						<div class="input-field">
							<input type="text" name="search" id="search" placeholder="keywords" class="validate">
						</div>
						<button class="btn waves-effect waves-light purple darken-3" type="submit" name="action">Search
							<i class="material-icons left">search</i>
						</button>
						<button class="btn waves-effect waves-light purple darken-3 right" id="clear_search" name="action">Clear Search
							<i class="material-icons left">clear</i>
						</button>
					</form>
					
					<div id="gifs_search"></div>
					
				</div>
			
			</div> <!-- end row class -->
		
		</div> <!-- end container class -->
	
	</main>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/js/materialize.min.js"></script>
	<script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.0.11.min.js"></script>
	<script>
		$("#form_search").submit(function(e) {
			e.preventDefault();
			if ($("#search").val() !== '') {
				$.ajax({
					url: "http://api.giphy.com/v1/gifs/search?q=" + $("#search").val() + "&api_key=2bc7e94dc18843f6962c623373074584",
					method: "GET",
					success: function(res) {
						$("#gifs_search").html('<h5>Search results (click to select):</h5>');
						for (var i = 0; i < res.data.length; i++) {
							var gifHTML = '<img src=' + res.data[i].images.fixed_width.url + ' id=' + i + '>';
							$("#gifs_search").append(gifHTML);
						}
					}
				});
			}
		});
		
		$(document).on("click", "#gifs_search img", function(e) {
			var clickedImg = $(this);
			$("#gifs_search img").each(function() {
				$(this).removeClass("clicked");
			});
			$(clickedImg).addClass("clicked");
			$("#message").val($(clickedImg).attr("src"));
			$("#selected_img").hide();
			$("#selected_img").html("<h5>Selected GIF:</h5><img src=" + $(clickedImg).attr("src") +"><br><br>");
			$("#selected_img").fadeIn("slow");
			$("#form_send").fadeIn("slow");
			$("#search_side").animate({scrollTop: 0}, 'slow');
		});
		
		$("#clear_search").click(function(e) {
			e.preventDefault();
			$("#message").val('');
			$("#search").val('');
			$("#selected_img").html('');
			$("#form_send").hide();
			$("#gifs_search").html('');
		});
	
		(function() {
			var pubnub = new PubNub({
				subscribeKey: "sub-c-9b8b3bdc-8c2d-11e7-9aaf-aec3d745d57e",
				publishKey: "pub-c-12c52814-fa4c-4c05-b728-0cb150c0c825",
				uuid: '${name}'
			});
			
			pubnub.addListener({
				message: function(m) {
					var gifMessageHTML = '';
					if (m.message.author === '${name}') {
						gifMessageHTML += '<div class="right_align">'
					}
					gifMessageHTML += '<p>' + m.message.author + ' says:</p>';
					gifMessageHTML += '<img src=' + m.message.message + '></div>';
					$("#chatroom").append(gifMessageHTML);
					$('#chat_side').scrollTop($('#chat_side')[0].scrollHeight);
				},
				presence: function(p) {
					console.log(p);
					$("#users").append(p.uuids);
				}
			});
			
			pubnub.subscribe({
				channels: ['${channel}'],
				withPresence: true
			});
			
			pubnub.hereNow({
				channels: ['${channel}'],
				includeUUIDs: true
			});
			
			$("#form_send").submit(function(e) {
				e.preventDefault();
				pubnub.publish({
					channel: '${channel}', 
					message: {
						author: '${name}',
						message: $("#message").val()
					}
				});
			});
		})();
	</script>
	
</body>
</html>