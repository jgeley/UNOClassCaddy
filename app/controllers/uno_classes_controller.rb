class UnoClassesController < ApplicationController
  before_action :set_uno_class, only: [:show, :edit, :update, :destroy]

  # GET /uno_classes
  # GET /uno_classes.json
  def index
    @uno_classes = UnoClass.all
    #puts "This is a test"
    render "users/index.html.erb"
  end

  # GET /uno_classes/1
  # GET /uno_classes/1.json
  def show
  end

  # GET /uno_classes/new
  def new
    @uno_class = UnoClass.new
  end

  # GET /uno_classes/1/edit
  def edit
  end

  # POST /uno_classes
  # POST /uno_classes.json
  def create
    @uno_class = UnoClass.new(uno_class_params)

    respond_to do |format|
      if @uno_class.save
        format.html { redirect_to action: :index}
      else
        format.html { render action: "new" }
      end
    end
  end

  # PATCH/PUT /uno_classes/1
  # PATCH/PUT /uno_classes/1.json
  def update
    respond_to do |format|
      if @uno_class.update(uno_class_params)
        format.html { redirect_to @uno_class, notice: 'Uno class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @uno_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uno_classes/1
  # DELETE /uno_classes/1.json
  def destroy
    @uno_class.destroy
    respond_to do |format|
      format.html { redirect_to action: :index}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uno_class
      @uno_class = UnoClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uno_class_params
      params.require(:uno_class).permit(:department, :course, :section, :startTime, :endTime, :days, :location, :instructor, :sessionId)
    end
end
