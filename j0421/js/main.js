// function 함수명() : 함수선언
function chBtn(){
    alert("색상을 빨간색으로 변경합니다.");
    // id 찾는 방법
    // let color1 = document.getElementById("color1");

    /* 
    // class 찾는 방법 - 여러개 검색, 배열로 넘어옴 -> 주소값 필요
    let color2 = document.getElementsByClassName("color2");
    console.log(color2);
    console.log(color2[0]);
    color2[0].style.color = "red";
    color2[0].innerText = "회원수정";
    */
    
    /*
    // querySelector - id - 1개만 검색됨, class
    let color3 = document.querySelector("#color3");
    console.log(color3);
    color3.style.color = "red";
    color3.innerText = "회원수정";
    */

    // querySelector - class 첫번째 1개만 검색
    // querySeletorAll() - class 복수개 검색, 배열로 넘어옴 -> 주소값 필요
    let color4 = document.querySelector(".color4"); // 사용권장
    console.log(color4);
    color4.style.color = "red";
    color4.innerText = "회원수정";

    let color5 = document.querySelectorAll(".color4");
    console.log(color5);
}