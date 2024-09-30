class ArchiveTaskJob
  include Sidekiq::Job

  def perform
    Task.where('created_at < ?', 1.day.ago).update_all(status: :archived)
  end
end
