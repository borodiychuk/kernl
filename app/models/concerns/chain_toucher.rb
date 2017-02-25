module ChainToucher
  extend ActiveSupport::Concern

  included do
    after_create  :chain_touch_callback
    after_save    :chain_touch_callback
    after_destroy :chain_touch_callback
    after_touch   :chain_touch_callback
  end

end
