class LinksController < ApplicationController
  include LinksHelper
  before_filter :require_poster, :only => [:update, :edit, :destroy]

  def create
    @link = Link.new(params[:link])
    @link.poster = current_user
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to subs_url
  end

  def edit
    @link = Link.find(params[:id])
    @current_subs = @link.subs
    @subs = Sub.order(:name)
    render :edit
  end

  def new
    @link = Link.new
    @current_subs = []
    @subs = Sub.order(:name)
    render :new
  end

  def show
    @link = Link.find(params[:id])
    render :show
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end
  end

end
