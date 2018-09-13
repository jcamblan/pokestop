namespace :candies do
  desc "TODO"

  task create: :environment do

    candies_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', 'candies.json'))))
    pokedex_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_megapokedex.json'))))

    candies_file.each do |candy|

      name_fr = pokedex_file.select { |p| p['name_en'] == candy['pokemon']}.first['name_fr']

      unless Candy.where(name: "Bonbon #{name_fr}").first
        Candy.create(name: "Bonbon #{name_fr}", primary_color: candy['primaryColor'], secondary_color: candy['secondaryColor'])
      end

    end 

  end

  task images: :environment do

    candies = Candy.all

    candies.each do |candy|

      first_image  = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', "candy_base_color.png"))
      first_image.merge! ["-fill", candy.primary_color, "-colorize", "50%"]
      second_image = MiniMagick::Image.open(File.join(Rails.root, 'app', 'assets', 'images', 'candy', "candy_secondary_color.png"))
      second_image.merge! ["-fill", candy.secondary_color, "-colorize", "50%"]
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
