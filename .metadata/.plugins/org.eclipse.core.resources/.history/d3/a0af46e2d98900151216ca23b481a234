var mainBanAry = ["/images/common/new_main/banner_1.jpg","/images/common/new_main/banner_2.jpg","/images/common/new_main/banner_3.jpg","/images/common/new_main/banner_4.jpg","/images/common/new_main/banner_5.jpg"];
var mainBanNmAry = ["KITA","포상신청","월드잡","코엑스","소프트엔지니어스쿨"];
var mainBanLinkAry = ["http://www.kita.net/","http://award.kita.net/main3.screen","http://www.worldjob.or.kr/index2.do","http://www.coex.co.kr/","http://www.icn.zone/"];
var mainBanMax;
var mainBanInterval;
var mainBanIntervalTime = 3500;
var mainBanCurNum = 0;
var mainBanImgGap = 356;
var isMainBanPlay = false;
$(function()
{  
 mainBanInit();
 
} );
function mainBanInit(){
 var len = mainBanAry.length;
 mainBanMax = len;
 
 var img_str = "<ul class='img_list'>";
 var btn_str = "<ul class='btn_list'>";
 for(var i=0; i<len+1; i++){
  var img = mainBanAry[i%len];
  var url = mainBanLinkAry[i%len];  
  var name = mainBanNmAry[i%len];
  
  img_str += "<li><a href='"+url+"'><img src='"+img+"' alt='"+name+"'/></a></li>";
  if(i<len){
   btn_str += "<li><img src='/images/common/new_main/btn_off.png' alt='"+name+"'/><img src='/images/common/new_main/btn_on.png' alt='"+name+"' class='hidden'/></li>";
  }
   
 }
 img_str += "</ul>";
 btn_str += "</ul>";

 var str = img_str+btn_str;
 var tw = mainBanImgGap*(len+1);
 $("#banner").append(str);
 $("#banner .img_list").width(tw);
 
 
 mainBanConfig();
}
function mainBanConfig(){
 
 $("#banner .btn_list li").click(mainBanBtnClick).css("cursor","pointer"); 
 mainBanBtnPlay(0);

 clearInterval(mainBanInterval);
 mainBanInterval = setTimeout(mainBanRoll, mainBanIntervalTime);
}
function mainBanBtnClick(){
 
 if(isMainBanPlay){
  return;
 }
 clearInterval(mainBanInterval);
 mainBanInterval = setTimeout(mainBanRoll, mainBanIntervalTime);
 var idx = $(this).index();
 curHotIssueNum = idx;
 mainBanPlay(idx); 
}
function mainBanRoll(){
 if(isMainBanPlay){
  clearInterval(mainBanInterval);
  mainBanInterval = setTimeout(mainBanRoll, mainBanIntervalTime);
  return;
 }
 mainBanCurNum++;
 mainBanPlay(mainBanCurNum);
}
function mainBanPlay(n){
 isMainBanPlay = true;
 var tx = -mainBanImgGap*n;
 $("#banner .img_list").stop().stop().animate({left:tx+"px"},{duration:450,complete:mainBanComplete});
 mainBanCurNum = n;
 mainBanBtnPlay(n%mainBanMax);
 clearInterval(mainBanInterval);
 mainBanInterval = setTimeout(mainBanRoll, mainBanIntervalTime);
}
function mainBanComplete(){
 isMainBanPlay = false;
 if(mainBanCurNum==mainBanMax){
  $("#banner .img_list").stop().stop().animate({left:"0px"},{duration:0});
  mainBanCurNum = 0;
 }
}
function mainBanBtnPlay(n){
 $("#banner .btn_list li").each(function(i) {    
  if(i==n){
   $(this).find("img").eq(0).addClass("hidden");
   $(this).find("img").eq(1).removeClass("hidden");
  }else{
   $(this).find("img").eq(1).addClass("hidden");
   $(this).find("img").eq(0).removeClass("hidden");
  }
 });
}