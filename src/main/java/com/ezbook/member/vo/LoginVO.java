package com.ezbook.member.vo;

import lombok.Data;

@Data
public class LoginVO {
	private String id, pw, name, gradeName;
	private int gradeNo;
}