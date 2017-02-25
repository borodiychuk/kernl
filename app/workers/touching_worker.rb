# Touching an object may be really expensive because of the nested callbacks,
# so it makes sense to make it asyncronous
class TouchingWorker
  include Sidekiq::Worker

  def perform class_name, id
    logger.debug "* Performing async touch of #{class_name} ##{id}"
    object = class_name.constantize.find_by_id id
    object.touch if object
  end

end
