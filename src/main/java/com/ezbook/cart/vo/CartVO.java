package com.ezbook.cart.vo;

import java.util.Date;
import com.ezbook.cart.vo.CartVO;
import lombok.Data;

@Data
public class CartVO {
	private long cartNum, no, cartStock;
	private String id;
	private Date addDate;
}