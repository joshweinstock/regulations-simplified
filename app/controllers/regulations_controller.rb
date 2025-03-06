class RegulationsController < ApplicationController
  def index
    matching_regulations = Regulation.all

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
    the_regulation = Regulation.new
    the_regulation.register_url = params.fetch("query_register_url")
    url= params.fetch("query_register_url")
 
    parsed_uri = URI.parse(url)
    path_segments = parsed_uri.path.split("/").reject { |segment| segment.empty? }
    key_segment = path_segments.at(4)

         api_url="https://www.federalregister.gov/api/v1/documents/#{key_segment}.json?fields[]=abstract&fields[]=action&fields[]=agencies&fields[]=agency_names&fields[]=body_html_url&fields[]=citation&fields[]=document_number&fields[]=effective_on&fields[]=html_url&fields[]=pdf_url&fields[]=significant"

     @raw_response = HTTP.get(api_url)
     @raw_string = @raw_response.to_s
     @parsed_data = JSON.parse(@raw_string)
     
    @parsed_data["document_number"] = params.fetch("query_document_number", nil)
    @parsed_data["pdf_url"] = params.fetch("query_pdf_url", nil)
    @parsed_data["title"] = params.fetch("query_title", nil)
    @parsed_data["action"] = params.fetch("query_action", nil)
    @parsed_data["original_url"] = params.fetch("original_url", nil)
    @parsed_data["raw_url"] = params.fetch("query_raw_url", nil)
    @parsed_data["citation"] = params.fetch("query_citation", nil)
    @parsed_data["signficant"] = params.fetch("query_significant", nil)

    if @parsed_data.valid?
      @parsed_data.save
      redirect_to("/regulations", { :notice => "Regulation created successfully." })
    else
      redirect_to("/regulations", { :alert => the_regulation.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_regulation = Regulation.where({ :id => the_id }).at(0)

    the_regulation.register_url = params.fetch("query_register_url")
    the_regulation.document_number = params.fetch("query_document_number")
    the_regulation.pdf_url = params.fetch("query_pdf_url")
    the_regulation.title = params.fetch("query_title")
    the_regulation.action = params.fetch("query_action")
    the_regulation.original_url = params.fetch("query_original_url")
    the_regulation.raw_url = params.fetch("query_raw_url")
    the_regulation.comment_count = params.fetch("query_comment_count")
    the_regulation.citation = params.fetch("query_citation")
    the_regulation.significant = params.fetch("query_significant")

    if the_regulation.valid?
      the_regulation.save
      redirect_to("/regulations/#{the_regulation.id}", { :notice => "Regulation updated successfully."} )
    else
      redirect_to("/regulations/#{the_regulation.id}", { :alert => the_regulation.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_regulation = Regulation.where({ :id => the_id }).at(0)

    the_regulation.destroy

    redirect_to("/regulations", { :notice => "Regulation deleted successfully."} )
  end
end
