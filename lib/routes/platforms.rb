class USRNParticipantsApp < Sinatra::Base
  get '/platforms/?' do
    @page_title = 'Platforms'
    @platforms = Platform.all
    haml :platforms, :layout => :'layout'
  end

  get '/platforms/:id' do
    @platform = Platform[params[:id]]
    @page_title = "Platform: #{@platform.name}"
    @repositories = @platform.repositories
    haml :platform, :layout => :'layout'
  end
end