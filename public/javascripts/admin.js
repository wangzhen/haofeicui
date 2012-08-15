// 这个全局变量,邮件选择用户使用
function getSubCategories(containerId, parentId,mode,picture) {
  var path = ""
  if(picture == "true"){
    if(mode=="development"){
      path =  '/admin/categories/' + parentId + '/sub_categories?pictrue=' + picture
    }else if (mode == "production"){
      path = '/order/admin/categories/' + parentId + '/sub_categories?pictrue=' + picture
    }

    if (parentId) {
      new Ajax.Request(path,
      // :TODO develop environment path is /. doesn't want order/
      {
        method: 'get',
        onLoading: function() {
          $('loader').show();
        },
        onComplete: function() {
          $('loader').hide();
        }
      }
      );
    }
  }else{
    if(mode=="development"){
      path =  '/admin/categories/' + parentId + '/sub_categories'
    }else if (mode == "production"){
      path = '/order/admin/categories/' + parentId + '/sub_categories'
    }

    if (parentId) {
      new Ajax.Updater(containerId,
        // :TODO develop environment path is /. doesn't want order/
        path,
        {
          method: 'get',
          onLoading: function() {
            $('loader').show();
          },
          onComplete: function() {
            $('loader').hide();
          }
        }
        );
    }
  }


}

function addNewOrderLine (updaterId, url) {
  new Ajax.Updater(updaterId, url, {
    method: "get",
    insertion: "bottom"
  })
}

function deleteOrderLine(link) {
  // if (confirm("Are you sure to delete this line?")) {
  var url = link.getAttribute("href");
  var row = $("link").parentNode.parentNode;
  if (url && url != "#") {
    new Ajax.Request(url, {
      method: "delete",
      onSuccess: function() {
        row.remove();
      }
    })
  } else {
    row.remove();
  }
// }
}


var ReferenceWindow = {
  callback: function() {},
  _openedWindow: null,
  sourceElement: null,

  open: function(url) {
    this._openedWindow = window.open(url);
    return false;
  },

  close: function() {
    this._openedWindow.close();
    this._openedWindow = null;
  }
}

// Using selected users as mail recipients. This function will be fired in
// the opened dialog for setting up a mail task.
function selectRecipients() {
  window.parent.$("mail_task[user_ids]").value = $F("user_ids");
}

var Paginating = {
  currentPage: 1,
  goto: function(page) {
    $("page_" + this.currentPage).hide();
    $("page_" + page).show();
    $("link_to_page_" + this.currentPage).removeClassName("current");
    $("link_to_page_" + page).addClassName("current");

    this.currentPage = page;
  }
}

function tb_callback(user) {
  try {

    //document.getElementById("user_name").setAttribute("value", user.name);
    // document.getElementById("user_id").setAttribute("value", user.id);

    if($('user_name')){
      $("user_name").value =  user.name;
    }
    if($('user_id')){
      $("user_id").value =  user.id;
    }
    if($("product_user_id")){
      $("product_user_id").value =  user.id;
    }
    //setShippingInfo(user); // shipping information of selected user.
    ReferenceWindow.close();
  } catch(e) {
    alert("Error:\n" + e.message);
  }
}

function selectUser(json) {
  var _parent = window.opener || window.top;
  _parent.tb_callback(json.user);
}

/* Change the product of an order line. Need to query product attributes via
 * Ajax request and update subtotals.
 */
