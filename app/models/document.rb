class Document  < ActiveRecord::Base

    has_and_belongs_to_many :categories

    before_update :set_updated_at

    def set_updated_at
       self.updated_at = Time.now         
    end

end

__END__


