// 다음 주소 함수
function zipCodeBtn(){
    // alert("다음주소 api 호출");
    // 다음주소 api 호출
    new daum.Postcode({
        oncomplete: function(data) {
            document.querySelector("#postZip").value = data.zonecode;   // data.을 붙여야 값을 불러옴
            document.querySelector("#addr1").value = data.address;
            document.querySelector("#addr2").focus();
        }
    }).open();
}

// 비밀번호 확인 함수
function pwConfirm(){
    let pw = document.querySelector("#pw").value;
    let pw2 = document.querySelector("#pw2").value;
    if (pw == pw2){
        document.querySelector("#pwCheck").style.color="blue";
        document.querySelector("#pwCheck").innerText="비밀번호가 일치합니다.";
    }else{
        document.querySelector("#pwCheck").style.color="red";
        document.querySelector("#pwCheck").innerText="비밀번호가 일치하지 않습니다.";
    }
    if (pw2 == ""){
        document.querySelector("#pwCheck").style.color="#555";
        document.querySelector("#pwCheck").innerText="비밀번호를 다시 한번 입력해 주세요.";
    }

// 이메일 선택 함수
function emailchange(){
    // console.log(document.querySelector("#email-sel").value);
    let email_sel = document.querySelector("#email-sel").value;
    document.querySelector("#email2").value=email_sel;
}

}