class Exports::EntriesController < PrivateController
  require "csv"

  def index
    respond_to do |format|
      format.csv do
        data = CSV.generate do |csv|
          entries = @objects.as_json
          break if entries.empty?
          csv << entries.first.keys
          entries.each{|e| csv << e.values}
        end
        send_data data, :filename => "#{@storage.name}.csv"
      end
    end
  end

  def show
    respond_to do |format|
      format.xml do
        builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
          xml.entry do
            @object.values.each do |v|
              xml.send(v.field.identifier, v.exposed_value)
            end
          end
        end
        send_data builder.to_xml, :filename => "#{@storage.name}-#{@object.id}.xml"
      end
    end
  end

  private

  def after_initialize
    @storage = @account.storages.find(params[:storage_id])
    @objects = @storage.entries
    @object  = @objects.find(params[:id]) if params[:id]
  end

end

