class Account < ActiveRecord::Base
  acts_as_filterable :lowercase,    :first_name, :last_name
  acts_as_filterable :whitespace,   :first_name, :last_name
  acts_as_filterable :titleization, :first_name, :last_name
  def full_name
    "#{first_name} #{last_name}"
  end
end
