package com.ezbook.member.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {
	private String id, pw, name, gender, tel, email, addr1, addr2, addr3, status;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	private Date regDate;
	private int gradeNo;
}