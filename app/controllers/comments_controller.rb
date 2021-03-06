class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]
  
  def create
    # Создаём объект @new_comment из @event
    @new_comment = @event.comments.build(comment_params)
    # Проставляем пользователя, если он задан
    @new_comment.user = current_user
  
    if @new_comment.save
      # Если сохранился, редирект на страницу самого события
      redirect_to @event, notice: t('controllers.comments.created')
    else
      # Если ошибки — рендерим здесь же шаблон события (своих шаблонов у коммента нет)
      render 'events/show', alert: t('controllers.comments.error')
    end
  end

  def destroy
    message = {notice: t('controllers.comments.destroyed')}
  
    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {alert: t('controllers.comments.error')}
    end
  
    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
