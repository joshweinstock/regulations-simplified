class RegulationsController < ApplicationController
  before_action :authenticate_user!
  def index
    matching_regulations = Regulation.where(user_id:current_user.id)

    @list_of_regulations = matching_regulations.order({ :created_at => :desc })

    render({ :template => "regulations/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_regulations = Regulation.where({ :id => the_id })

    @the_regulation = matching_regulations.at(0)

    render({ :template => "regulations/show" })
  end

  def create
    url= params.fetch("query_register_url")
 
    parsed_uri = URI.parse(url)
    path_segments = parsed_uri.path.split("/").reject { |segment| segment.empty? }
    key_segment = path_segments.at(4)

         api_url="https://www.federalregister.gov/api/v1/documents/#{key_segment}.json?fields[]=abstract&fields[]=action&fields[]=agencies&fields[]=agency_names&fields[]=body_html_url&fields[]=citation&fields[]=document_number&fields[]=effective_on&fields[]=pdf_url&fields[]=significant&fields[]=title&fields[]=html_url"

     @raw_response = HTTP.get(api_url)
     @raw_string = @raw_response.to_s
     @parsed_data = JSON.parse(@raw_string)
     user_id = current_user.id
     
     regulation = Regulation.new
     regulation.document_number = @parsed_data["document_number"]
     regulation.pdf_url = @parsed_data["pdf_url"]
     regulation.title = @parsed_data["title"]
     regulation.action = @parsed_data["action"]
     regulation.citation = @parsed_data["citation"]
     regulation.significant = @parsed_data["significant"]
     regulation.original_url = @parsed_data["body_html_url"]
     regulation.register_url = @parsed_data["html_url"]
     regulation.user_id = user_id


    if regulation.valid?
      regulation.save
      redirect_to("/regulations", { :notice => "Regulation created successfully." })
    else
      redirect_to("/regulations", { :alert => regulation.errors.full_messages.to_sentence })
    end

  end
end

  