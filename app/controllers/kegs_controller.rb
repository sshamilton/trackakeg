require 'rubygems'
require 'RMagick'
#require 'RMagick'
include Magick
class KegsController < ApplicationController

  before_filter :lookup_keg, :except => [:show, :index, :new, :create, :show_latest, :show_stats]
  def index
    respond_to do |format|
      format.html
      format.iphone   # action.iphone.erb
    end

  end

  def show
    @keg = Keg.last.kegweight
    respond_to do |format|
      format.iphone do  # action.iphone.erb
        render :layout => false
      end
    end
  end

  def show_latest

    kegempty = 700.0
    kegfull = 825.0
    graphmin = 0
    graphmax = 200.0
    kegtotal = kegfull-kegempty
    kegweight = Keg.last.kegweight
    @kegaverage = Keg.average :kegweight
    #Normalize it
    kegvalue = kegweight - kegempty
    kegpercent = kegvalue/kegtotal * 100.0
    #Now correct for the number of ellipses needed
    kegvalue = kegvalue * (graphmax/(kegfull-kegempty))
    #f = Image.new(100,100) { self.background_color = "red" }
    kegimage = Magick::Image.read('Cornelius_Keg.jpg').first
     # width, height, x, y, text
    gc = Draw.new
    gc.opacity("50%")
    gc.fill('#CCB000')
    # x, y, width, height, start degrees, end degrees
    (1..kegvalue).each do |i|
      height = 256-i
      gc.ellipse(54, height, 45, 12, 0, 360)
    end

    pints = 40.0*kegpercent/100.0
    if (kegpercent > 50)
	subvalue = 300
    else
	subvalue = 200
    end
    akeg = Magick::Image.read('Cornelius_Keg.jpg').first
    gc.draw(akeg)
    kt = Draw.new
    kt.annotate(akeg, 50, 40, 30, (subvalue-kegvalue), pints.round.to_s + " Pints left") {
    self.font_family = 'Helvetica'
    self.fill = 'black'
    self.stroke = 'transparent'
    self.pointsize = 14
    self.font_weight = BoldWeight
    self.gravity = NorthGravity
   }
    kt.annotate(akeg, 50, 40, 35, ((subvalue+20)-kegvalue), kegpercent.round.to_s + "%") {
    self.font_family = 'Helvetica'
    self.fill = 'black'
    self.stroke = 'transparent'
    self.pointsize = 20
    self.font_weight = BoldWeight
    self.gravity = NorthGravity
    }
    keg = kegimage.composite(akeg, 0, 0, OverCompositeOp)
    #gc.draw(akeg)

    #gc.draw(akeg)
    send_data(akeg.to_blob,  :disposition => 'inline', :type => 'image/jpeg')

  end
  def show_stats

    @keg = Keg.last
    @kegaverage = Keg.average :kegweight
    respond_to do |format|
      format.iphone do  # action.iphone.erb
        render :layout => false
      end
    end

  end
  def new
    @keg = Keg.new
  end
  
  def create
    @keg = Keg.new(params[:keg])
    if @keg.save
      redirect_to :action=> 'show', :id => @keg
    else
      render :action => 'new'
    end
  end
  
  protected
  def lookup_keg
    @keg = Keg.find(params[:id])

  end

end
