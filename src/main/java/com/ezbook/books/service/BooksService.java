package com.ezbook.books.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ezbook.books.vo.ReplyListVO;
import com.ezbook.cart.vo.CartVO;
import com.ezbook.books.mapper.BooksMapper;
import com.ezbook.books.service.BooksService;
import com.ezbook.books.vo.BooksVO;
import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BooksService {

	@Inject
	private BooksMapper mapper;

	// 1. list
	public List<BooksVO> list(PageObject pageObject) throws Exception {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));

		log.info(pageObject);
		return mapper.list(pageObject);

	}

	// 2. view
	public BooksVO view(long no) throws Exception {
		log.info(log);
		return mapper.view(no);
	}

	// 2-1. changeImage
	public int changeImage(BooksVO vo) throws Exception {
		log.info(vo);
		return mapper.changeImage(vo);

	}

	// 3. write
	public int write(BooksVO vo) throws Exception {
		log.info(vo);
		return mapper.write(vo);
	}

	// 4. update
	public int update(BooksVO vo) throws Exception {
		log.info(vo);
		return mapper.update(vo);
	}

	// 5. delete
	public int delete(long no) throws Exception {
		log.info(no);
		return mapper.delete(no);
	}

	// 6. 댓글 리스트
	public List<ReplyListVO> replyList(long no) throws Exception {
		log.info(no);
		return mapper.replyList(no);
	}

	// 7. 장바구니 추가
	public int addCart(CartVO cart) throws Exception {
		log.info(cart);
		return mapper.addCart(cart);
	}
}
