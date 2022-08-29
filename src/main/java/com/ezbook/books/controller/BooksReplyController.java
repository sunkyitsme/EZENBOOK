package com.ezbook.books.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezbook.books.vo.BooksReplyVO;
import com.ezbook.books.vo.BooksVO;
import com.ezbook.member.vo.LoginVO;
import com.ezbook.books.service.BooksReplyService;
import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/books")
@Log4j
public class BooksReplyController {

		@Autowired
		private BooksReplyService service;
		
		// 댓글 작성
		@PostMapping("/view.do")
		public String registReply(BooksReplyVO reply, BooksVO vo, PageObject pageObject, HttpSession session) throws Exception{
			log.info("registReply()");
			
			// session에 저장해 놓은 아이디를 댓글 작성자에 담는다.
			reply.setId(((LoginVO)session.getAttribute("login")).getId());
			service.registReply(reply);
			return "redirect:view.do?no=" + vo.getNo() + "&page=" + pageObject.getPage() + "&perPageNum=" + pageObject.getPerPageNum() + "&key=" + pageObject.getKey() + "&word="+ URLEncoder.encode(pageObject.getWord(), "utf-8");
		}
		
		// 댓글 삭제
		@PostMapping("/deleteReply.do")
		public String getReplyList(BooksReplyVO reply, BooksVO vo, PageObject pageObject, HttpSession session) throws Exception{
			log.info("postDeletReply()");
			
			reply.setId(((LoginVO)session.getAttribute("login")).getId());
			service.deleteReply(reply);
			return "redirect:view.do?no=" + vo.getNo() + "&page=" + pageObject.getPage() + "&perPageNum=" + pageObject.getPerPageNum() + "&key=" + pageObject.getKey() + "&word="+ URLEncoder.encode(pageObject.getWord(), "utf-8");
		}
}