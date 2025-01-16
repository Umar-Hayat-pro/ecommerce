class Admin::TenantsController < AdminController
  def index
    @tenants = (Admin.select("id, email, 'Admin' AS role") +
                User.select("id, email, 'User' AS role")).sort_by(&:id)
  end
end
