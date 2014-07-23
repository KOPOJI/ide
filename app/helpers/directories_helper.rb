module DirectoriesHelper

  def nested_directory(directories, showed = [])
    directories.map do |directory, sub_directory|
      next if showed.include? directory.id
      content_tag(:ul, render(directory), :class => 'nav nav-list')
    end.join.html_safe
  end
  def directory_path dir
    file_path = dir.project.name
    while dir.parent
      file_path +=  '/' + dir.name
      dir = dir.parent
    end
    file_path
  end
end
