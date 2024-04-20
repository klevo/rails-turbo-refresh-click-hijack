["One", "Two", "Three"].each do |name|
  Item.find_or_create_by!(name:)
end
