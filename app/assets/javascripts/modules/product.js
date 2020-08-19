function appendOption(category) {
  let html = 
    `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
  return html;
}

function appendChildrenBox(insertHTML) {
  let childSelectHtml = '';
  childSelectHtml = 
    `<select class="categoly_form2" id="children_category">
      <option value="" data-category="" >選択してください</option>
      ${insertHTML}</select>
    <i class = "fa fa-chevron-down"></i>`;
  $('#children_box').append(childSelectHtml);
}

function appendGrandchildrenBox(insertHTML) {
  let grandchildSelectHtml = '';
  grandchildSelectHtml = 
    `<select class="categoly_form3" id="grandchildren_category" name="item[category_id]">
      <option value="" data-category="" >選択してください</option>
      ${insertHTML}</select>
    <i class = "fa fa-chevron-down"></i>`;
  $('#grandchildren_box').append(grandchildSelectHtml);
}

//親カテゴリー選択によるイベント
$(document).on("change","#parent_category", function() {
  //選択された親カテゴリーの名前取得 → コントローラーに送る
  let parentCategory =  $("#parent_category").val();
  if (parentCategory != "") {
    $.ajax( {
      type: 'GET',
      url: 'get_category_children',
      data: { parent_id: parentCategory },
      dataType: 'json'
    })
    .done(function(children) {
      //親カテゴリーが変更されたら、子/孫カテゴリー、サイズを削除し、初期値にする
      $("#children_box").empty();
      $("#grandchildren_box").empty();
      // $('.size_box').val('');
      // $('#size_box').css('display', 'none');
      let insertHTML = '';
      children.forEach(function(children) {
        insertHTML += appendOption(children);
      });
      appendChildrenBox(insertHTML);
    })
    .fail(function() {
      alert('error：子カテゴリーの取得に失敗');
    })
  }else{
    $("#children_box").empty();
    $("#grandchildren_box").empty();
    // $('.size_box').val('');
    // $('#size_box').css('display', 'none');
  }
});

//子カテゴリー選択によるイベント発火
$(document).on('change', '#children_box', function() {
  //選択された子カテゴリーidを取得
  let childId = $('#children_category option:selected').data('category');
  console.log(this)
  //子カテゴリーが初期値でない場合
  if (childId != ""){
    $.ajax({
      url: 'get_category_grandchildren',
      type: 'GET',
      data: { child_id: childId },
      datatype: 'json'
    })
    .done(function(grandchildren) {
      console.log(grandchildren)
      if (grandchildren.length != 0) {
        $("#grandchildren_box").empty();
        // $('.size_box').val('');
        // $('#size_box').css('display', 'none');
        let insertHTML = '';
        grandchildren.forEach(function(grandchild) {
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      }
    })
    .fail(function() {
      alert('error:孫カテゴリーの取得に失敗');
    })
  }else{
    $("#grandchildren_box").empty();
    // $('.size_box').val('');
    // $('#size_box').css('display', 'none');      
  }
});