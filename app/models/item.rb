class Item < ApplicationRecord
  after_update_commit do
    broadcast_refresh_to :items
  end
end
