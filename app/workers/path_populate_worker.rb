class PathPopulateWorker
  include Sidekiq::Worker

  def perform
    @available_path = available_path_list

    while available_path.size < max
      size            = max - available_path.size
      generated_path  = generate_path(size)
      @available_path = (available_path + generated_path + duplicated_paths(generated_path)).uniq
    end

    store_available_path
  end

  private

  attr_reader :available_path

  def available_path_list
    Paths::GetAvailable.new.()
  end

  def generate_path(size)
    (1..size).map { SecureRandom.urlsafe_base64(ENV.fetch("PATH_LENGTH").to_i) }
  end

  def duplicated_paths(path_list)
    ShortUri.where(path: path_list).pluck(:path)
  end

  def store_available_path
    Paths::SetAvailable.new(path_list: available_path).()
  end

  def max
    ENV.fetch('AVAILABLE_PATH_SIZE').to_i
  end
end
