module Admin
  class ItemsController < Fae::BaseController

    private

    def build_assets
      @item.build_illustration if @item.illustration.blank?
    end

  end
end
