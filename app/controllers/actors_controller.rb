class ActorsController < ApplicationController
  def update
    # Get the ID out of params
   a_id = params.fetch("the_id")
    # Look up the existing record
    matching_records= Actor.where({ :id => a_id })
    the_actor = matching_records.at(0) 
    # Overwrite each column with the values from user inputs
    the_actor.name=params.fetch("the_name")
    the_director.dob=params.fetch("the_Dob")
    the_director.bio=params.fetch("the_Bio")
    
    the_director.image=params.fetch("the_image")
   

    # Save
    the_actor.save

    # Redirect to the movie details page
    redirect_to("/movies/#{the_actor.id}")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
