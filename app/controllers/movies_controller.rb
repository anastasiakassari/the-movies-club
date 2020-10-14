class MoviesController < ApplicationController

  #Runs :set_movie method before anything else
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  #User should be logged in to perform all other actions
  # before_action :require_user, except: [:show, :index]

  #User should be movie's user
  # before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /movies
  def index
    @movies = Movie.all
    #@movies = Movie.paginate(page: params[:page], per_page: 5)
  end

  # GET /movies/{id}
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end


  # GET /movies/{id}/edit
  def edit
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "Movie was created successfully"
      redirect_to @movie
    else
      render 'new'
    end
  end

  # PATCH/PUT /movies/{id}
  def update
    if @movie.update(movie_params)
      flash[:notice] = "Movie was updated successfully"
      redirect_to @movie
    else
      render 'new'
    end
  end

  # DELETE /movies/{id}
  def destroy
    @movie.destroy
    flash[:notice] = "Movie was deleted successfully"
    redirect_to movies_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :description)
    end

    # Only allow the movie's user to perform the action(s)
    # def require_same_user
    #   if current_user != @movie.user && !current_user.admin?
    #     flash[:alert] = "You can only edit your own movie(s)"
    #     redirect_to @movie
    #   end
    # end

end