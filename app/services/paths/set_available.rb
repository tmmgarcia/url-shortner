module Paths
  class SetAvailable
    extend Dry::Initializer

    option :path_list, [proc(&:to_s)]

    def call
      store_path
    end

    private

    def store_path
      $redis.sadd(key, path_list)
    end

    def key
      ENV.fetch('PATH_KEY')
    end
  end
end
