class KegsController < ApplicationController
  before_action :set_keg, only: [:show, :edit, :update, :destroy]

  # GET /kegs
  # GET /kegs.json
  def index
    @kegs = Keg.all
  end

  # GET /kegs/1
  # GET /kegs/1.json
  def show
  end

  # GET /kegs/new
  def new
    @keg = Keg.new
  end
 
  def show_latest
    keg = Keg.first.kegimage
    #keg.to_blob
    send_data(keg.to_blob,  :disposition => 'inline', :type => 'image/jpeg')
    #render :text => keg.to_blob

  end

  # GET /kegs/1/edit
  def edit
  end

  # POST /kegs
  # POST /kegs.json
  def create
    @keg = Keg.new(keg_params)

    respond_to do |format|
      if @keg.save
        format.html { redirect_to @keg, notice: 'Keg was successfully created.' }
        format.json { render action: 'show', status: :created, location: @keg }
      else
        format.html { render action: 'new' }
        format.json { render json: @keg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kegs/1
  # PATCH/PUT /kegs/1.json
  def update
    respond_to do |format|
      if @keg.update(keg_params)
        format.html { redirect_to @keg, notice: 'Keg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @keg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kegs/1
  # DELETE /kegs/1.json
  def destroy
    @keg.destroy
    respond_to do |format|
      format.html { redirect_to kegs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keg
      @keg = Keg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keg_params
      params.require(:keg).permit(:kegweight, :kegtemp)
    end
end
