module Fae
  module NavigationConcern
    extend ActiveSupport::Concern

    # define the navigation structure in this file
    # example structure:
    #
    # def structure
    #   [
    #     item('Top Nav Item 1', subitems: [
    #       item('Top Nav Dropdown Item 1', class: 'custom-class', path: some_named_route_path),
    #       item('Top Nav Dropdown Item 2', subitems: [
    #         item('Side Nav Item 1', subitems: [
    #           item('Side Nav Nested Item', path: some_named_route_path)
    #         ]),
    #         item('Side Nav Item 1', path: some_named_route_path)
    #       ]),
    #     ]),
    #     item('Pages', subitems: [
    #       item('Home', path: fae.edit_content_block_path('home')),
    #       item('About Us', path: fae.edit_content_block_path('about_us'))
    #     ])
    #   ]
    # end

    def structure
      [
        item('Pokedex', subitems: [
          item('Generations', path: admin_generations_path),
          item('Types', path: admin_types_path),
          item('Attacks', path: admin_attacks_path),
          item('Pokemons', path: admin_pokemons_path),
          item('Item Categories', path: admin_item_categories_path),
          item('Items', path: admin_items_path),
          item('Evolutions', path: admin_evolutions_path),
          item('Alternative Skin Categories', path: admin_alternative_skin_categories_path),
          item('Alternative Skins', path: admin_alternative_skins_path)
        ]),
        item('Events', path: admin_events_path),
        item('Candies', path: admin_candies_path),
        item('Articles', path: admin_articles_path),
        item('Article Categories', path: admin_article_categories_path),
        # scaffold inject marker
      ]
    end

  end
end
