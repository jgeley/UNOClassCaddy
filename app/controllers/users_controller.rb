require 'json'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @pageNum = 0
    #@users = User.all
    myList = [["A",1],["B"],2]
    @classList = myList
    render "index.html.erb"
  end

  def Renderindex
    render "index.html.erb"
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def prefsPage
    render "prefsPage"
  end

  def nextPage
    listString = '{"0":{"allDday":"","title":"TestEvent","id":"821","end": "2014-11-12 14:00:00","start": "2014-11-11 06:00:00"}}'
    listString2 = "[{title:'TestEvent',end: '2014-11-12 14:00:00',start: '2014-11-11 06:00:00'}]"
    if(@pageNum == nil)
      @pageNum = 1
    end
    if (params[:myAction] == "up")
        @pageNum += 1
    end
    if (params[:myAction] == "down")
      if(@pageNum > 0)
        @pageNum -= 1
      end
    end
    calendars = getAllCalendars()
     # @title1 = calendars[0][@pageNum][0]
    # @start1 = '2014-11-11 ' + calendars[0][@pageNum][1]+':00'
    # @end1 = '2014-11-11 '+ calendars[0][@pageNum][2]+':00'   
    render "nextPage"
  end

  def getAllCalendars()
    myList = Array.new
    UnoClass.all.each do |uno_class|
      if uno_class.sessionId.to_s == request.session_options[:id].to_s
        myList.push(uno_class.department.to_s + " " + uno_class.course.to_s )
      end
    end
    term = "1148 Fall 2014"
    termNum = term.strip.split("\s").shift
    result = Array.new
    myList.each do |thisClass|
      classNumberList = thisClass.strip.split("\s")
      classDep = classNumberList.shift
      classNumber = classNumberList.shift
      url = "http://www.unomaha.edu/class-search/?term="+ termNum + "&session=&subject=" + classDep + "&catalog_nbr=" + classNumber + "&career=&instructor=&class_start_time=&class_end_time=&location=&special=&instruction_mode="
      doc = Nokogiri::HTML(open(url))
      classList = Array.new
      time = ""
      days = ""
      location = ""
      individualClass = Array.new
      individualClass.push(classDep + " " + classNumber)
      doc.search('//table/tr/td/table/tr').each do |tr|
        str = tr.content
        if(str.include? "Time")
            time = str.sub("Time","")
        end
        if(str.include? "Days")
            days = str.sub("Days","")
        end
        if(days != "" && time != "")
          
          if(time != "TBA")
            timedata = time.match(/(\d+:\d+).* (\d+:\d+)/)
            timedata.captures
            #startTime = timedata[1]
            #endTime = timedata[2]
            individualClass.push(startTime)
            individualClass.push(endTime)
          else
            individualClass.push("TBA")
            individualClass.push("TBA")
          end
          individualClass.push(days)
          time = ""
          days = ""
          classList.push(individualClass)
          individualClass = Array.new
          individualClass.push(classDep + " " + classNumber)
          
        end
      end
      result.push(classList)
    end
    result

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email)
  end
end