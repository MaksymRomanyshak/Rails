class ExampleJob < ApplicationJob
    queue_as :default

    def perform(*args)
        sleep 60
        puts 'first job'
    end
end