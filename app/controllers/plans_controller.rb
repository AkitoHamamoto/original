class PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.create(plan_params)
    if @plan.save
      redirect_to root_path
    else
      render :index
      
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if current_user.authority == true
      @plan.destroy
      redirect_to root_path
    else
      render :index
    end
  end



  private
  def  plan_params
    params.require(:plan).permit(:text).merge(user_id: current_user.id)
  end
end
