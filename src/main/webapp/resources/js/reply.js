//답글 버튼 관리
const replyUpdatable = `
	<button class="btn btn-light btn-sm reply-update-show-btn">
		<i class="fa-solid fa-pen-to-square"></i> 수정
	</button>
	<button class="btn btn-light btn-sm reply-delete-btn">
		<i class="fa-solid fa-times"></i> 삭제
	</button>
`;

//답글 생성
function createReplyTemplate(reply, nickname) {
	return `
		<div class="reply my-3" 
		data-no="${reply.no}" 
		data-nickname="${reply.nickname}">
			<div class="reply-title my-2 d-flex justify-content-between">
				<div class="reply-head">
					<strong class="reply-nickname">
					${reply.nickname}</strong>
					<span class="text-muted ml-3 reply-date">
						${moment(reply.registerDate).format('YYYY-MM-DD hh:mm')}
					</span>
				</div>
				
				<div class="btn-group">
					${nickname && (nickname == reply.nickname) ? replyUpdatable : ''} 
				</div>
			</div>
			<div class="reply-body">
				<div class="reply-content">${ reply.content || '' }</div>
			</div>
		</div>
	`;
}


//답글 입력칸 생성
function createReplyEditTemplate(reply) {
	return `
		<div class="bg-light p-2 rounded reply-edit-block" 
			data-no = "${reply.no}"
			data-cno="${reply.cno}" 
			data-nickname="${reply.nickname}">
				
			<div>${reply.no ? '' : ' 답글 작성'}</div>
				
				<textarea class="form-control mb-1 reply-editor">
					${reply.content || '' }
				</textarea>
				
				<div class="text-end">
					<button onClick="window.location.reload()" class="btn btn-light btn-sm py-1 
						${reply.no ? 'reply-update' : 'reply-add-btn'} ">
						<i class="fa-solid fa-check"></i> 확인
					</button>
						
					<button class="btn btn-light btn-sm py-1 
						${reply.no ? 'reply-update-cancel' : 'reply-add-cancel-btn'} ">
						<i class="fa-solid fa-undo"></i> 최소
					</button>
			</div>
		</div>
	`;
}

//답글 화면에 보여주기
function showReplyAdd(el, nickname) {
	const commentEl = el.closest('.comment');
	const cno = commentEl.data("no");
	const reply = { cno, nickname };
	const template = createReplyEditTemplate(reply);

	console.log('--------------------------------');
	console.log(commentEl);
	console.log(commentEl.find('.reply-list'));
	commentEl.find('.reply-list').append($(template));
	commentEl.find('.btn-group').hide();
	commentEl.find('.reply-editor').focus();
	
}

// 답글 추가
async function addReply(el, nickname) { //el이 답글 작성하고 누르는 "확인"버튼
	console.log('reply 추가');

	// cno 추출, nickname 추출
	const commentEl = el.closest('.comment');
	const replyBlock = commentEl.find('.reply-edit-block');
	
	const cno = parseInt(commentEl.data("no"));
	const content =replyBlock.find('.reply-editor').val(); 
	let reply = { cno, nickname, content };

	// REPLY POST API 호출
	reply = await rest_create(REPLY_URL, reply);
	console.log(reply);

	const replyEl = $(createReplyTemplate(reply, nickname));
	commentEl.find('.reply-list').append(replyEl);
	commentEl.find('.reply-edit-block').remove();
	commentEl.find('.btn-group').show();
}

// 답글 수정 화면 보여주기
function showUpdateReply(el) {
	const replyEl = el.closest('.reply');
	
	const no = replyEl.data("no");
	const content = replyEl.find('.reply-content').html();
	
	const reply = { no, content };
	const editor = $(createReplyEditTemplate(reply));

	
	replyEl.find('.reply-content').hide();
	replyEl.find('.btn-group').hide();
	replyEl.find('.reply-body').append(editor);
}

// 답글 수정한 것 등록 처리
async function updateReply(el) {
	if(!confirm('답글을 수정할까요?')) return;

	const replyEl = el.closest('.reply');
	const replyContent = replyEl.find('.reply-content');
	const content = replyEl.find('.reply-editor').val();
	
	const no = replyEl.data("no"); 
	let reply = { no, content };
	
	reply = await rest_modify(REPLY_URL + no, reply);
	
	replyContent.html(content);
	replyContent.show();
	replyEl.find('.reply-edit-block').remove();
	
	replyEl.find('.btn-group').show();
}

// 답글 수정 화면 취소
function cancelReplyUpdate() {
	const replyEl = $(this).closest('.reply');
	replyEl.find('.reply-content').show(); //취소니까 원래 화면 복원한 것
	replyEl.find('.reply-edit-block').remove();
}



// 답글 취소
function cancelReply(e) {
	const commentEl = $(this).closest('.comment');
	commentEl.find('.reply-edit-block').remove();
	commentEl.find('.btn-group').show();
}

// 답글 삭제
async function deleteReply(e) {
	if(!confirm('답글을 삭제할까요?')) return;

	const replyEl = $(this).closest('.reply');
	const no = parseInt(replyEl.data("no"));
	
	await rest_delete(REPLY_URL + no);
	replyEl.remove();
}