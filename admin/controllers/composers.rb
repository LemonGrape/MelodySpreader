SpreadMelody::Admin.controllers :composers do
  get :index do
    @title = "Composers"
    @composers = Composer.all
    render 'composers/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'composer')
    @composer = Composer.new
    render 'composers/new'
  end

  post :create do
    @composer = Composer.new(params[:composer])
    if @composer.save
      @title = pat(:create_title, :model => "composer #{@composer.id}")
      flash[:success] = pat(:create_success, :model => 'Composer')
      params[:save_and_continue] ? redirect(url(:composers, :index)) : redirect(url(:composers, :edit, :id => @composer.id))
    else
      @title = pat(:create_title, :model => 'composer')
      flash.now[:error] = pat(:create_error, :model => 'composer')
      render 'composers/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "composer #{params[:id]}")
    @composer = Composer.find(params[:id])
    if @composer
      render 'composers/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'composer', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "composer #{params[:id]}")
    @composer = Composer.find(params[:id])
    if @composer
      if @composer.update_attributes(params[:composer])
        flash[:success] = pat(:update_success, :model => 'Composer', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:composers, :index)) :
          redirect(url(:composers, :edit, :id => @composer.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'composer')
        render 'composers/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'composer', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Composers"
    composer = Composer.find(params[:id])
    if composer
      if composer.destroy
        flash[:success] = pat(:delete_success, :model => 'Composer', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'composer')
      end
      redirect url(:composers, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'composer', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Composers"
    unless params[:composer_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'composer')
      redirect(url(:composers, :index))
    end
    ids = params[:composer_ids].split(',').map(&:strip)
    composers = Composer.find(ids)
    
    if Composer.destroy composers
    
      flash[:success] = pat(:destroy_many_success, :model => 'Composers', :ids => "#{ids.to_sentence}")
    end
    redirect url(:composers, :index)
  end
end
