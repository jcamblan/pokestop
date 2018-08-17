module Admin
  class TypesController < Fae::BaseController

    private

    def build_assets
      @item.build_logo if @item.logo.blank?
    end

  end
end
