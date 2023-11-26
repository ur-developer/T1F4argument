async function addComment2Like(nickname, btn) { // 닉넴이 아니라 유저의 고유값을 받아야한다~ 왜냐? 
	const COMMENT2_LIKE_URL = '/api/board/comment2like';	 
	let cno = parseInt(btn.data("no"));
    let comment2Like = { cno, username: nickname };
    
    console.log(comment2Like);

    await rest_create(COMMENT2_LIKE_URL + "/add", comment2Like);

    let likeCount = btn.parent().find(".like-count");
    console.log(likeCount);
    let count = parseInt(likeCount.text());
    likeCount.text(count + 1);

    btn
        .removeClass('fa-regular')
        .addClass('fa-solid');
        
    

}


async function deleteComment2Like(nickname, btn) {
	const COMMENT2_LIKE_URL = '/api/board/comment2like';	
    let cno = parseInt(btn.data("no"));
	
	let comment2Like = { cno, username: nickname };
	
    await rest_delete(`${COMMENT2_LIKE_URL}/delete?cno=${cno}&username=${nickname}`);
	
	
	
    let likeCount = btn.parent().find(".like-count");
    console.log(likeCount);
    let count = parseInt(likeCount.text());
    likeCount.text(count - 1);

    btn
        .removeClass('fa-solid')
        .addClass('fa-regular');
}