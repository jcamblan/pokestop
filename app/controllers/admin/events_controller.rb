module Admin
  class EventsController < Fae::BaseController

    private

    def build_assets
      @item.build_illustration if @item.illustration.blank?
    end

  end
end
