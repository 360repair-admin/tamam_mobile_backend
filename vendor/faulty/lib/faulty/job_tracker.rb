module Faulty
  module JobTracker
    def self.included(base)
      base.class_eval do
        around_perform do |job, block|
          begin
            block.call
          rescue => e
            unless e.instance_variable_defined?(:@faulty_handled)
              Faulty.capture(e, context: complete_job_context(job))
              e.instance_variable_set(:@faulty_handled, true)
            end
            raise e
          end
        end

        private

        def complete_job_context(job)
          context = {}

          # Capture all public methods that don't require arguments
          job.public_methods(false).each do |method|
            begin
              context[method] = job.public_send(method)
            rescue ArgumentError, NoMethodError
              # skip methods that require arguments or fail
            end
          end

          # Capture all instance variables
          job.instance_variables.each do |ivar|
            context[ivar.to_s.delete("@")] = job.instance_variable_get(ivar)
          end

          # Add job class name explicitly
          context[:job_class] = job.class.name

          # If ActiveJob defines a queue_name or locale method, these are often in public_methods already
          # But just in case, ensure presence
          context[:queue_name] ||= job.try(:queue_name)
          context[:locale] ||= job.try(:locale)
          context[:enqueued_at] ||= job.try(:enqueued_at)

          context
        end
      end
    end
  end
end
