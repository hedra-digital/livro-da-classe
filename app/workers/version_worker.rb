class VersionWorker
  include Sidekiq::Worker

  def perform
    Book.push_all_to_repository
  end
end