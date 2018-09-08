$(function() {
  $('.del_bn').on('click', function(e) {
    e.preventDefault();
    var del_ele = $(this).parent().parent().parent().parent();
    var comment_id_num = $(this).attr('id').replace("com_id_","");
    var prototype_id = $('#prototype_id_num').val();
    var link_url = "/prototypes/"+prototype_id+"/comments/"+comment_id_num;
    var comments_count = $('#comments_count').text().replace(")", "");
    var comments_count = Number(comments_count) - 1;
    $.ajax({
        type: 'DELETE',
        url: link_url,
        dataType: 'json',
        processData: false,
        contentType: false
    })
    .done(function() {
        del_ele.remove();//指定の要素を削除
        $('#comments_count').empty();  //コメント数を一旦空にする
        $('#comments_count').append(String(comments_count)+' )');  //コメント数更新
    })
    .fail(function() {
      alert('error');
    });
  });
});
