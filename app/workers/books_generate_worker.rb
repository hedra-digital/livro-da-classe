class BooksGenerateWorker
  include Sidekiq::Worker

  def perform
    Project.all.each do |project|
      begin
        project.book.pdf
      rescue
        project.book.update_attributes(:valid_pdf => false)
      end
    end
  end
end