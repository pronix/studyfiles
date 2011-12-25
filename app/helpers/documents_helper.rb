# -*- coding: utf-8 -*-
module DocumentsHelper

  def university_rating(rating)
    %Q(<span>место</span><b>-</b>) unless rating.present?
    return image_tag("icons/univer_place_#{rating}.png") if rating && rating >= 1 && rating <= 3
    %Q(<span>место</span><b>#{rating}</b>)
  end

  def university_rating_2(rating)
    return %Q(<span>место</span><b>-</b></span>) unless rating.present?
    return image_tag("icons/univer_place_ext_#{rating}.png") if rating >= 1 && rating <= 3
    %Q(<span>место</span><b>#{rating}</b></span>)
  end

  def star_image(rating)
    return '' unless rating.present?
    return image_tag("icons/star#{rating}.png") if rating >= 1 && rating <= 3
    rating
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


  def document_rater(document)
    vote = Vote.where(:document_id => document.id, :user_id => (current_user ? current_user.id : nil))

    inc_rate = if !vote.first || !vote.first.vote_type
                  link_to "", rate_document_path(document, :vote_type => true),
                    :class => "async-rater check-true-unselected icon",
                    :method => :put,
                    :title => "Увеличить рейтинг #{document.name}",
                    :rel => document.name, :remote => true
               else
                  link_to "", "",
                    :class => "check-true icon inactive-rater",
                    :method => :put,
                    :title => "Вы уже увеличили рейтинг файла #{document.name}",
                    :rel => document.name, :remote => true,
                    :name => rate_document_path(document, :vote_type => true)
               end

    dec_rate = if !vote.first || vote.first.vote_type
                link_to "", rate_document_path(document),
                  :class => "async-rater check-false-unselected icon",
                  :method => :put,
                  :title => "Уменьшить рейтинг #{document.name}",
                  :rel => document.name, :remote => true
               else
                link_to "", "",
                  :class => "check-false icon inactive-rater",
                  :method => :put,
                  :title => "Вы уже уменьшили рейтинг файла #{document.name}",
                  :rel => document.name, :remote => true,
                  :name => rate_document_path(document)
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

  def user_name(user=current_user)
    user.name ? user.name : 'Аноним'
  end

end
