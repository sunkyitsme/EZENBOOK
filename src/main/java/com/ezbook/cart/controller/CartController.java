package com.ezbook.cart.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezbook.cart.service.CartService;
import com.ezbook.cart.vo.CartListVO;
import com.ezbook.cart.vo.CartVO;
import com.ezbook.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

	@Autowired
	private CartService service;
	
	// 카트 리스트
	@GetMapping("/cartList.do")
	public void getCartList(HttpSession session, Model model) throws Exception{
	log.info("getCartList()");
				
	LoginVO login = (LoginVO)session.getAttribute("login");
	String id = login.getId();
				
	List<CartListVO> cartList = service.cartList(id);
				
	model.addAttribute("cartList", cartList);
	}
			
	// 카트 삭제
	@ResponseBody
	@PostMapping("/deleteCart.do")
	public int deleteCart(HttpSession session, @RequestParam(value="chbox[]") List<String> chArr, CartVO cart) throws Exception{
	log.info("deleteCart()");
				
	LoginVO login = (LoginVO)session.getAttribute("login");
	String id = login.getId();
				
	int result = 0;
	int cartNum = 0;
				
	if(login != null) {
	cart.setId(id);
					
		for(String i : chArr) {
			cartNum = Integer.parseInt(i);
			cart.setCartNum(cartNum);
			service.deleteCart(cart);
			}
		result = 1;
		}
	return result;
	}
}