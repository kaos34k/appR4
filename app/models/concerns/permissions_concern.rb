module PermissionsConcern
    extend ActiveSupport::Concern
    
    def is_normal_user?
        self.peermission_lavel >= 1
    end
    
    def is_editor_user?
        self.peermission_lavel >= 2
    end
    
    def id_admin_user?
        self.peermission_lavel >= 3
    end
end
