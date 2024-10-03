class ArchiveTaskJob
  include Sidekiq::Job

  def perform(task_ids)
    tasks = Task.where(id: task_ids).where.not(status: :archived)
    tasks.update_all(status: :archived, archived_at: Time.current)
  end
end

