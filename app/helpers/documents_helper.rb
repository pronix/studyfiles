module DocumentsHelper
  #перевод байтов в мегабайты
  def size_in_MB
    (self.file_size.to_f / (1024**2)).round(1)
  end

  def extension_icon_link(document)
    ext = ""
    case document.extension
      when "doc", "docx", "rtf"
        ext = "word"
      when "xls"
        ext = "exel"
      when "pdf"
        ext = "pdf"
    end
    link_to "", "", :class => "#{ext} icon"
  end
end
