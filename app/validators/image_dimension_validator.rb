class ImageDimensionValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |image|
      image_dimension(record, record.send(image))
    end
  end
  
  private
  def image_dimension(record,image)
    return unless image.queued_for_write[:original]

    dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)
    if dimensions.smaller < 300 
      record.errors.add(image.name, 'A largura ou a altura da imagem deve ter no mínimo 8 cm (300px)')
    end

    # 14cm = 529px
    # disable this check now
    if dimensions.larger > 529
      #record.errors.add(image.name, 'Width or height must be at no more than 14cm')
    end
  end

end




