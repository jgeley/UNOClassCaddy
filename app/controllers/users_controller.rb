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
    session[:page_num] = params[:myAction].to_i
    puts "\n\n\n\n\n\n\nSession Page Num"
    puts session[:page_num]
    if(session[:page_num]== nil)
      session[:page_num]= 1
    end
    if(params[:myAction].to_i < 1)
      session[:page_num] = 1
    end
    @pageNum = session[:page_num]
    if(session[:calendars] == nil)
      session[:calendars] = getCalendars()
    end
    @calendars = session[:calendars]
    setCalendarVars(@calendars, @pageNum)
    render "nextPage"
  end
  
  def setCalendarVars(cals, page)
    resetVars()
    currentClass = 0
    puts "Setting page to " + page.to_s
    cals[page].each do |c|
      c[1] = addTimeIfNecessary(c[1])
      c[2] = addTimeIfNecessary(c[2])
      if(currentClass == 0)
        @title1 = c[0]
        @start1 = c[3].to_s + " " + c[1] + ":00"
        @end1 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 1
        @title2 = c[0]
        @start2 = c[3].to_s + " " + c[1] + ":00"
        @end2 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 2
        @title3 = c[0]
        @start3 = c[3].to_s + " " + c[1] + ":00"
        @end3 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 3
        @title4 = c[0]
        @start4 = c[3].to_s + " " + c[1] + ":00"
        @end4 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 4
        @title5 = c[0]
        @start5 = c[3].to_s + " " + c[1] + ":00"
        @end5 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 5
        @title6 = c[0]
        @start6 = c[3].to_s + " " + c[1] + ":00"
        @end6 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 6
        @title7 = c[0]
        @start7 = c[3].to_s + " " + c[1] + ":00"
        @end7 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 7
        @title8 = c[0]
        @start8 = c[3].to_s + " " + c[1] + ":00"
        @end8 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 8
        @title9 = c[0]
        @start9 = c[3].to_s + " " + c[1] + ":00"
        @end9 = c[3].to_s + " " + c[2] + ":00"
      elsif currentClass == 9
        @title10 = c[0]
        @start10 = c[3].to_s + " " + c[1] + ":00"
        @end10 = c[3].to_s + " " + c[2] + ":00"
      end
      currentClass = currentClass + 1
    end
  end
  
  def addTimeIfNecessary(time)
    timedata = time.match(/(\d+):(\d+)/)
    timedata.captures
    hour = timedata[1].to_i
    minuite = timedata[2].to_i
    if hour < 8
      hour = hour + 12
    end
    ret = hour.to_s + ":" + minuite.to_s
    ret
  end
  
  def resetVars()
    @title1 = nil
    @end1 = nil
    @start1 = nil
    @title2 = nil
    @end2 = nil
    @start2 = nil
    @title3 = nil
    @end3 = nil
    @start3 = nil
    @title4 = nil
    @end4 = nil
    @start4 = nil
    @title5 = nil
    @end5 = nil
    @start5 = nil
    @title6 = nil
    @end6 = nil
    @start6 = nil
    @title7 = nil
    @end7 = nil
    @start7 = nil
    @title8 = nil
    @end8 = nil
    @start8 = nil
    @title9 = nil
    @end9 = nil
    @start9 = nil
    @title10 = nil
    @end10 = nil
    @start10 = nil
  end

  def getCalendars()
    classes = getAllClasses()
    calendadrs = Array.new
    allClasses = splitClasses(classes)
    allCalendars = Array.new
    getCalendarsRecursive(allClasses, Array.new, allCalendars)
    #printArrayRec(allCalendars, 0)
  end

  def getCalendarsRecursive(classes, currentCalendar, allCalendars)
    # puts "All calendars"
    # p allCalendars
    if classes.length == 0
      return allCalendars
    end
    classes[0].each do |section|
      sectionLength = section.length
      section.each do |c|
        currentCalendar.push(c)
      end
      if(classes.length == 1)
        #@allTheseCalendars = allCalendars
        copy = Array.new(currentCalendar)
        allCalendars.push(copy)
      else
        newArray = getCalendarsRecursive(classes[1..-1], currentCalendar, allCalendars)
      end
      for i in 1..sectionLength
        currentCalendar.pop
      end
    end
    return allCalendars
  end

  def splitClasses(classes)
    allClasses = Array.new
    classes.each do |myClass|
      classGroup = Array.new
      myClass.each do |c|
        newDate = Date.strptime('2018-01-01', '%Y-%m-%d')
        individualClassGroup = Array.new
        for i in 1..5
          if(newDate.wday == 1)
            if c[3].include? "M"
              thisClass = Array.new
              thisClass.push(c[0])
              thisClass.push(c[1])
              thisClass.push(c[2])
              thisClass.push(newDate.to_s)
            individualClassGroup.push(thisClass)
            end
          end
          if(newDate.wday == 2)
            if c[3].include? "T"
              thisClass = Array.new
              thisClass.push(c[0])
              thisClass.push(c[1])
              thisClass.push(c[2])
              thisClass.push(newDate.to_s)
            individualClassGroup.push(thisClass)
            end
          end
          if(newDate.wday == 3)
            if c[3].include? "W"
              thisClass = Array.new
              thisClass.push(c[0])
              thisClass.push(c[1])
              thisClass.push(c[2])
              thisClass.push(newDate.to_s)
            individualClassGroup.push(thisClass)
            end
          end
          if(newDate.wday == 4)
            if c[3].include? "R"
              thisClass = Array.new
              thisClass.push(c[0])
              thisClass.push(c[1])
              thisClass.push(c[2])
              thisClass.push(newDate.to_s)
            individualClassGroup.push(thisClass)
            end
          end
          if(newDate.wday == 5)
            if c[3].include? "F"
              thisClass = Array.new
              thisClass.push(c[0])
              thisClass.push(c[1])
              thisClass.push(c[2])
              thisClass.push(newDate.to_s)
            individualClassGroup.push(thisClass)
            end
          end
          newDate = newDate + 1
        end
        classGroup.push(individualClassGroup)
      end
      allClasses.push(classGroup)
    end
    allClasses
  end

  def getAllClasses()
    myList = Array.new
    UnoClass.all.each do |uno_class|
      if uno_class.sessionId.to_s == request.session_options[:id].to_s
        myList.push(uno_class.department.to_s + " " + uno_class.course.to_s )
      end
    end
    term = "1151 Spring 2015"
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
          startTime = timedata[1]
          endTime = timedata[2]
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