module RacingOnRails
  class ImportDatabaseJob
    include SuckerPunch::Job

    def perform(association)
      ActiveRecord::Base.connection_pool.with_connection do
        RacingOnRails::ImportDatabase.new(association: association).do_it!
      end
    end
  end
end
