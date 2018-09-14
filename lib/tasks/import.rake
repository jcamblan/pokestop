namespace :import do
  desc "On intègre toute la base de donnée à partir du json de backup"

  task everything: :environment do
    import = Import.new
    import.import_everything
  end
end