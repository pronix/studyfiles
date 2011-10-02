module DocumentsHelper
  #перевод байтов в мегабайты
  def size_in_MB
    (self.file_size.to_f / (1024**2)).round(1)
  end
end
