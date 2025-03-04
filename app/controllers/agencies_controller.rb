class AgenciesController < ApplicationController
  def index
    matching_agencies = Agency.all

    @list_of_agencies = matching_agencies.order({ :created_at => :desc })

    render({ :template => "agencies/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_agencies = Agency.where({ :id => the_id })

    @the_agency = matching_agencies.at(0)

    render({ :template => "agencies/show" })
  end

  def create
    the_agency = Agency.new

    if the_agency.valid?
      the_agency.save
      redirect_to("/agencies", { :notice => "Agency created successfully." })
    else
      redirect_to("/agencies", { :alert => the_agency.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_agency = Agency.where({ :id => the_id }).at(0)


    if the_agency.valid?
      the_agency.save
      redirect_to("/agencies/#{the_agency.id}", { :notice => "Agency updated successfully."} )
    else
      redirect_to("/agencies/#{the_agency.id}", { :alert => the_agency.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_agency = Agency.where({ :id => the_id }).at(0)

    the_agency.destroy

    redirect_to("/agencies", { :notice => "Agency deleted successfully."} )
  end
end
