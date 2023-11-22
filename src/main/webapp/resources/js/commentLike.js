async function addCommentLike(nickname) { // 닉넴이 아니라 유저의 고유값을 받아야한다~ 왜냐? 
const COMMENT_LIKE_URL = '/api/board/commentlike';	 
	let cno = parseInt($(this).data("no"));
    let commentLike = { cno, nickname };
    console.log(commentLike);

    await rest_create(COMMENT_LIKE_URL + "/add", commentLike);

    let likeCount = $(this).parent().find(".like-count");
    console.log(likeCount);
    let count = parseInt(likeCount.text());
    likeCount.text(count + 1);

    $(this)
        .removeClass('fa-regular')
        .addClass('fa-solid');
        
    

}


async function deleteCommentLike(e) {
const COMMENT_LIKE_URL = '/api/board/commentlike';	
    let cno = parseInt($(this).data("no"));

    await rest_delete( `\${COMMENT_LIKE_URL}/delete?bno=\${bno}&username=\${username}`);

    let likeCount = $(this).parent().find(".like-count");
    console.log(likeCount);
    let count = parseInt(likeCount.text());
    likeCount.text(count - 1);

    $(this)
        .removeClass('fa-solid')
        .addClass('fa-regular');



}