class XmlstatusController < ApplicationController
  def index
    @keg = Keg.find :last
    respond_to do |format|
       format.xml {render :xml => @keg.to_xml }
    end
  end

end
