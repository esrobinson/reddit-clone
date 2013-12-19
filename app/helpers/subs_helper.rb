module SubsHelper
  def is_moderator?
    @sub = Sub.find(params[:id])
    current_user == @sub.moderator
  end

  def require_moderator
    unless is_moderator?
      flash[:errors] = ["You must be a mod!"]
      redirect_to sub_url(@sub)
    end
  end
end
