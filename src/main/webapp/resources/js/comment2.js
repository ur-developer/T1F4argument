//같이 보여줄 답글 버튼
const reply2Addable = `
<button class="btn btn-light btn-sm reply2-add-show-btn">
<i class="fa-solid fa-pen-to-square"></i> 답글
</button>
`;
//답글 버튼 구성
const comment2Updatable = `
	<button class="btn btn-light btn-sm comment2-update-show-btn">
		<i class="fa-solid fa-pen-to-square"></i> 수정
	</button>
	<button class="btn btn-light btn-sm comment2-delete-btn">
		<i class="fa-solid fa-times"></i> 삭제
	</button>
	<button class="btn btn-light btn-sm reply2-add-show-btn">
		<i class="fa-solid fa-pen-to-square"></i> 답글
	</button>
	
`;

//댓글 생성 하기 화면
function createComment2Template(comment2, nickname) {
	console.log(comment2, comment2.nickname, comment2.content)
	console.log(nickname)
	
	return `
	<div class="comment2 my-3" data-no="${comment2.no}" data-nickname = "${comment2.nickname}">
		<div class="comment2-title my-2 d-flex justify-content-between">
			<div >
				<strong class="nickname">
					${comment2.nickname}
         		</strong>
				<span class="text-muted ms-3 comment2-date">
					${moment(comment2.registerDate).format('YYYY-MM-DD hh:mm')}
				</span>
			</div>
			
			<div  class="btn-group">
			${nickname && (nickname == comment2.nickname) ? comment2Updatable : ''} 
			${nickname && (nickname != comment2.nickname) ? reply2Addable : ''}      		
			</div>
		</div> 
		<div class="comment2-body">
			<div class="comment2-content">${comment2.content}</div>
		</div>
		<span class="like">
				<i class="${ comment2.myLike ? 'fa-solid' : 'fa-regular' } fa-thumbs-up text-danger"
		data-no="${comment2.no}"></i>
				<span class="like-count">${comment2.likeCount}</span>
			</span>
		<div class="reply2-list ml-5">
		<!-- 답글 목록 출력 영역 -->
		</div>
	</div>
	`;
}

//댓글 목록 불러오기
async function loadComments2(bno, nickname) {
	let comments2 = [];
	
	
	// API로 불러오기
	console.log(COMMENT2_URL);
	comments2 = await rest_get(COMMENT2_URL);

	for(let comment2 of comments2) {
		console.log(comment2);
		const comment2El = $(createComment2Template(comment2, nickname));
		$('.comment2-list').append(comment2El);
		
		let reply2ListEl = comment2El.find('.reply2-list');
		// 답글 목록 처리
		for(let reply2 of comment2.reply2List) {
			let reply2El = $(createReply2Template(reply2, nickname));
			reply2ListEl.append(reply2El);

		};
	}


	
}




window.addEventListener("scroll", function () {
  const SCROLLED_HEIGHT = window.scrollY;
  const WINDOW_HEIGHT = window.innerHeight;
  const DOC_TOTAL_HEIGHT = document.body.offsetHeight;
  const IS_BOTTOM = WINDOW_HEIGHT + SCROLLED_HEIGHT === DOC_TOTAL_HEIGHT;
 
  if (IS_BOTTOM && !isFetching) {
    loadComments2();
  }
});

// 댓글 입력 가이드 이벤트 처리

async function createComment2(bno, nickname) {
	const content = $('.new-comment2-content').val();
	console.log(content);
	
	if(!content) {
		alert('내용을 입력하세요.');
		$('.new-comment2-content').focus();
		return;
	}
	
	if(!confirm('댓글을 추가할까요?')) return;
	let comment2  = { bno, nickname , content }
	console.log(comment2);
	
	// REST로 등록
	comment2 = await rest_create(COMMENT2_URL, comment2);
		

	// 등록 성공 후 DOM 처리
	const comment2El = createComment2Template(comment2, nickname);
	$('.comment2-list').prepend($(comment2El));	
	$('.new-comment2-content').val('');
		
	location.reload(true);
}

//댓글 수정 입력칸 만들기
function createComment2EditTemplate(comment2) {
	return `
		<div class="bg-light p-2 rounded comment2-edit-block">
			<textarea class="form-control mb-1 comment2-editor"
				>${comment2.content}</textarea>
			<div class="text-end">
				<button onClick="window.location.reload()" class="btn btn-light btn-sm py-1 comment2-update-btn">
					<i class="fa-solid fa-check"></i> 확인</button>
				<button class="btn btn-light btn-sm  py-1 comment2-update-cancel-btn">
					<i class="fa-solid fa-undo"></i> 최소</button>
			</div>
		</div>
	`;
}

//댓글 수정 화면 보여주기
//
function showUpdateComment2(e) {
	const comment2El = $(this).closest('.comment2');
	const no = comment2El.data("no");
	
	const contentEl = comment2El.find('.comment2-content');
	const comment2 = { no, content: contentEl.html().trim() };
	
	console.log(comment2);
	
	contentEl.hide();
	comment2El.find('.btn-group').hide();
	
	
	const template = createComment2EditTemplate(comment2);
	const el = $(template);	
	comment2El.find('.comment2-body').append(el);
	
}




// 댓글 수정 처리하기
async function updateComment2(comment2El, nickname) {
	if(!confirm('수정할까요?')) return;

	const editContentEl = comment2El.find('.comment2-edit-block');	// 수정 창 
	const content = editContentEl.find('.comment2-editor').val();	// 수정 내용
	const no = parseInt(comment2El.data("no"));
	let comment2 = { no, nickname,	content };
	
	
	comment2 = await rest_modify(COMMENT2_URL + comment2.no, comment2);
	console.log('수정', comment2);	
		
	const contentEl = comment2El.find('.comment2-content')	
	editContentEl.remove();
	contentEl.html(comment2.content);	// 변경된 내용으로 화면 내용 수정
	contentEl.show();	
	
	comment2El.find('.btn-group').show();
}


// 댓글 수정 취소 처리
function cancelComment2Update(e) {
	const comment2El = $(this).closest('.comment2');
	comment2El.find('.comment2-content').show();
			//.css('display', 'block');
	
	comment2El.find('.comment2-edit-block').remove();
	comment2El.find('.btn-group').show();
}



// 댓글 삭제
async function deleteComment2(e) {
	if(!confirm('댓글을 삭제할까요?')) return;
	
	const comment2 = $(this).closest('.comment2')
	const no = comment2.data("no");	

	await rest_delete(COMMENT2_URL + no);
		
	// api 호출	
	comment2.remove();

}

