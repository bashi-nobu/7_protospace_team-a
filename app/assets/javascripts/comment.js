$(function() {
  function buildHTML(comment,prototype_id) {
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
                        <a href="/prototypes/${prototype_id}/comments/${comment.id}", class="del_btn", id="com_id_${comment.id}">
                          削除
                        </a>
                      </li>
                  </div>
                </div>`;
    return html;
  }

  $(document).on("submit", ".comment_form", function (e) {
    e.preventDefault();
    var user_id_num = $('#user_id_num').val();
    if(user_id_num == 'no_signed_in'){
      location.href = '/users/sign_in'
    }else{
      var textField = $('#textarea');
      var comment = textField.val();
      var comments_count = $('#comments_count').text().replace(")", "");
      var comments_count = Number(comments_count) + 1;
      var url = $(this).attr('action');
      var prototype_id = $('#prototype_id_num').val();
      $.ajax({
        type: 'POST',
        url: url,
        data: {
          comment: {
            content: comment
          }
        },
        dataType: 'json'
      })
      .done(function(data) {
        var html = buildHTML(data,prototype_id);
        $('.comment__list').append(html);
        $('.comment_form')[0].reset();  //入力された値をリセット
        $('#button').prop('disabled', false);  //submit処理を有効化
        $('#comments_count').empty();  //コメント数を一旦空にする
        $('#comments_count').append(String(comments_count)+' )');  //コメント数更新
      })
      .fail(function() {
        alert('error');
      });
    }
  });
});
