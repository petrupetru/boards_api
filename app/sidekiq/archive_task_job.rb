class ArchiveTaskJob
  include Sidekiq::Job

  def perform(task_ids)
    tasks = Task.where(id: task_ids)
    tasks.update_all(status: :archived)
  end
end

