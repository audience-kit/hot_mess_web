desc "Import the list of seeds in config/seeds.yml"
task :import, [ :token ] => [ :environment ] do |task, args|
  Rails.logger     = Logger.new(STDOUT)
  Rails.logger.level     = Logger::INFO
  
  seeds = YAML.load_file(File.join(Rails.root, 'config', 'seeds.yml'))

  seeds['locales'].each do |locale, value|
    importer = FacebookImporter.new(args[:token])
    importer.import_locale(value)
  end
end

