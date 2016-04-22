class Exports::EntriesController < PrivateController

  def index
    @storage = @account.storages.find(params[:storage_id])
    @objects = @storage.entries
    respond_to do |format|
      format.csv do
        data = CSV.generate do |csv|
          entries = @objects.as_json
          p entries
          break if entries.empty?
          csv << entries.first.keys
          entries.each{|e| csv << e.values}
        end
        send_data data, :filename => "#{@storage.name}.csv"
      end
    end
  end

end

