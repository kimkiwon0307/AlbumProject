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

@Controller
@RequestMapping("/album/*")
@Log4j
public class AlbumBoardController {

	private final AlbumBoardService service; // service 의존성 주입

	@Autowired
	public AlbumBoardController(AlbumBoardService service) { // 생성자 주입
		this.service = service;
	}

	// 앨범 리스트 목록
	@GetMapping("/list")
	public void getList(Model model) { // Model 사용

		model.addAttribute("list", service.getList()); // service에서 리스트 가져와서 "list" 이름으로 모델 전달

		/*
		 * List<Long> aNoList = new ArrayList<Long>();
		 * 
		 * 
		 * service.getList().forEach(list -> {
		 * 
		 * aNoList.add(list.getA_no()); });
		 */

	}

	@GetMapping("/register")
	public void register() {

	}

	@PostMapping("/register")
	public String register(@Validated AlbumBoardVO album, BindingResult bindingResult, RedirectAttributes rttr,
			Model model) {

		if (bindingResult.hasErrors()) {

			model.addAttribute("errors", bindingResult.getAllErrors());
			return "/album/register";
		}

		log.info("등록" + album);
		System.out.println(album.toString());
		log.info("============================");
		log.info("register: " + album);

		if (album.getAttachList() != null) {

			album.getAttachList().forEach(attach -> log.info(attach));
		}

		log.info("============================");

		service.insert(album);

		rttr.addFlashAttribute("a_no", album.getA_no());

		return "redirect:/album/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("a_no") Long a_no, Model model) {
		model.addAttribute("a_no", a_no);
		model.addAttribute("album", service.read(a_no));
	}

	@PostMapping("/deleteAlbum")
	public String deleteAlbum(@RequestParam("a_no") Long a_no) {

		service.delete(a_no);

		return "redirect:/album/list";

	}

	@PostMapping("/uploadAjaxAlbum")
	@ResponseBody
	public ResponseEntity<List<AlbumAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile)
			throws IllegalStateException, IOException {

		List<AlbumAttachVO> list = new ArrayList<>();

		String uploadFolder = "C:\\album";

		for (MultipartFile multipartFile : uploadFile) {

			log.info("----------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			AlbumAttachVO attachVO = new AlbumAttachVO();

			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("uploadFileName :" + uploadFileName);

			attachVO.setFileName(uploadFileName);

			// UUID 만들기
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			File saveFile = new File(uploadFolder, uploadFileName);

			multipartFile.transferTo(saveFile);

			attachVO.setUuid(uuid.toString());
			attachVO.setUploadPath(uploadFolder);

			if (checkImageType(saveFile)) {

				attachVO.setFileType(true);

				FileOutputStream thumnail = new FileOutputStream(new File(uploadFolder, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumnail, 100, 100);
				thumnail.close();
			}

			list.add(attachVO);

		}
		return new ResponseEntity<>(list, HttpStatus.OK);
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
