class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :ratings, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.defineRatings
    @movies = []
    if !(params[:ratings].blank?)
      rate_params = params[:ratings].keys
      @movies = Movie.where(rating: params[:ratings].keys)
      session[:ratings] = params[:ratings]
    elsif params[:sort_by] =='title'
      @movies = Movie.all.order(title: :asc)
      @title_header_color = 'hilite'
      session[:movies] = @movies
      session[:color] = @title_header_color
    elsif params[:sort_by] == 'date'
      @movies = Movie.all.order(release_date: :asc)
      @release_header_color = 'hilite'
      session[:movies] = @movies
      session[:color] = @release_header_color
    else 
      @movies = Movie.all
      session[:movies] = @movies
    end
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
