
class SongsController < ApplicationController
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index' 
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'/songs/new' 
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show' 
    end 

    post '/songs' do
        @song = Song.create(:name => params["Name"])
        @song.artist = Artist.find_or_create_by(:name => params["Artist Name"]) 
        @song.genre_ids = params[:genres].each {|g| Genre.find_by(:id => g)}
        @song.save 
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end 

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'/songs/edit' 
    end 

    patch '/songs/:slug' do #edit action
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist = Artist.find_or_create(:name => params["Artist Name"]) 
        @song.save
        redirect "/songs/#{@song.slug}"
    end
    
end 