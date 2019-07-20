module ShortUris
  class Redirecter
    extend Dry::Initializer

    option :short_uri

    def call
      increment_times_clicked
      redirect_to_original_uri
    end

    private

    def increment_times_clicked
      short_uri.increment(:times_clicked)
      short_uri.save!
    end

    def redirect_to_original_uri
      short_uri.original_uri
    end
  end
end
