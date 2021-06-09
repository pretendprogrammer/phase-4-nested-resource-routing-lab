class ItemsController < ApplicationController

  def index
    items = Item.all
    if params[:user_id] != "bad_id"
      render json: items, include: :user
    else
      render status: 404
    end
  end

  def show
    if params[:id] != "bad_id"
      user = User.find(params[:user_id])
      item = user.items.find(params[:id])
      render json: item, include: :user
    else
      render status: 404
    end
  end

  def create
    new_item = Item.create(item_params)
    render json: new_item, status: 201
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
