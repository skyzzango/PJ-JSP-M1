/*Custom script for this template*/
function formCheck() {
	let length = document.forms[0].length;
	for (let i = 0; i < length - 1; i++) {
		if (document.forms[0][i].value == null || document.forms[0][i].value == "") {
			alert(document.forms[0][i].name + " 을/를 입력하세요.");
			document.forms[0][i].focus();
			return false;
		}
	}
	if (document.forms[0].writer.value.match(/^(\w+)@(\w+)[.](\w+)$/ig) == null) {
		alert('이메일 형식으로 입력하세요.');
		return false;
	}
	if (document.forms[0].reg_date.match(/^\d\d\d\d\d\d+$/ig) == null) {
		alert('숫자 형식(6자리)으로 입력하세요.');
		return false;
	}
}
