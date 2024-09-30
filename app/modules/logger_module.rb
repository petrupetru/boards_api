require 'ougai'

module LoggerModule
  # Define a class-level logger in the module
  def self.logger
    @logger ||= Ougai::Logger.new(STDOUT).tap do |logger|
      logger.formatter = Ougai::Formatters::Readable.new
    end
  end
end