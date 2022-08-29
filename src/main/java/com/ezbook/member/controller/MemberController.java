package com.ezbook.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezbook.member.vo.LoginVO;
import com.ezbook.member.vo.MemberVO;
import com.ezbook.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Autowired // 의존성 자동 주입
	private MemberService service;
	
		// 1. 로그인 폼
		@GetMapping("/login.do")
		public String loginForm() throws Exception{
			log.info("login 폼으로 이동");
			return "member/login";
		}
		
		// 1-1. 로그인 처리
		@PostMapping("/login.do")
		public String login(LoginVO inVO, HttpSession session, RedirectAttributes rttr) throws Exception {
			log.info("login 처리 - invo : " + inVO);
			
			LoginVO vo = service.login(inVO);
			if(vo!=null) {
				session.setAttribute("login", vo);
				rttr.addFlashAttribute("msg", "성공적으로 로그인 되었습니다.");
				return "redirect:/main/main.do";
			}else {
				rttr.addFlashAttribute("msg", "아이디 혹은 비밀번호가 일치하지 않습니다.");
				return "redirect:/member/login.do";
			}
		}
		
		// 2. 로그아웃 처리
		@GetMapping("/logout.do")
		public String logout(HttpSession session, RedirectAttributes rttr) throws Exception{
			log.info("logout 처리");
			// 로그아웃 처리 - session의 정보를 지운다.
			session.removeAttribute("login");
			// 로그아웃 알림
			rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
			// main으로 redirect
			return "redirect:/main/main.do";
		}
		
		// 3. 회원가입 폼
		@GetMapping("/write.do")
		public String writeForm() throws Exception {
			return "member/write";
		}
		
		// 3-1. 회원가입 처리
		@PostMapping("/write.do")
		public String write(MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
			
			// 회원 가입 처리
			service.write(vo);
			
			// redirect 하는 페이지에서 한 번만 사용되는 속성값을 전달할 수 있다. → session
			rttr.addFlashAttribute("msg", "성공적으로 회원가입이 되었습니다. \\n로그인 후 이용하세요.");
			return "redirect:/member/login.do";
		}
		
		// 3-1-1. 아이디 중복 체크
		@GetMapping("/idCheck")
		public String idCheck(String id, Model model) throws Exception{
			model.addAttribute("id", service.idCheck(id));
			return "member/idCheck";
		}
		
		// 4. ID 찾기 폼
		@GetMapping("/find_id_form.do")
		public String find_id_form() throws Exception{
			return "member/find_id_form";
		}
		
		// 4-1. ID 찾기 처리
		@PostMapping("/find_id.do")
		public String find_id(HttpServletResponse response, @RequestParam("email") String email, Model model) throws Exception{
			model.addAttribute("id", service.find_id(response, email));
			return "member/find_id";
		}
		
		// 5. 마이페이지
		@GetMapping("/myPage.do")
		public String view(String id, Model model, HttpSession session) throws Exception {
			log.info("view()");
			
			// 세션에 저장돼 있는 로그인 정보를 login 변수에 저장한다.
			LoginVO login = (LoginVO)session.getAttribute("login");
			// 내 정보를 보려면 id를 파라메터로 받아와야 되는데 그 아이디는 login에 담겨져있다.
			id = login.getId();
			MemberVO vo = service.view(id);
			model.addAttribute("vo", vo);
			return "member/myPage";
		}
		
		// 5-1. 회원 정보 수정
		@PostMapping("/update.do")
		public String update(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
			log.info(vo);
			
			// 회원 정보 수정 처리
			service.update(vo);
			// 세션에 저장돼 있는 정보를 지운다.
			session.invalidate();
			rttr.addFlashAttribute("msg", "회원정보가 변경되었습니다. \\n다시 로그인 해주세요.");
			// 정보를 변경했으므로 재로그인 후 이용이 가능하도록 한다.
			return "redirect:/member/login.do";
		}
		
		// 5-2. 회원 탈퇴 폼
		@GetMapping("/delete.do")
		public String delete(String id, Model model, HttpSession session) throws Exception {
			log.info("delete()");
			
			// 세션에 저장돼 있는 로그인 정보를 login 변수에 저장한다.
			LoginVO login = (LoginVO)session.getAttribute("login");
			// 회원 탈퇴를 하려면 id를 파라메터로 받아와야 되는데 그 아이디는 login에 담겨져있다.
			id = login.getId();
			MemberVO vo = service.view(id);
			model.addAttribute("vo", vo);
			return "member/delete";
		}
		
		// 5-2-1. 회원 탈퇴 처리
		@PostMapping("/delete.do")
		public String postDelete(HttpSession session, MemberVO vo, RedirectAttributes rttr) throws Exception {
			log.info("postDelete()");
			
			// 세션에 저장돼 있는 로그인 정보를 login 변수에 저장한다.
			LoginVO login = (LoginVO)session.getAttribute("login");
			
			// 로그인할 때 입력했던 패스워드와 MemberVO에 저장돼 있는 패스워드가 일치하는지 비교한다.
			String oldPass = login.getPw();
			String newPass = vo.getPw();
			
			if((!oldPass.equals(newPass))) {
				rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
				return "redirect:/member/delete.do";
			}
			
			// 회원 탈퇴 처리
			service.delete(vo);
			// 세션에 저장돼 있는 정보를 삭제한다.
			session.invalidate();
			rttr.addFlashAttribute("msg", "정상적으로 회원탈퇴 되었습니다.");
			return "redirect:/main/main.do";
		}
	}