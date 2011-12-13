module LogsHelper
  # OPTIMIZE: bbrbrbrbrrb!!!!
  def path_folder(folder)
    if folder.top_level?
      folder.name
    else
      folder.ext_ancestors.map{|f| f.name}.join(' / ') + ' / ' + folder.name
    end
  end
end