function changeLineProduct(productId, urlPrefix) {
  new Ajax.Request(urlPrefix + "/" + productId + ".js", {
    method: "get",
    evalJSON: "force",
    onSuccess: function(ajax) {
      var product = ajax.responseJSON.product;
       alert(product.id);
      if($('product_name')){
        $("product_name").value = product.name
      }
      if($('product_id')){
        $("product_id").value = product.id
      }
      var root = ReferenceWindow.sourceElement.parentNode.parentNode;
      //			$(root).select('.price').first().setAttribute("price", product.price);
      //      $(root).select('.price').first().value = product.price;
      $(root).select('.quantity').first().value = "1";
      $(root).select('.product_id').first().value = product.id;
      $(root).select('.name').first().value = product.name;
      $(root).select('.color').first().value = product.color.name;
      $(root).select('.sort').first().value = product.sort.name;
      $(root).select('.price').first().value = product.price;
//      var prices = $A(product.prices)
//      var types = $A(product.product_types)
//      var colors = $A(product.colors)
//      var price_type = types.zip(prices)
//      $(root).select(".price").first().observe("change",updateSummary)
//      colors.each(function(c){
//        $(root).select(".color").first().options.add(new Option(c.sub_name,c.id));
//      })
//      price_type.each(function(p){
//        var name = p[0].name + " " + p[1].price
//        $(root).select(".price").first().options.add(new Option(name,p[1].id))
//      })
      //      $(root).select('.specification').first().value = product.specification;
      updateSummary(); // Re-calculate order summary
    }
  })
}

// Re-calculate order summary.
function updateSummary() {
  var sum = 0;

   var pay_ment = $('order_payment_commition').value == "" ? 0 : $('order_payment_commition').value
   var mail_comm = $('order_mailing_commition').value == "" ? 0 : $('order_mailing_commition').value
    sum += parseFloat(pay_ment)
    sum += parseFloat(mail_comm)
  $$(".order_line").each(function(line) {
    var priceCell = line.select(".price").first();
    var price = parseFloat(priceCell.options[priceCell.selectedIndex].text.split(" ")[1]);
    if (!price) {
      price = parseFloat(line.select(".price").first().value);
    }
    var quantity = parseFloat(line.select(".quantity").first().value);
    var subTotal = price * quantity;
    sum += subTotal;
    //		priceCell.innerHTML = currency(price);
    line.select(".subtotal").first().innerHTML = currency(subTotal);
  })

  // summary
  $("subtotal").innerHTML = currency(sum);
  var adjustment = $("order_adjustment").value == "" ? 0 : $("order_adjustment").value
  $("total").innerHTML = currency(sum + parseFloat(adjustment));
}

// Format number into currency
function currency(num) {
  return "¥ " + num;
}

function setShippingInfo(user) {
  if (!$("order_address"))
    return;
  new Ajax.Request('/select_city?model=order', {
    asynchronous:true,
    evalScripts:true,
    method:'get',
    parameters:'city_id='+eval("user.city_id")
  })
  var attrs = ["city_id", "district_id", "address", "tel","postal_code", "fax", "mobile", "email"];
  window.setTimeout(function() {
    attrs.each(function(attr) {

      $("order_" + attr).value = eval("user." + attr);
    }) ;
  }, 1000);

  $("order_user_name").value = user.name;
}

function customerTypeCheck(n){
  if (n != 1) {
    $('user_password').value = ""
    $('user_password_confirmation').value = ""
    $('user_password').disabled = true
    $('user_password_confirmation').disabled = true
  }else{
    $('user_password').disabled = false
    $('user_password_confirmation').disabled = false
  }
}

function productTypeCheck(n){
  if (n != 1 && n!="") {
    Element.show($('user_select'))
    Element.show($('delete_link'))
    $('product_is_public').checked = false
    $('product_is_public').disabled = true
    $('user_name').disabled = false
    $('user_id').disabled = false
  //    $('user_select').visibility = "visible"

  }else{
    Element.hide($('delete_link'))
    $('product_is_public').disabled = false
    $('user_name').disabled = true
    $('user_name').value = ""
    //    $('user_select').visibility = "hidden"
    Element.hide($('user_select'))
    $('user_id').disabled = true
    $('user_id').value = ""
  }
}

function initProductForm(){
  Element.hide($('user_select'))
}


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


function clearUserText(){
  $('user_name').value = "";
  if($('product_user_id')){
    $('product_user_id').value = "";
  }
  if($('user_id')){
    $('user_id').value = "";
  }
}

function select_product(obj){
  
}
