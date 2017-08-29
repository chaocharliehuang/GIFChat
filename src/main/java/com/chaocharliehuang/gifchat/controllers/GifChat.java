package com.chaocharliehuang.gifchat.controllers;

import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class GifChat {

	@GetMapping("/")
	public String index(@ModelAttribute("errors") String errors, Model model) {
		model.addAttribute("errors", errors);
		return "index.jsp";
	}
	
	@PostMapping("/chat")
	public String setupChat(
			@RequestParam("name") String name, @RequestParam("channel") String channel, 
			RedirectAttributes redirectAttributes, HttpSession session) {
		if (name.length() == 0 || channel.length() == 0) {
			redirectAttributes.addFlashAttribute("errors", "Your name and/or chat room name cannot be blank!");
			return "redirect:/";
		} else if (channel.contains(",") || channel.contains("/") || channel.contains("\\") || 
				channel.contains(".") || channel.contains("*") || channel.contains(":")) {
			redirectAttributes.addFlashAttribute("errors", "Chat room name cannot contain a prohibited character!");
			return "redirect:/";
		}
		session.setAttribute("name", name);
		session.setAttribute("channel", channel);
		return "redirect:/chat";
	}
	
	@GetMapping("/chat")
	public String chat(HttpSession session, Model model) {
		model.addAttribute("name", session.getAttribute("name"));
		model.addAttribute("channel", session.getAttribute("channel"));
		return "chat.jsp";
	}
	
	@GetMapping("/getkeys")
	@ResponseBody
	public String getKeys() throws JSONException {
		JSONObject keys = new JSONObject();
		keys.put("subscribeKey", "sub-c-9b8b3bdc-8c2d-11e7-9aaf-aec3d745d57e");
		keys.put("publishKey", "pub-c-12c52814-fa4c-4c05-b728-0cb150c0c825");
		return keys.toString();
	}
	
}
