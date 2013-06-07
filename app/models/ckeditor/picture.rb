class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/pictures/:style_:basename.:extension",
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['118x100#', :jpg]
                    }

  validates_attachment_size           :data,
                                      :less_than => 2.megabytes,
                                      :message => "has to be under 2 MB size"
  validates_attachment_presence       :data
  validates_attachment_content_type   :data,
                                      :content_type => [
                                        'image/jpeg',
                                        'image/pjpeg',
                                        'image/jpg',
                                        'image/png',
                                        'image/tif',
                                        'image/gif'
                                        ],
                                      :message => "has to be in a proper format"

  def url_content
    url(:content)
  end
end
