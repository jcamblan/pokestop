namespace :candies do
  desc "Génération des images des bonbons à partir des bouts de sprites"

  task images: :environment do

    candies = Candy.all

    candies.each do |candy|
      first_image  = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', "candy_base_color.png"))
      first_image.merge! ["-fill", candy.primary_color, "-colorize", "100%"]
      second_image = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', "candy_secondary_color.png"))
      second_image.merge! ["-fill", candy.secondary_color, "-colorize", "100%"]
      third_image = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', "candy_highlight.png"))
      first_step = first_image.composite(second_image) do |c|
        c.compose "Over"
      end
      result = first_step.composite(third_image) do |c|
        c.compose "Over"
      end
      result.write "#{Rails.root}/app/assets/images/candy/#{candy.id}.png"
    end
  end

end
