class DirectorsController < ApplicationController
  def update
    # Get the ID out of params
   d_id = params.fetch("the_id")
    # Look up the existing record
    matching_records= Director.where({ :id => d_id })
    the_director = matching_records.at(0) 
    # Overwrite each column with the values from user inputs
    the_director.name=params.fetch("the_title")
    the_director.dob=params.fetch("the_Dob")
    the_director.bio=params.fetch("the_Bio")
    
    the_director.image=params.fetch("the_image")
   

    # Save
    the_director.save

    # Redirect to the movie details page
    redirect_to("/movies/#{the_director.id}")
  end

  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    director = Director.new
    director.name = params.fetch("query_name")
    director.dob = params.fetch("query_dob")
    director.bio = params.fetch("query_bio")
    director.image = params.fetch("query_image")

    if director.save
      redirect_to("/directors")
    else
      render({ :template => "page_templates/error" })
    end
  end
end
