module Profiles::EmployeeProfileHelper

  def list_of_orders(type)
    case type
    when "Bartender"
      bartender_orders_path
    when "Cook"
      cook_orders_path
    when "Waiter"
      waiter_orders_path
    else
      root_path
    end
  end


end
