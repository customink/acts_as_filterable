
class ContactDetail < ActiveRecord::Base
  filter_for_digits :phone_number, :fax_number
end

class User < ActiveRecord::Base
  filter_for_digits    :phone_number
  filter_for_lowercase :handle
end

