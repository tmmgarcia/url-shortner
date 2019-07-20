module ShortUris
  class Creator
    attr_reader :short_uri

    extend Dry::Initializer

    option :original_uri, type: Dry::Types["strict.string"]

    def call
      raise_if_short_uri_is_present!
      @short_uri ||= create_short_uri
      self
    end

    def errors
      raise_if_short_uri_is_nil!
      short_uri.errors
    end

    def success?
      raise_if_short_uri_is_nil!
      short_uri.id.present?
    end

    private

    def create_short_uri
      ShortUri.new(original_uri: original_uri, path: path).tap do |short_uri|
        short_uri.valid? && short_uri.save
      end
    end

    def path
      loop do
        current_path = generate_path
        break current_path unless ShortUris::Searcher.new(path: current_path).()
      end
    end

    def generate_path
      ShortUris::PathGenerator.new.()
    end

    def raise_if_short_uri_is_nil!
      raise "Excecute #call before calling this method. Called from: #{caller.first}" if !short_uri
    end

    def raise_if_short_uri_is_present!
      raise "Invalid call to #call" if short_uri
    end
  end
end
