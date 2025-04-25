// jquery 선언
$(function(){
    $("#dataOpen3").click(function(){
        // alert("확인");
        $.ajax({
            url:"https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=bL05ehIVxrekLZkNPfKKTOw%2FG6cS1dFlgNuQS5K5hlHUuHGQn3MZAJ7GxH0IbYTxX4D5FPl6XzogD7CBxyrJyg%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json",
            type:"get",
            dataType:"json",
            success:function(data){
                alert("성공");
                console.log(data.response.body.items.item);
                console.log("이미지 url : ", data.response.body.items.item[0].galWebImageUrl);

                // img 링크 src에 넣기
                let imgData = data.response.body.items.item[0].galWebImageUrl;
                let hdata = `<img id="img" src="${imgData}">`;
                $("#txt").html(hdata);

                
                // let dataitem = data.response.body.items.item;
                // let hdata = ``;

                // for(let i=0; i<dataitem.length; i++){
                //     hdata += `<tr id="${dataitem[i].galContentId}">`;
                //     hdata += `<td>${dataitem[i].galContentId}</td>`;
                //     hdata += `<td>${dataitem[i].galCreatedtime}</td>`;
                //     hdata += `<td>${dataitem[i].galPhotographer}</td>`;
                //     hdata += `<td>${dataitem[i].galPhotographyLocation}</td>`;
                //     hdata += `<td>${dataitem[i].galSearchKeyword}</td>`;
                //     hdata += `<td>${dataitem[i].galTitle}</td>`;
                //     hdata += `<td>${dataitem[i].galWebImageUrl}</td>`;
                //     hdata += `<td>`;
                //     hdata += `<button type="button" class="updateBtn">수정</button>`;
                //     hdata += `<button type="button" class="deleteBtn">삭제</button>`;
                //     hdata += `</td>`;
                //     hdata += `</tr>`;
                // }
                // $("#tbody").html(hdata);
            },
            error:function(){
                alert("실패");
            }
        }); // ajax
    }); //dataOpen3
}); //jquery