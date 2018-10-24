namespace :candies do
  desc "Génération des images des bonbons à partir des bouts de sprites"

  task images: :environment do
    Candy.all.each do |candy|
      first_image  = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', 'sprites', "candy_base_color.png"))
      first_image.merge! ["-fill", candy.primary_color, "-colorize", "100%"]
      second_image = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', 'sprites', "candy_secondary_color.png"))
      second_image.merge! ["-fill", candy.secondary_color, "-colorize", "100%"]
      third_image = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', 'sprites', "candy_highlight.png"))
      first_step = first_image.composite(second_image) do |c|
        c.compose "Over"
      end
      result = first_step.composite(third_image) do |c|
        c.compose "Over"
      end
      result.write "#{Rails.root}/app/assets/images/candy/#{candy.image_name}.png"
    end
  end

  task colors: :environment do
    CandyManager.new.update_colors
  end

  task assign: :environment do
    CandyManager.new.link_candies_to_pokemon
  end

end