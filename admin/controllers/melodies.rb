SpreadMelody::Admin.controllers :melodies do
  get :index do
    @title = "Melodies"
    @melodies = Melody.all
    render 'melodies/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'melody')
    @melody = Melody.new
    render 'melodies/new'
  end

  post :create do
    @melody = Melody.new(params[:melody])
    if @melody.save
      @title = pat(:create_title, :model => "melody #{@melody.id}")
      flash[:success] = pat(:create_success, :model => 'Melody')
      params[:save_and_continue] ? redirect(url(:melodies, :index)) : redirect(url(:melodies, :edit, :id => @melody.id))
    else
      @title = pat(:create_title, :model => 'melody')
      flash.now[:error] = pat(:create_error, :model => 'melody')
      render 'melodies/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "melody #{params[:id]}")
    @melody = Melody.find(params[:id])
    if @melody
      render 'melodies/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'melody', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "melody #{params[:id]}")
    @melody = Melody.find(params[:id])
    if @melody
      if @melody.update_attributes(params[:melody])
        flash[:success] = pat(:update_success, :model => 'Melody', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:melodies, :index)) :
          redirect(url(:melodies, :edit, :id => @melody.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'melody')
        render 'melodies/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'melody', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Melodies"
    melody = Melody.find(params[:id])
    if melody
      if melody.destroy
        flash[:success] = pat(:delete_success, :model => 'Melody', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'melody')
      end
      redirect url(:melodies, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'melody', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Melodies"
    unless params[:melody_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'melody')
      redirect(url(:melodies, :index))
    end
    ids = params[:melody_ids].split(',').map(&:strip)
    melodies = Melody.find(ids)
    
    if Melody.destroy melodies
    
      flash[:success] = pat(:destroy_many_success, :model => 'Melodies', :ids => "#{ids.to_sentence}")
    end
    redirect url(:melodies, :index)
  end
end
