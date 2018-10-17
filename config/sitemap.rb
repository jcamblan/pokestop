# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.pokestop.me"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add pokemons_path, :changefreq => 'weekly'
  add items_path, :changefreq => 'weekly'
  add generations_path, :changefreq => 'weekly'
  add articles_path, :changefreq => 'weekly'
  add special_researches_path, :changefreq => 'weekly'
  add types_path, :changefreq => 'weekly'
  add eggs_path, :changefreq => 'weekly'

  Pokemon.find_each do |pokemon|
    add pokemon_path(pokemon), :lastmod => pokemon.updated_at, :changefreq => 'daily'
  end
  
  Attack.find_each do |attack|
    add attack_path(attack), :lastmod => attack.updated_at, :changefreq => 'daily'
  end
  
  Generation.find_each do |generation|
    add generation_path(generation), :lastmod => generation.updated_at, :changefreq => 'daily'
  end
  
  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at, :changefreq => 'daily'
  end
  
  Type.find_each do |type|
    add type_path(type), :lastmod => type.updated_at, :changefreq => 'daily'
  end
end
