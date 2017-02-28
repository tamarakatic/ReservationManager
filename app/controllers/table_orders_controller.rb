class TableOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @customer_order = CustomerOrder.find(params[:customer_order])
    @foods = Food.all
    @drinks = Drink.all
  end

  def add_foods
    food = Food.find(params[:id][:food_id])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.foods << food

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id) }
      # format.js
    end
  end

  def delete_food
    food = Food.find(params[:id][:food_id])
    customer_order = CustomerOrder.find(params[:id][:customer_id])
    customer_order.foods.delete(food)

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  def exchange_food
    food = Food.find(params[:id][:food_id])
    food_ex = Food.find(params[:id][:food_id_to_exchange])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.foods.delete(food)
    customer_order.foods << food_ex

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end
end
