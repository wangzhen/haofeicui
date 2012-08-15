//切换介绍和参数
$(document).ready(function(){
	$("#switch_body").click(function(){
		$("#switch_body")[0].className="bodyzone_cap_now";
		$("#switch_canshu")[0].className="bodyzone_cap_list";
		$("#bodyzone").show();
		$("#canshuzone").hide();
		$().setBg();
	});
	$("#switch_canshu").click(function(){
		$("#switch_body")[0].className="bodyzone_cap_list";
		$("#switch_canshu")[0].className="bodyzone_cap_now";
		$("#bodyzone").hide();
		$("#canshuzone").show();
		$().setBg();
	});
});

