package org.galapagos.controller;


import org.galapagos.domain.Reply2VO;
import org.galapagos.domain.ReplyVO;
import org.galapagos.mapper.Reply2Mapper;
import org.galapagos.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/hotissue/{bno}/reply2")
public class Reply2Controller {
	@Autowired
	private Reply2Mapper mapper;

	@PostMapping("")
	public Reply2VO create(@RequestBody Reply2VO vo) {
		mapper.create(vo);
		return mapper.get(vo.getNo());
	}

	@PutMapping("/{no}")
	public Reply2VO update(@PathVariable Long no, @RequestBody Reply2VO vo) {
		System.out.println("==> " + vo);
		mapper.update(vo);
		return mapper.get(vo.getNo());
	}

	@DeleteMapping("/{no}")
	public String delete(@PathVariable Long no) {
		mapper.delete(no);
		return "OK";
	}
}