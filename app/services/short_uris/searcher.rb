module ShortUris
  class Searcher
    extend Dry::Initializer

    option :path, type: Dry::Types["strict.string"]

    def call
      path_exists?
    end

    private

    def path_exists?
      ShortUri.where(filters).exists?
    end

    def filters
      {
        path: path
      }
    end
  end
end
