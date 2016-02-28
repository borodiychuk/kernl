namespace :kernl do
  namespace :values do

    desc "Delete abandoned values"
    task :cleanup => :environment do
      Values.abandoned.destroy_all
    end

  end
end
