class BoardPresenter
    def initialize(boards = nil, current_user = nil)
      @boars = boards
      @current_user = current_user
    end
  
    def edit_role?
        @current_user.roles.exists?(name: ["admin", "editor"])
    end
  
    # Add other presentation methods as needed
  end