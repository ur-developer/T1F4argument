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
@RequestMapping("/api/issue/like")
public class BoardLikeController { 
    @Autowired
    BoardMapper mapper; 

    @PostMapping("/add") 
    public LikeVO addLike(@RequestBody LikeVO like) { 
        mapper.addLike(like);
        return like;
    }

    @DeleteMapping("/delete") // 
    public String deleteLike(LikeVO like) { // 
        mapper.deleteLike(like); // 
        return "OK";
    }
}