class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images)
    # @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
 end


 def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
 end


  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    end  
  end  

  



  private
  def item_params
    params.require(:item).permit(:name,:explain,:status_id,:delivery_cost,:area,:limit,:price,:category_id,:brand_id,images_attributes: [:image, :_destroy, :id])
  end
end
