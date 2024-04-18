package com.pet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pet.domain.AlbumAttachVO;
import com.pet.domain.AlbumBoardVO;
import com.pet.service.AlbumBoardService;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;

@Controller // 컨트롤러 등록
@RequestMapping("/album/*") // 매핑등록
@Log4j 
public class AlbumBoardController {

	private final AlbumBoardService service; // service 의존성 주입

	@Autowired
	public AlbumBoardController(AlbumBoardService service) { // 생성자 주입
		this.service = service;
	}

	// 앨범 리스트
	@GetMapping("/list")
	public void getList(Model model) { // Model 사용

		model.addAttribute("list", service.getList()); // service에서 리스트 가져와서 "list" 이름으로 모델 전달

	}
	
	// 앨범 등록 (get)
	@GetMapping("/register")
	public void register() { // 등록화면 보이기

	}
	
	
	// 앨범 등록 (post)
	@PostMapping("/register")
	public String register(@Validated AlbumBoardVO album, BindingResult bindingResult, RedirectAttributes rttr,Model model) {
		
		// 유효성 검사
		if (bindingResult.hasErrors()) {  // bindingResult가 에러를 가지고 있으면
			model.addAttribute("errors", bindingResult.getAllErrors());  // Model에 "error"로 모든 에러를 넘긴다.
			return "/album/register"; // 그리고 다시 등록화면을 보여준다.
		}

		log.info("등록" + album);               
		log.info("============================");
		log.info("register: " + album);

		if (album.getAttachList() != null) {  // 앨범에 첨부파일 리스트를 가져와서 Null 이 아니면
			album.getAttachList().forEach(attach -> log.info(attach)); // 로그로 찍어라!
		}

		log.info("============================");

		service.insert(album); // 서비스에 insert에 album객체를 저장한다.

		rttr.addFlashAttribute("a_no", album.getA_no()); // 앨범 번호를 넘긴다.

		return "redirect:/album/list"; // 리스트페이지로 redirect 한다.
	}
	
	//조회, 수정 get 방식
	@GetMapping({ "/get", "/modify" }) // 조회, 수정  하나로 묶기
	public void get(@RequestParam("a_no") Long a_no, Model model) { //  매개변수에 a_no 이름의 파라미터를 Long a_no에 넣는다.
		model.addAttribute("a_no", a_no); // Model에 a_no 보낸다.
		model.addAttribute("album", service.read(a_no)); // model로 album이란 이름으로 service.read(a_no)를 보낸다.
	}

	// 삭제 Post방식
	@PostMapping("/deleteAlbum")
	public String deleteAlbum(@RequestParam("a_no") Long a_no) { // 매개변수에 a_no 이름의 파라미터를 Long a_no에 넣는다.
		service.delete(a_no); // service의 delete를 실행할때 a_no를 넘겨준다.
		return "redirect:/album/list"; // 리스트로 리다이렉트한다.
	}
	
	// 앨범 등록 페이지에서 앨범 첨부할때 사용
	@PostMapping("/uploadAjaxAlbum")
	@ResponseBody //HTTP Body 메시지에 직접 반환한다.
	public ResponseEntity<List<AlbumAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) throws IllegalStateException, IOException {
	 // ResponseEntity는 HTTP 응답을 하는 클래스 이고 반환타입으로 앨범 리스트들을 반환한다는거다. 

		List<AlbumAttachVO> list = new ArrayList<>(); // AlbumAttachVO 객체로 List를 만든다.

		String uploadFolder = "C:\\album"; // 업로드 폴더 위치이다.

		for (MultipartFile multipartFile : uploadFile) { // 향상댄 for문 사용 

			log.info("----------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			AlbumAttachVO attachVO = new AlbumAttachVO(); // AlbumAttachVO 객체 생성

			String uploadFileName = multipartFile.getOriginalFilename(); // MultipartFile 객체를 이용해서 원본파일 이름 반환
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // .substring 문자열 추출 , uploadFileName.lastIndexOf("\\") + 1  = ex)C:\image\java.jpg 면 java.jpg 추출
			log.info("uploadFileName :" + uploadFileName);

			attachVO.setFileName(uploadFileName); // attachVO객체에 파일 이름을 저장

	
			UUID uuid = UUID.randomUUID(); 	// UUID 만들기
			uploadFileName = uuid.toString() + "_" + uploadFileName; // 원본 파일 이르미 + UUID

			File saveFile = new File(uploadFolder, uploadFileName); //  "C:\\album", uuid.toString() + "_" + uploadFileName; 

			multipartFile.transferTo(saveFile); // transferTo() 메서드 사용

			attachVO.setUuid(uuid.toString()); // uuid 
			attachVO.setUploadPath(uploadFolder); // uploadPath 

			if (checkImageType(saveFile)) { // 이미지 파일인지 확인

				attachVO.setFileType(true); // 이미지 파일

				FileOutputStream thumnail = new FileOutputStream(new File(uploadFolder, "s_" + uploadFileName)); // 섬네일 만들기
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumnail, 100, 100); 
				thumnail.close();
			}

			list.add(attachVO); // 리스트에 담는다.

		}
		return new ResponseEntity<>(list, HttpStatus.OK); // http body에 보낸다.
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);

		File file = new File(fileName);

		log.info("file: " + file);

		ResponseEntity<byte[]> result = null;

		try {

			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {

			e.printStackTrace();
		}
		return result;
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName) {

		File file;

		try {
			file = new File(URLDecoder.decode(fileName, "UTF-8"));
			log.info("file2: " + file);

			file.delete();

			String largeFileName = file.getAbsolutePath().replace("s_", "");

			log.info("largeFileName: " + largeFileName);

			file = new File(largeFileName);

			file.delete();

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("delete", HttpStatus.OK);

	}

	@GetMapping("/getAttachList")
	@ResponseBody
	public ResponseEntity<List<AlbumAttachVO>> getAttachList(Long a_no) {

		return new ResponseEntity<>(service.getAttachList(a_no), HttpStatus.OK);
	}

	private boolean checkImageType(File file) {
		String contentType;

		try {
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

}
