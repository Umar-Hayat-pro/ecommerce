class Admin::TenantsController < AdminController
  def index
    @tenants = Admin.with_role + User.with_role
  end
end
