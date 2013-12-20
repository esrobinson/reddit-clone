module LinksHelper
  def is_poster?
    @link = Link.find(params[:id])
    current_user == @link.poster
  end

  def require_poster
    redirect_to link_url(@link) unless is_poster?
  end
end
