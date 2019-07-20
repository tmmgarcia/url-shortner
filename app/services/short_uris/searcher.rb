module ShortUris
  class Searcher
    extend Dry::Initializer

    attr_reader :short_uri

    option :path, type: Dry::Types["strict.string"]

    def call
      short_uri_exists?
    end

    private

    def short_uri_exists?
      @short_uri ||= ShortUri.find_by(filters)
      short_uri.present?
    end

    def filters
      {
        path: path
      }
    end
  end
end
