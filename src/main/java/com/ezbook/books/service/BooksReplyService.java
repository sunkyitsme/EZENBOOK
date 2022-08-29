package com.ezbook.books.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;

import com.ezbook.books.vo.BooksReplyVO;
import com.ezbook.books.mapper.BooksReplyMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BooksReplyService {

		@Inject
		private BooksReplyMapper mapper;
		
		// 1. 댓글 작성
		public int registReply(BooksReplyVO reply) throws Exception{
			log.info(reply);
			return mapper.registReply(reply);
		}
		
		// 2. 댓글 삭제
		public int deleteReply(BooksReplyVO reply) throws Exception {
			log.info(reply);
			return mapper.deleteReply(reply);
		}
}