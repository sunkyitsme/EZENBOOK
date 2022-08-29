package com.ezbook.member.service;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.ezbook.member.mapper.MemberMapper;
import com.ezbook.member.vo.LoginVO;
import com.ezbook.member.vo.MemberVO;

@Service
public class MemberService {
	
	@Inject //의존성 자동 주입
	private MemberMapper mapper;
	
		// 1. 로그인 처리
		public LoginVO login(LoginVO inVO) throws Exception{
			return mapper.login(inVO);
		}
			
		// 2. 회원가입 처리
		public int write(MemberVO vo) throws Exception{
			return mapper.write(vo);
		}
			
		// 3. ID 중복 체크
		public String idCheck(String id) throws Exception{
			return mapper.idCheck(id);
		}
		
		// 4. ID 찾기
		public String find_id(HttpServletResponse response, String email) throws Exception{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			String id = mapper.find_id(email);
			
			if (id == null) {
				out.println("<script>");
				out.println("alert('가입된 아이디가 없습니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			} else {
				return id;
			}
		}
		
		// 5. 마이 페이지
		public MemberVO view(String id) throws Exception {
			return mapper.view(id);
		}
		
		// 5-1. 회원 정보 수정
		public int update(MemberVO vo) throws Exception {
			return mapper.update(vo);
		}
		
		
		// 5-2. 회원 탈퇴
		public int delete(MemberVO vo) throws Exception {
			return mapper.delete(vo);
		}
}