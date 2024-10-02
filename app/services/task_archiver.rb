class TaskArchiver
    def initialize(task_finder_service: OldTaskFinder.new)
        @task_finder_service = task_finder_service
    end

    def call
        Board.all.each { |board|
            old_task_ids = @task_finder_service.call(board).map {|task| task.id}
            if old_task_ids.count > 0
                ArchiveTaskJob.perform_async(old_task_ids)
            end
        }
    end
end