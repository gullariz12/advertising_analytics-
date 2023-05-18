# frozen_string_literal: true

class TableComponent < ViewComponent::Base
  attr_reader :data

  def initialize(data:)
    @data = data
  end
end
