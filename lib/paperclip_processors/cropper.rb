module Paperclip
  class Cropper < Thumbnail

    attr_accessor :crop_area, :convert_options, :source_file_options

    def initialize(file, options = {}, attachment = nil)
      @file = file
      @source_file_options = options[:source_file_options]
      @convert_options = options[:convert_options]

      @source_file_options = @source_file_options.split(/\s+/) if @source_file_options.respond_to?(:split)
      @convert_options = @convert_options.split(/\s+/) if @convert_options.respond_to?(:split)

      @format = File.extname(@file.path)
      @basename = File.basename(@file.path, @format)

      @crop_area = options[:crop_area]
    end

    def make
      src = @file
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      dst.binmode

      begin
        parameters = []
        parameters << source_file_options
        parameters << ":source"
        parameters << crop_command
        parameters << convert_options
        parameters << ":dest"

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

        Paperclip.run("convert", parameters, :source => File.expand_path(src.path), :dest => File.expand_path(dst.path))
      end

      dst
    end


    private

    def crop_command
      if cropping?
        ["-crop", "#{crop_area[:crop_w]}x#{crop_area[:crop_h]}+#{crop_area[:crop_x]}+#{crop_area[:crop_y]}"]
      else
        []
      end
    end

    def cropping?
      !crop_area[:crop_x].blank? && !crop_area[:crop_y].blank? && !crop_area[:crop_w].blank? && !crop_area[:crop_h].blank?
    end
  end
end

