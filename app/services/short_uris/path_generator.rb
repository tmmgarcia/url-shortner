module ShortUris
  class PathGenerator
    def call
      generate_path
    end

    private

    def generate_path
      service = Paths::GetAvailable.new
      service.call
      populate_available_path if service.populate_needed?
      service.path
    end

    def populate_available_path
      PathPopulateWorker.new.perform
    end
  end
end
