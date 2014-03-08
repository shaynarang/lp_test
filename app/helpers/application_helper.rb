module ApplicationHelper

  def convert_to_hash key_value_pair
    eval(key_value_pair)
  end

end