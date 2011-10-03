module Models

  module Path
    extend ActiveSupport::Concern
    included do
      before_create :add_default_path

      scope :in_path, lambda { |path| where(["path = ? or path ~ ?", path.to_s, path.to_s + ".*" ])}
    end

    module InstanceMethods
      def add_default_path
        self.path = 'Top'
      end
    end

  end
end
