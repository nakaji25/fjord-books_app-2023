# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  def edit; end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to report_url(@comment), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    return if @comment.user == current_user

    flash[:alert] = '権限がありません。'
    redirect_to root_url
  end
end
