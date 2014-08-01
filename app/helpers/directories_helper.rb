module DirectoriesHelper

  def nested_directory(directories, showed = [])
    directories.map do |directory, sub_directory|
      return if directory.id == directory.parent_id
      next if showed.include? directory.id
      content_tag(:ul, render(directory))
    end.join.html_safe
  end

  def directory_path dir
    file_path = dir.name if dir.present? && dir.parent_id != -1
    while dir.parent
      file_path += '/' + dir.name
      dir = dir.parent
    end
    file_path
  end

  def directory_id dir
    return dir.id if dir.parent_id == -1 || dir.parent_id.nil?
    dir_id = dir.parent_id if dir.present? && dir.parent_id != -1
    while dir.parent
      dir_id = "#{dir_id}.#{dir.id}"
      dir = dir.parent
    end
    dir_id
  end
end
