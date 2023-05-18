class HomeController < ApplicationController
  def dashboard; end

  def import_campagin
    result = ImportCampagin.call(file: params[:file])

    @campaign_data = result.formatted_data
  end
end