# frozen_string_literal: true
require 'roo'

class ImportCampagin
  include Interactor

  delegate :file, to: :context

  def call
    xlsx = Roo::Spreadsheet.open(file.tempfile, extension: :xlsx)

    sheet = xlsx.sheet('Sponsored Products Campaigns')

    filtered_data = []

    sheet.each(filtered_keys) do |formatted_hash|
      filtered_data << data(formatted_hash)
    end

    # TODO: We will save this data to DB in the real-time project.

    context.formatted_data = filtered_data.compact_blank
  end

  private

  def filtered_keys
    {
      entity: 'Entity',
      ad_group_name: 'Ad Group Name (Informational only)',
      campgain_name: 'Campaign Name (Informational only)',
      keyword_text: 'Keyword Text',
      match_type: 'Match Type',
      impressions: 'Impressions',
      clicks: 'Clicks',
      click_through_rate: 'Click-through Rate',
      spend: 'Spend',
      sales: 'Sales',
      orders: 'Orders',
      units: 'Units',
      conversion_rate: 'Conversion Rate',
      acos: 'ACOS',
      cpc: 'CPC',
      roas: 'ROAS'
    }
  end

  def data(row)
    return unless valid_keyword_data?(row)

    {
      entity: row[:entity],
      ad_group_name: row[:ad_group_name],
      campaign_name: row[:campgain_name],
      keyword_text: row[:keyword_text],
      match_type: row[:match_type],
      impressions: row[:impressions],
      clicks: row[:clicks],
      click_through_rate: row[:click_through_rate],
      spend: row[:spend],
      sales: row[:sales],
      orders: row[:orders],
      units: row[:units],
      conversion_rate: row[:conversion_rate],
      acos: row[:acos],
      cpc: row[:cpc],
      roas: row[:roas]
    }
  end

  def valid_keyword_data?(row)
    row[:spend].to_i >= 1 && row[:sales].to_i == 0 && non_branded_keyword?(row[:ad_group_name])
  end

  def non_branded_keyword?(ad_group_name)
    return false if ad_group_name.blank?

    ad_group_name.split('|')&.second&.include?('NB')
  end
end
