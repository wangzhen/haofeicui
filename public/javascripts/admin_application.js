// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// 
// AJAX 动作时,禁用页面操作
function disabled_page(is_disabled){
  if(is_disabled == "true"){
    height = $$("body")[0].getHeight();

    mask = new Element('div',{
      id:"mask",
      style:"position:absolute;width:100%;height:"+height+"px;left:0px;top:0px;background:#000;filter:alpha(opacity=25); opacity:0.25;z-index:4"
    });
    $$("body")[0].appendChild(mask);

  }else{
    $("mask").remove();
  }
}
