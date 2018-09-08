$(function() {

  function buildHTML_form(comment,comment_id_num) {
    var html = `<form class="update_btn">
                  <textarea name="comment" class="form-control">${comment}</textarea>
                  <button type="submit" class="btn btn-primary">UPDATE</button>
                  <input name="comment_id" type="hidden" value="`+comment_id_num+`">
                </form>`;
    return html;
  }

  function buildHTML(comment) {
    var html = `<div class="media">
                  <div class="media__left">
                    <img src=${ comment.user_image} width="64" height="64">
                  </div>
                  <div class="media__body">
                    <h4 class="media-heading">${ comment.user_name}</h4>
                    <p>${ comment.content}</p>
                  </div>
                  <div class="media__right">
                    <ul class="more_list">
                      <li class="edit_btn">
                        <a class="edit_btn" id="com_id_${comment.id}">
                          編集
                        </a>
                      </li>
                      <li>
                        <a href="", class="del_btn", id="com_id_${comment.id}">
                          削除
                        </a>
                      </li>
                </div>`;
    return html;
  }

  $('.edit_btn').on('click', function(e) {
    //コメントIDを取得
    var comment_id_num = $(this).find('a').attr('id').replace("com_id_","");
    //既存のコメントを取得
    comment = $(this).parent().parent().parent().find('.comment_area').text();
    //コメント欄をテキストエリアに切り替える
    $(this).parent().parent().parent().find('.comment_area').remove();//コメントを削除(media_body)
    //テキストエリアに切り替え
    var html = buildHTML_form(comment,comment_id_num);
    $(this).parent().parent().parent().append(html);
    return false;
  });

  //$('.update_btn').on('submit', function(e){
  $(document).on("submit", ".update_btn", function (e) {
    e.preventDefault();
    var form = $(this);
    var comment = $(this).find('[name=comment]').val();
    var prototype_id = $('#prototype_id_num').val();
    var comment_id_num = $(this).find('[name=comment_id]').val();
    var url = "/prototypes/"+prototype_id+"/comments/"+comment_id_num;
      $.ajax({
        type: 'PATCH',
        url: url,
        data: {
          comment: {
            content: comment
          }
        },
        dataType: 'json'
      })
      .done(function(data) {
        var html = buildHTML(data);
        //入力フォームを削除しもとのコメント欄に置き換え
        form.parent().replaceWith(html);
      })
      .fail(function() {
        alert('error');
      });
    });
});
