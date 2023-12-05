//답글 버튼 관리
const reply2Updatable = `
	<button class="btn btn-light btn-sm reply2-update-show-btn">
		<i class="fa-solid fa-pen-to-square"></i> 수정
	</button>
	<button class="btn btn-light btn-sm reply2-delete-btn">
		<i class="fa-solid fa-times"></i> 삭제
	</button>
`;

//답글 생성
function createReply2Template(reply2, nickname) {
	console.log(reply2, reply2.nickname, reply2.content)
	console.log(nickname)
	return `
	
		<div class="reply2 my-3" 
		data-no="${reply2.no}" 
		data-nickname="${reply2.nickname}">
			<div class="reply2-title my-2 d-flex justify-content-between">
				<div class="reply2-head">
					<strong class="reply2-nickname">
						<i class="fa-regular fa-comment-dots"></i>
						${reply2.nickname}
					</strong>
					<span class="text-muted ml-3 reply2-date">
						${moment(reply2.registerDate).format('hh:mm')}
					</span>
				</div>
				
				<div class="btn-group">
					${nickname && (nickname == reply2.nickname) ? reply2Updatable : ''} 
				</div>
			</div>
			<div class="reply2-body">
				<div class="reply2-content">${ reply2.content || '' }</div>
			</div>
		</div>
	`;
}


//답글 입력칸 생성
function createReply2EditTemplate(reply2) {
	return `
		<div class="bg-light p-2 rounded reply2-edit-block" 
			data-no = "${reply2.no}"
			data-cno="${reply2.cno}" 
			data-nickname="${reply2.nickname}">
				
			<div>${reply2.no ? '' : ' 답글 작성'}</div>
				
				<textarea class="form-control mb-1 reply2-editor">${reply2.content || '' }</textarea>
				
				<div class="text-end">
					<button onClick="window.location.reload()" class="btn btn-light btn-sm py-1 
						${reply2.no ? 'reply2-update' : 'reply2-add-btn'} ">
						<i class="fa-solid fa-check"></i> 확인
					</button>
						
					<button class="btn btn-light btn-sm py-1 
						${reply2.no ? 'reply2-update-cancel' : 'reply2-add-cancel-btn'} ">
						<i class="fa-solid fa-undo"></i> 취소
					</button>
			</div>
		</div>
	`;
}

//답글 화면에 보여주기
function showReply2Add(el, nickname) {
	const comment2El = el.closest('.comment2');
	const cno = comment2El.data("no");
	const reply2 = { cno, nickname };
	const template = createReply2EditTemplate(reply2);

	comment2El.find('.reply2-list').append($(template));
	comment2El.find('.btn-group').hide();
	comment2El.find('.reply2-editor').focus();
}

// 답글 추가
async function addReply2(el, nickname) { //el이 답글 작성하고 누르는 "확인"버튼
	console.log('reply2 추가');

	// cno 추출, nickname 추출
	const comment2El = el.closest('.comment2');
	const reply2Block = comment2El.find('.reply2-edit-block');
	
	const cno = parseInt(comment2El.data("no"));
	const content =reply2Block.find('.reply2-editor').val(); 
	let reply2 = { cno, nickname, content };

	// reply2 POST API 호출
	reply2 = await rest_create(REPLY2_URL, reply2);
	console.log(reply2);

	const reply2El = $(createReply2Template(reply2, nickname));
	comment2El.find('.reply2-list').append(reply2El);
	comment2El.find('.reply2-edit-block').remove();
	comment2El.find('.btn-group').show();
}

// 답글 수정 화면 보여주기
function showUpdateReply2(el) {
	const reply2El = el.closest('.reply2');
	
	const no = reply2El.data("no");
	const content = reply2El.find('.reply2-content').html();
	
	const reply2 = { no, content };
	const editor = $(createReply2EditTemplate(reply2));

	
	reply2El.find('.reply2-content').hide();
	reply2El.find('.btn-group').hide();
	reply2El.find('.reply2-body').append(editor);
}

// 답글 수정한 것 등록 처리
async function updateReply2(el) {
	if(!confirm('답글을 수정할까요?')) return;

	const reply2El = el.closest('.reply2');
	const reply2Content = reply2El.find('.reply2-content');
	const content = reply2El.find('.reply2-editor').val();
	
	const no = reply2El.data("no"); 
	let reply2 = { no, content };
	
	reply2 = await rest_modify(REPLY2_URL + no, reply2);
	
	reply2Content.html(content);
	reply2Content.show();
	reply2El.find('.reply2-edit-block').remove();
	
	reply2El.find('.btn-group').show();
}

// 답글 수정 화면 취소
function cancelReply2Update() {
	const reply2El = $(this).closest('.reply2');
	reply2El.find('.reply2-content').show(); //취소니까 원래 화면 복원한 것
	reply2El.find('.reply2-edit-block').remove();
}



// 답글 취소
function cancelReply2(e) {
	const comment2El = $(this).closest('.comment2');
	comment2El.find('.reply2-edit-block').remove();
	comment2El.find('.btn-group').show();
}

// 답글 삭제
async function deleteReply2(e) {
	if(!confirm('답글을 삭제할까요?')) return;

	const reply2El = $(this).closest('.reply2');
	const no = parseInt(reply2El.data("no"));
	
	await rest_delete(REPLY2_URL + no);
	reply2El.remove();
}