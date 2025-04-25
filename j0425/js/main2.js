//jquery 선언
$(function(){
    $("#dataOpen3").click(function(){
        //alert("확인");
        $.ajax({
            url:"https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=M%2B%2BXcTspBfzteJwjlRGu%2F%2BagLpAUIt2sIIshC1u%2F6TIGFwVzPlRaIDZIPE9l4buu0cCZWrxIAfqH%2F5%2FPFPE%2FoQ%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json",
            type:"get",
            data:{},
            dataType:"json",
            success:function(data){
                alert("성공");
                console.log(data.response.body.items.item);
                console.log(data.response.body.items.item[0].galWebImageUrl);
                $("#txt").text(data.response.body.items.item[0].galWebImageUrl);
                
                let imgData=data.response.body.items.item[0].galWebImageUrl
                let hdata=`<img id="img" src="${imgData}">`;
                $("#txt").html(hdata)
                
                // for(let i=0; i<data.length; i++){
                //     hdata += `<tr id="${dataR[i].galContentId}">`;
                //     hdata += `<td>${dataR[i].galContentId}</td>`;
                //     hdata += `<td>${dataR[i].galCreatedtime}</td>`;
                //     hdata += `<td>${dataR[i].galPhotographer}</td>`;
                //     hdata += `<td>${dataR[i].galPhotographyLocation}</td>`;
                //     hdata += `<td>${dataR[i].galSearchKeyword}</td>`;
                //     hdata += `<td>${dataR[i].galTitle}</td>`;
                //     hdata += `<td>${dataR[i].galWebImageUrl}</td>`;
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
            },
        });//ajax
    });//#dataOpen3
});//jquery