class SubsController < ApplicationController
  include SubsHelper

  before_filter :require_login
  before_filter :require_moderator, :only => [:edit, :update, :destroy]

  def create
    @sub = Sub.new(params[:sub])
    links = params[:link].values.reject{ |value| value["url"].empty? }
    @sub.links.new(links)
    @sub.links.each { |link| link.poster = current_user }

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = []
      flash.now[:errors].concat(@sub.errors.full_messages)

      @sub.links.each do |link|
        flash.now[:errors].concat(@link.errors.full_messages)
      end

      render :new
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  def edit
    @users = User.all
    @sub = Sub.find(params[:id])
    render :edit
  end

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    @users = User.all
    render :new
  end

  def show
    @sub = Sub.find(params[:id])
    @links = @sub.links
    render :show
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(params[:sub])
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
end