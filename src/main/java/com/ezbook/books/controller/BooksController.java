package com.ezbook.books.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ezbook.cart.vo.CartVO;
import com.ezbook.books.controller.BooksController;
import com.ezbook.books.service.BooksService;
import com.ezbook.books.vo.BooksVO;
import com.ezbook.books.vo.ReplyListVO;
import com.ezbook.member.vo.LoginVO;
import com.webjjang.util.PageObject;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/books")
@Log4j
public class BooksController {

	@Autowired
	private BooksService service;

	// 1. list
	@GetMapping("/korList.do")
	public String list(@ModelAttribute PageObject pageObject, Model model) throws Exception {
		if (pageObject.getPage() < 1)
			pageObject.setPage(1);

		// perPageNum == 기본값 10을 4로 수정
		if (pageObject.getPerPageNum() == 10)
			pageObject.setPerPageNum(4);

		log.info("korList()");

		model.addAttribute("korList", service.list(pageObject));
		
		return "books/korList";
	}

	// 2. view
	// 처리 결과를 request에 담는 대신, Spring에서는 model에 넣어주면 request에 담기도록 프로그램 돼있다..
	// Parameter로 모델 객체를 전달 받아서 사용한다.
	@GetMapping("/view.do")
	public String view(long no, Model model) throws Exception {
		log.info(no);

		BooksVO vo = service.view(no);
		// 글 내용 중, 줄 바꿈 처리 \n → <br>
		vo.setBookInfo(vo.getBookInfo().replace("\n", "<br>"));
		model.addAttribute("vo", vo);
		List<ReplyListVO> reply = service.replyList(no);
		model.addAttribute("reply", reply);
		return "books/view";
	}

	// 2-1. changeImage
	@PostMapping("/changeImage.do")
	public String changeImage(PageObject pageObject, BooksVO vo, HttpServletRequest request) throws Exception{
		System.out.println("ImageController.changeImage()");
		
		String path = "/upload/books";
		
		// 서버에 파일을 업로드 한다. → DB에 저장할 파일정보가 나온다.
		String fileName = FileUtil.upload(path, vo.getImage(), request);
		vo.setFileName(fileName);
		
		// DB의 파일 정보를 변경한다. → 번호, 파일명 → Controller-Service-Mapper
		service.changeImage(vo);
		
		// 이전의 파일은 지운다.
		FileUtil.remove(FileUtil.getRealPath("", vo.getDeleteImage(), request));
		
		Thread.sleep(500);
		return "redirect:view.do?no=" + vo.getNo() + "&page=" + pageObject.getPage() + "&perPageNum=" + pageObject.getPerPageNum() + "&key=" + pageObject.getKey() + "&word="+ URLEncoder.encode(pageObject.getWord(), "utf-8");
	}


	// 3. writeForm
	@GetMapping("/write.do")
	public String writeForm() throws Exception {
		log.info("writeForm()");
		return "books/write";
	}

	// 3-1. write
	@PostMapping("/write.do")
	public String write(PageObject pageObject, BooksVO vo, HttpSession session, HttpServletRequest request)
			throws Exception {
		log.info(pageObject);

		// 작성자 아이디 세팅
		vo.setId(((LoginVO) session.getAttribute("login")).getId());

		String path = "/upload/books";
		String fileName = FileUtil.upload(path, vo.getImage(), request);
		vo.setFileName(fileName);

		log.info(vo);

		// DB 정보 저장
		service.write(vo);

		return "redirect:korList.do?perPageNum=" + pageObject.getPerPageNum();
	}

	// 4. updateForm
	@GetMapping("/update.do")
	public String updateForm(long no, Model model) throws Exception {
		log.info(no);
		model.addAttribute("vo", service.view(no));
		return "books/update";
	}

	// 4-1. update
	@PostMapping("/update.do")
	public String update(PageObject pageObject, BooksVO vo) throws Exception {
		log.info(vo);
		log.info(pageObject);

		// DB에 수정: Controller - Service - Mapper
		service.update(vo);

		return "redirect:view.do?no=" + vo.getNo() + "&page=" + pageObject.getPage() + "&perPageNum="
				+ pageObject.getPerPageNum() + "&key=" + pageObject.getKey() + "&word="
				+ URLEncoder.encode(pageObject.getWord(), "utf-8");
	}

	// 5. delete
	@GetMapping("/delete.do")
	public String delete(PageObject pageObject, long no, String deleteImage, HttpServletRequest request)
			throws Exception {
		log.info(no);
		log.info(deleteImage);
		log.info(pageObject);

		// DB의 정보를 지운다 - no
		service.delete(no);

		// 서버에서 파일을 지운다. - deleteImage
		FileUtil.remove(FileUtil.getRealPath("", deleteImage, request));

		return "redirect:korList.do?perPageNum=" + pageObject.getPerPageNum();
	}

	// ck 에디터에서 파일 업로드
	@PostMapping("/ckUpload.do")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload)
			// MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하게 된다
			throws Exception {

		// 한글깨짐을 방지하기위해 문자셋 설정
		response.setCharacterEncoding("utf-8");

		// 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
		response.setContentType("text/html; charset=utf-8");

		// 업로드한 파일 이름
		String fileName = upload.getOriginalFilename();

		// 파일을 바이트 배열로 변환
		byte[] bytes = upload.getBytes();

		// 이미지를 업로드할 디렉토리(배포 디렉토리로 설정)
		String uploadPath = "C:\\PHW\\workspace\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\ezbook\\resources\\ckUpload";

		OutputStream out = new FileOutputStream(new File(uploadPath + fileName));

		// 서버로 업로드
		// write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
		// 지정된 바이트를 출력 스트립에 쓴다 (출력하기 위해서)
		out.write(bytes);

		// 클라이언트에 결과 표시
		String callback = request.getParameter("CKEditorFuncNum");

		// 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
		PrintWriter printWriter = response.getWriter();
		String fileUrl = request.getContextPath() + "/ckUpload/" + fileName;
		printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl
				+ "','이미지가 업로드되었습니다.')" + "</script>");
		printWriter.flush();
	}
	
	// 장바구니 추가
	@ResponseBody
	@PostMapping("/addCart.do")
	public int addCart(CartVO cart, HttpSession session) throws Exception{
		log.info("addCart()");
		
		int result = 0;
		
		LoginVO login = (LoginVO)session.getAttribute("login");
		
		if(login != null) {
			cart.setId(login.getId());
			service.addCart(cart);
			result = 1;
		}
		
		return result;
	}
}