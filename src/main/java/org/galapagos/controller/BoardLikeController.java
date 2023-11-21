package org.galapagos.controller;

import org.galapagos.domain.LikeVO;
import org.galapagos.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/board/like") // 수정: 경로 변경
public class BoardLikeController { // 수정: 클래스명 변경
    @Autowired
    BoardMapper mapper; // 수정: Mapper 클래스명 변경

    @PostMapping("/add") // 수정: 엔드포인트 변경
    public LikeVO addLike(@RequestBody LikeVO like) { // 수정: 클래스명 변경
        mapper.addLike(like); // 수정: 메서드명 변경
        return like;
    }

    @DeleteMapping("/delete") // 수정: 엔드포인트 변경
    public String deleteLike(LikeVO like) { // 수정: 클래스명 변경
        mapper.deleteLike(like); // 수정: 메서드명 변경
        return "OK";
    }
}