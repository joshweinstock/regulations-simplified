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
    url = params.fetch("query_register_url")
    
    begin
      parsed_uri = URI.parse(url)
    rescue URI::InvalidURIError => error
      redirect_to("/regulations", { :alert => "The URL provided is invalid." }) and return
    end
  
    path_segments = parsed_uri.path.split("/").reject { |segment| segment.empty? }
    key_segment = path_segments.at(4)
  
    if key_segment.nil?
      redirect_to("/regulations", { :alert => "The URL is missing necessary segments." }) and return
    end
  
    api_url = "https://www.federalregister.gov/api/v1/documents/#{key_segment}.json?fields[]=abstract&fields[]=action&fields[]=agencies&fields[]=agency_names&fields[]=body_html_url&fields[]=citation&fields[]=document_number&fields[]=effective_on&fields[]=pdf_url&fields[]=significant&fields[]=title&fields[]=html_url"
  
    begin
      raw_response = HTTP.get(api_url)
      raw_string = raw_response.to_s
      parsed_data = JSON.parse(raw_string)
    rescue StandardError => error
      redirect_to("/regulations", { :alert => "There was a problem retrieving regulation data." }) and return
    end
  
    regulation = Regulation.new
    regulation.document_number = parsed_data.fetch("document_number")
    regulation.pdf_url = parsed_data.fetch("pdf_url")
    regulation.title = parsed_data.fetch("title")
    regulation.action = parsed_data.fetch("action")
    regulation.citation = parsed_data.fetch("citation")
    regulation.significant = parsed_data.fetch("significant")
    regulation.original_url = parsed_data.fetch("body_html_url")
    regulation.register_url = parsed_data.fetch("html_url")
    regulation.agency_names = parsed_data.fetch("agency_names")
    regulation.user_id = current_user.id
  
    # Try fetching the full text; if that fails, you might do something else.
    begin
      full_text_response = HTTP.get(parsed_data.fetch("body_html_url"))
      full_text = full_text_response.to_s
    rescue StandardError => error
      full_text = ""
    end
  
    full_text = full_text.truncate(50000)
  
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    message_list = [
      {
        "role" => "system",
        "content" => "You are a policy researcher interested in studying various federal regulations. Provide a brief 300 word summary of the regulation that summarizes what the regulation plans to do and how it will impact the department or agency currently operates. Do not take any stance on the regulation itself. Mention possible downsides or issues with the regulation. Assume that I am not aware of the programs that the regulation refers to and avoid abbreviations."
      },
      {
        "role" => "user",
        "content" => "Here is the full text of the regulation: #{full_text}"
      }
    ]
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )
    regulation.summary = response.fetch("choices").at(0).fetch("message").fetch("content")
  
    if regulation.valid?
      regulation.save
      redirect_to("/regulations", { :notice => "Regulation created successfully." }) and return
    else
      redirect_to("/regulations", { :alert => regulation.errors.full_messages.to_sentence }) and return
    end
  end

  def destroy
    the_id = params.fetch("path_id")  
    regulation = Regulation.find_by(id: the_id, user_id: current_user.id)

    if regulation
      regulation.destroy
      redirect_to("/regulations", { :notice => "Regulation deleted successfully." })
    else
      redirect_to("/regulations", { :alert => "Regulation not found or you do not have permission to delete it." })
    end
  end
end

  