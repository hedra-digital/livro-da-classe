# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :integer          not null, primary key
#  data_file_name    :string(255)      not null
#  data_content_type :string(255)
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  width             :integer
#  height            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/pictures/:style_:basename.:extension",
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['118x100#', :jpg]
                    }

  validates_attachment_size           :data,
                                      :less_than => 5.megabytes,
                                      :message => "has to be under 5 MB size"
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

  before_create :randomize_file_name

  def url_content
    url(:content)
  end

private

  def randomize_file_name
    extension = File.extname(data_file_name).downcase
    name = File.basename(data_file_name, extension).downcase
    self.data.instance_write(:file_name, "#{name}#{"%.0f" % Time.new.to_f}#{extension}")
  end

end
