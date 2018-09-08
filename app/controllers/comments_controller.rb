class CommentsController < ApplicationController
  def create
    @comment_params = comment_params
    @comment = Comment.create(content: comment_params[:content], prototype_id: params[:prototype_id], user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to prototype_path(params[:prototype_id])  }
      format.json
    end
    #redirect_to "/tweets/#{@comment.tweet.id}"   #コメントと結びつくツイートの詳細画面に遷移する
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params) if @comment.user.id == current_user.id
    respond_to do |format|
      format.html { redirect_to prototype_path(params[:prototype_id])  }
      format.json
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if comment.user.id == current_user.id
    respond_to do |format|
      format.html { redirect_to prototype_path(params[:prototype_id])  }
      format.json #jbuilder 'アクション名'.json.jbuilder というファイル内にjsonデータの定義をしておけば その形式に沿って jsonデータが返される
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content,:prototype_id)
  end
end
