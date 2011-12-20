class FaqsController < ApplicationController

  def index
    @faqs = Faq.top_level
  end

end
