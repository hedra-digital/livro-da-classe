class BooksGenerateWorker
  include Sidekiq::Worker

  def perform
    Project.all.each do |project|
      project.book.pdf
    end
  end
end