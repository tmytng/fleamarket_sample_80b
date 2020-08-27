$(function () {
  // カテゴリボタンのマウスオーバー時の表示
  // 表示のUI向上のためには表示系の制御をかける必要あり
  $('.categoryBtn').mouseover(function () {
    $('.categoryField').removeClass("displayNone");
  })
  $('.categoryBtn').mouseout(function () {
    $('.categoryField').addClass("displayNone");
  })
  // 子カテゴリー追加
  function buildChildHTML(child) {
    var html = `<a class="childCategory" id="${child.id}"
                href="/items/${child.id}">${child.name}</a>`;
    return html;
  }
  // 孫カテゴリー追加
  function buildGrandChildHTML(child) {
    var html = `<a class="grandChildCategory" id="${child.id}"
              href="/items/${child.id}">${child.name}</a>`;
    return html;
  }
  // 子カテゴリのマウスオーバー時の表示
  $(".parentCategory").on("mouseover", function () {
    var id = this.id
    $('.categoryField').removeClass("displayNone");
    $(".childCategory").remove();
    $(".grandChildCategory").remove();
    $.ajax({
      type: 'GET',
      url: '/items/new',
      data: { parent_id: id },
      dataType: 'json'
    }).done(function (children) {
      children.forEach(function (child) {
        var html = buildChildHTML(child);
        $(".childrenList--item").append(html);
      })
    });
  });
  // 孫カテゴリのマウスオーバー時の表示
  $(document).on("mouseover", ".childCategory", function () {
    var id = this.id
    $.ajax({
      type: 'GET',
      url: '/items/new',
      data: { parent_id: id },
      dataType: 'json'
    }).done(function (children) {
      children.forEach(function (child) {
        var html = buildGrandChildHTML(child);
        $(".grandChildrenList--item").append(html);
      })
      $(document).on("mouseover", ".childCategory", function () {
        $(".grandChildCategory").remove();
      });
    });
  });
});
