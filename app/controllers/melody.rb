SpreadMelody::App.controllers :melody do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  post :upload do
    raw_path = "/data/" + params[:title] + ".mid"
    wav_path = "/data/" + params[:title] + ".wav"
    inner_raw_path = Dir.pwd.to_s + "/public" +  raw_path
    inner_wav_path = Dir.pwd.to_s + "/public" + wav_path

    unless params[:musicFile][:type] == "audio/midi" 
      return "This is not midi file"
    end
    if Melody.find_by(:wav_path => wav_path )
      return  "Duplicated Name"
    end
    if params[:musicFile][:tempfile].size > 50000
     return "Too big File"
    end 

    open(inner_raw_path, 'wb') do |output|
      output.write(params[:musicFile][:tempfile].read)
    end
      `/usr/local/bin/fluidsynth -F #{inner_wav_path} #{Dir.pwd.to_s}/public/sf/TimGM6mb.sf2 #{inner_raw_path} `
    m = Melody.new
    m.author = params[:author]
    m.name  = params[:title]
    m.desc = params[:desc]
    m.raw_path = raw_path
    m.wav_path = wav_path
    m.save
    return "Success"
  end
end
