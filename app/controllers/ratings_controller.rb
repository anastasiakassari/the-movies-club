class RatingsController < ApplicationController

  before_action :require_user

  def rate
    @rating = Rating.new
    @movie = Movie.find(params[:movie].to_i)
    value = params[:value].to_i
    @user = current_user

    # Movie user cannot rate their movies
    if @movie.user == @user
      head :forbidden
    else
      # Rating exists
      dbrating = find_rating(@movie, @user)

      @rating.movie = @movie
      @rating.value = value
      @rating.user = @user

      # Create new rating
      if dbrating == nil
        if @rating.valid?
          @rating.save
          respond_to do |format|
            #format.json  { render json: { likes: movie.likes, hates: movie.hates, movie_id: movie.id} }
            format.js { render partial: 'movies/ratings'} #, locals: { movie: movie }, layout: false }
          end
        else
          head :bad_request
        end
      # Update / Delete existing rating
      else
        @rating = dbrating

        # Update existing rating
        if dbrating.value != value
          if @rating.update(value: value)
            respond_to do |format|
              #format.json  { render json: { likes: movie.likes, hates: movie.hates, movie_id: movie.id} }
              format.js { render partial: 'movies/ratings'} #, locals: { movie: movie }, layout: false }
            end
          else
            head :bad_request
          end
        # Delete existing rating
        else
          @rating.destroy
          respond_to do |format|
            #format.json  { render json: { likes: movie.likes, hates: movie.hates, movie_id: movie.id} }
            format.js { render partial: 'movies/ratings'}#, locals: { movie: movie }, layout: false }
          end
          #head :ok
        end
      end      
    end    
  end

  private

  def find_rating(movie, user)
    Rating.find_by(movie_id: movie.id, user_id: user.id)
  end
  
end