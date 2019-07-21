module Paths
  class GetAvailable
    attr_reader :available_list

    def call
      set_available_list
    end

    def path
      set_available_list if available_list.nil?
      @available_list.sample
    end

    def populate_needed?
      set_available_list if available_list.nil?
      available_list.size < min
    end

    private

    def set_available_list
      @available_list ||= get_from_redis || []
    end

    def get_from_redis
      $redis.smembers(key)
    end

    def key
      ENV.fetch('PATH_KEY')
    end

    def min
      ENV.fetch('MIN_AVALIABLE_PATH_SIZE').to_i
    end
  end
end
