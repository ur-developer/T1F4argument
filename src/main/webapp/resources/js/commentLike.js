async function addCommentLike(nickname, btn) { // 닉넴이 아니라 유저의 고유값을 받아야한다~ 왜냐? 
	const COMMENT_LIKE_URL = '/api/hotissue/commentlike';	 
	let cno = parseInt(btn.data("no"));
    let commentLike = { cno, username: nickname };
    
    console.log(commentLike);

    await rest_create(COMMENT_LIKE_URL + "/add", commentLike);

    let likeCount = btn.parent().find(".like-count");
    console.log(likeCount);
    let count = parseInt(likeCount.text());
    likeCount.text(count + 1);

    btn
        .removeClass('fa-regular')
        .addClass('fa-solid');
        
    

}


async function deleteCommentLike(nickname, btn) {
	const COMMENT_LIKE_URL = '/api/hotissue/commentlike';	
    let cno = parseInt(btn.data("no"));
	
	let commentLike = { cno, username: nickname };
	
    await rest_delete(`${COMMENT_LIKE_URL}/delete?cno=${cno}&username=${nickname}`);
	
	
	
    let likeCount = btn.parent().find(".like-count");
    console.log(likeCount);
    let count = parseInt(likeCount.text());
    likeCount.text(count - 1);

    btn
        .removeClass('fa-solid')
        .addClass('fa-regular');



}