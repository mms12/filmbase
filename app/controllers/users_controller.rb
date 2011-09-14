class UsersController < ApplicationController

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def index
    @user = User.page(params[:page])
    render :action => 'index'
  end

  
  def edit
    @user = User.find(params[:user])
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.role=0
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      flash[:notice]="Регистрация успешно завершена"
      redirect_to root_path
    else
      flash.now[:error]  = "При регистрации произошли ошибки."
      render :action => 'new'
    end
  end

end
