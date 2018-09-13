namespace :types do
  desc "TODO"

  task create: :environment do
    types_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_types.json'))))

    types_file.each do |t|

      check_db = Type.where(name: t.dig('fr'))

      if check_db.empty?
        Type.create(name: t.dig('fr'))
      end

    end

  end

end
