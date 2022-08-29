package com.ezbook.books.mapper;

import com.ezbook.books.vo.BooksReplyVO;

public interface BooksReplyMapper {
	
	// 댓글 작성
	public int registReply(BooksReplyVO reply) throws Exception;
	
	// 댓글 삭제
	public int deleteReply(BooksReplyVO reply) throws Exception;
}