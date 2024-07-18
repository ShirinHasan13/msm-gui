class MoviesController < ApplicationController

  def create
    #Retreive the user's inputs from params 
    #Create a record in the movie table
    #Populate each column with the user input
    #Save
    # Redirect the user back to the /movies URL
  end

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
