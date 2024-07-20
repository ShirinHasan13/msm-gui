class ActorsController < ApplicationController
  def update
    # Get the ID out of params
    a_id = params.fetch("the_id")
    
    # Look up the existing record
    matching_records = Actor.where({ :id => a_id })
    the_actor = matching_records.at(0) 
    
    # Overwrite each column with the values from user inputs
    the_actor.name = params.fetch("the_name")
    the_actor.dob = params.fetch("the_dob")
    the_actor.bio = params.fetch("the_bio")
    the_actor.image = params.fetch("the_image")

    # Save
    the_actor.save

    # Redirect to the actor details page
    redirect_to("/actors/#{the_actor.id}")
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

  def create
    actor = Actor.new
    actor.name = params.fetch("query_name")
    actor.dob = params.fetch("query_dob")
    actor.bio = params.fetch("query_bio")
    actor.image = params.fetch("query_image")

    if actor.save
      redirect_to("/actors")
    else
      render({ :template => "page_templates/error" })
    end
  end
end
