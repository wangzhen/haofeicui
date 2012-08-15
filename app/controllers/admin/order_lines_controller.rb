# coding: utf-8
class Admin::OrderLinesController < Admin::BaseController

  # GET /order_lines/new.xml
  def new
    render :layout => false
  end
  # DELETE /order_lines/1
  # DELETE /order_lines/1.xml
  def destroy
    @order_line = OrderLine.find(params[:id])
    if @order_line && @order_line.destroy
      @order_line.order.save
      render
    else
      render :nothing => true
    end
  end
end
