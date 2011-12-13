class SiteLog < ActiveRecord::Base
  include Hierarchy
  
  belongs_to :user

  def f_object
    eval(relation_type).find(relation_id)
  end
  
  class << self
    # OPTIMIZE: brr hell ))
    def create_foler(folder, action='create_folder')
      _log = self.new
      _log.user = folder.user
      _log.relation_id = folder.id
      _log.relation_type = folder.class.to_s
      _log.action = action
      _log.name = folder.name
      _log.save
    end

    def doc_move_p(folder, user, action='move_docs')
      create(:user => user, :relation_id => folder.id,
             :relation_type => folder.class.to_s,
             :action => action,
             :name => folder.name)
    end

    def doc_move_c(doc, user, _parent, action='move_doc')
      create(:user => user, :relation_id => doc.id,
             :relation_type => doc.class.to_s,
             :action => action,
             :name => doc.name, :parent => _parent)
    end
  end
end
