var onresize = function() {
   width = parseFloat(document.body.clientWidth);
   height = document.body.clientHeight;
   var phone = document.getElementById('home_page_phone_image');
   if(width <= 880 || height <495){
   	phone.style.display = "none";
   }else{
    phone.style.display = "inline-block";
   }
}
window.addEventListener("resize", onresize);
