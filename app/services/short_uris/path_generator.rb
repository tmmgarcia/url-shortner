module ShortUris
  class PathGenerator
    def call
      generate_path
    end

    private

    def generate_path
      SecureRandom.urlsafe_base64(ENV.fetch("PATH_LENGTH").to_i)
    end
  end
end
