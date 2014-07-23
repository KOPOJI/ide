module FilesHelper
  def file_type_image extension = nil
    filename = "extensions/file-extension-#{extension}-icon.png"
    filename = 'extensions/default-icon.png' unless File.exist?("#{Rails.root}/app/assets/images/#{filename}")
    image_tag image_path(filename), class: 'file-type-icon'
  end
end
