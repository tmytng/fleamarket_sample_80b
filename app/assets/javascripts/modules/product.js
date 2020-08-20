// カテゴリーフォームのJS制御
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
    `<select class="categoly_form3" id="grandchildren_category" name="product[category_id]">
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
      //親カテゴリーが変更されたら、子/孫カテゴリーを削除し、初期値にする
      $("#children_box").empty();
      $("#grandchildren_box").empty();
      //上の処理の後に子カテの情報を持ったフォームが作成される。
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
  }
});

//子カテゴリー選択によるイベント発火
$(document).on('change', '#children_box', function() {
  //選択された子カテゴリーidを取得
  let childId = $('#children_category option:selected').data('category');
  //子カテゴリーが初期値でない場合
  if (childId != ""){
    $.ajax({
      url: 'get_category_grandchildren',
      type: 'GET',
      data: { child_id: childId },
      datatype: 'json'
    })
    .done(function(grandchildren) {
      if (grandchildren.length != 0) {
        $("#grandchildren_box").empty();
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
  }
});


// 画像投稿フォームの制御
$(document).on('turbolinks:load', function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var dropzone_box = $('.dropzone_box');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    images.push(img);

    if(images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
        dropzone2.css({
          'width': `calc(100% - (135px * ${images.length - 5}))`
        })
      })
      if(images.length == 10) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (135px * ${images.length}))`
        })
      }
      if(images.length == 4) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    if(images.length == 10) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="product[product_imgs_attributes][${images.length}][image]" class="upload-image" data-image= ${images.length + 1} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });
  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (135px * ${images.length - 5}))`
      })
      if(images.length == 10) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 9) {
        dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (135px * ${images.length}))`
      })
    }
    if(images.length == 5) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 4) {
      dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
    }
  })
});