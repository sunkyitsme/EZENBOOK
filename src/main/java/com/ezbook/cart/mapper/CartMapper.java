package com.ezbook.cart.mapper;

import java.util.List;

import com.ezbook.cart.vo.CartListVO;
import com.ezbook.cart.vo.CartVO;

public interface CartMapper {

	// 장바구니 리스트
	public List<CartListVO> cartList(String id) throws Exception;
	
	// 장바구니 삭제
	public int deleteCart(CartVO cart) throws Exception;
	
}