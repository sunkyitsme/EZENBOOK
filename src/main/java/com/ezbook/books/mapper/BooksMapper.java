package com.ezbook.books.mapper;

import java.util.List;

import com.ezbook.books.vo.ReplyListVO;
import com.ezbook.cart.vo.CartVO;
import com.ezbook.books.vo.BooksVO;
import com.webjjang.util.PageObject;

public interface BooksMapper {

	// 1. 리스트
		public List<BooksVO> list(PageObject pageObject) throws Exception;
		
		// 1-1. 전체 데이터 개수
		public long getTotalRow(PageObject pageObject) throws Exception;

		// 2. 글보기
		public BooksVO view(long no) throws Exception;

		// 2-1. 이미지 변경
		public int changeImage(BooksVO vo) throws Exception;
		
		// 3. 글쓰기
		public int write(BooksVO vo) throws Exception;
		
		// 4. 글수정
		public int update(BooksVO vo) throws Exception;
		
		// 5. 글삭제
		public int delete(long no) throws Exception;
		
		// 6. 댓글 리스트
		public List<ReplyListVO> replyList(long no) throws Exception;
		
		// 7. 장바구니 추가
		public int addCart(CartVO cart) throws Exception;
}