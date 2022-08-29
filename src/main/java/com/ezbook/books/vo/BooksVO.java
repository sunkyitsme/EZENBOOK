package com.ezbook.books.vo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
public class BooksVO {
	private long no, bookStock;
	private String id, bookName, writer, publisher, content, bookPrice, fileName, bookInfo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date publeYear;
	private MultipartFile image;
	private String deleteImage;
}
