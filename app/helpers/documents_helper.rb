# -*- coding: utf-8 -*-
module DocumentsHelper

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


  def document_rater(document)
    vote = Vote.where(:document_id => document.id, :user_id => (current_user ? current_user.id : nil))

    inc_rate = if !vote.first || !vote.first.vote_type
                  link_to "", rate_document_path(document, :vote_type => true), :class => "check-true-unselected icon", :method => :put, :title => "Увеличить рейтинг #{document.name}"
               else
                  link_to "", "", :class => "check-true icon", :title => "Вы уже увеличили рейтинг файла #{document.name}"
               end

    dec_rate = if !vote.first || vote.first.vote_type
                link_to "", rate_document_path(document), :class => "check-false-unselected icon", :method => :put, :title => "Уменьшить рейтинг #{document.name}"
               else
                link_to "", "", :class => "check-false icon", :title => "Вы уже уменьшили рейтинг файла #{document.name}"
               end
    return inc_rate + dec_rate
  end

  def rating(object)
    if object.rating > 0
      return raw("<span class='rating'>+ #{object.rating}</span>")
    elsif object.rating < 0
      return raw("<span class='bad-rating'>#{object.rating}</span>")
    end
    return raw("<span>#{object.rating}</span>")
  end

end
