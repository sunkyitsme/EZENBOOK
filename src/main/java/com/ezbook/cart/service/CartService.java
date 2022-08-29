package com.ezbook.cart.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ezbook.cart.vo.CartVO;
import com.ezbook.cart.vo.CartListVO;
import com.ezbook.cart.mapper.CartMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CartService {

		@Inject
		private CartMapper mapper;
		
		// 장바구니 리스트
		public List<CartListVO> cartList(String id) throws Exception{
			log.info(id);
			return mapper.cartList(id);
		}
		
		// 장바구니 삭제
		public int deleteCart(CartVO cart) throws Exception{
			log.info(cart);
			return mapper.deleteCart(cart);
		}
}