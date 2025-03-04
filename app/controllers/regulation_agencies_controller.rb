class RegulationAgenciesController < ApplicationController
  def index
    matching_regulation_agencies = RegulationAgency.all

    @list_of_regulation_agencies = matching_regulation_agencies.order({ :created_at => :desc })

    render({ :template => "regulation_agencies/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_regulation_agencies = RegulationAgency.where({ :id => the_id })

    @the_regulation_agency = matching_regulation_agencies.at(0)

    render({ :template => "regulation_agencies/show" })
  end

  def create
    the_regulation_agency = RegulationAgency.new
    the_regulation_agency.agency_id = params.fetch("query_agency_id")
    the_regulation_agency.regulation_id = params.fetch("query_regulation_id")

    if the_regulation_agency.valid?
      the_regulation_agency.save
      redirect_to("/regulation_agencies", { :notice => "Regulation agency created successfully." })
    else
      redirect_to("/regulation_agencies", { :alert => the_regulation_agency.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_regulation_agency = RegulationAgency.where({ :id => the_id }).at(0)

    the_regulation_agency.agency_id = params.fetch("query_agency_id")
    the_regulation_agency.regulation_id = params.fetch("query_regulation_id")

    if the_regulation_agency.valid?
      the_regulation_agency.save
      redirect_to("/regulation_agencies/#{the_regulation_agency.id}", { :notice => "Regulation agency updated successfully."} )
    else
      redirect_to("/regulation_agencies/#{the_regulation_agency.id}", { :alert => the_regulation_agency.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_regulation_agency = RegulationAgency.where({ :id => the_id }).at(0)

    the_regulation_agency.destroy

    redirect_to("/regulation_agencies", { :notice => "Regulation agency deleted successfully."} )
  end
end
