class BoardPresenter
    def initialize(current_user = nil)
      @current_user = current_user
    end
  
    def edit_role?
        @current_user.roles.exists?(name: ["admin", "editor"])
    end
  
    # def as_json ... 


  end