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
    vote = Vote.where(:document_id => document.id, :user_id => current_user.id)

    inc_rate = if !vote.first || !vote.first.vote_type
                  link_to "", rate_document_path(document, :vote_type => true), :class => "check-true-unselected icon", :method => :put
               else
                  link_to "", "", :class => "check-true icon"
               end

    dec_rate = if !vote.first || vote.first.vote_type
                link_to "", rate_document_path(document), :class => "check-false-unselected icon", :method => :put
               else
                link_to "", "", :class => "check-false icon"
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
