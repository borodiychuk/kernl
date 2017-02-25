module AsyncTouchable
  extend ActiveSupport::Concern

  included do

    # Asyncronous touch
    def touch!
      TouchingWorker.perform_async self.class.name, id
    end

  end

end
