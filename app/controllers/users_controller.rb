require 'json'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @pageNum = 0
    session[:activate] = 1
    #@users = User.all
    myList = [["A",1],["B"],2]
    @classList = myList
    render "index.html.erb"
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def prefsPage
    total = 0
    UnoClass.all.each do |uno_class|
      if uno_class.sessionId.to_s == request.session_options[:id].to_s
      total = total + 1
      end
    end
    if total == 0
      @notice = "You must enter at least one class"
      render "index.html.erb"
    else
      render "prefsPage"
    end
  #render "prefsPage"
  end

  def nextPage
    session[:page_num] = params[:myAction].to_i
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
    session[:calendars] = getCalendars()
    @calendars = session[:calendars]
    if(@pageNum > @calendars.length)
      @pageNum = @calendars.length
    end
    if(@calendars.length == 0)
      session[:message] = "No class combinations could be found"
      render "index.html.erb"
    else
      setCalendarVars(@calendars, @pageNum)
      render "nextPage"
    end
  end

  def setCalendarVars(cals, page)
    page = page - 1
    resetVars()
    currentClass = 0
    cals[page].each do |c|
      startDate = ""
      endDate = ""
      if(c[1] != "TBA")
        c[1] = addTimeIfNecessary(c[1])
        c[2] = addTimeIfNecessary(c[2])
      startDate = c[3]
      endDate = c[3]
      allDay = false
      else
        c[1] = "12:00"
        c[2] = "12:00"
        startDate = "2001-1-1"
        endDate = "2099-1-1"
        allDay = true
        c[4] = c[4] + " - Online"
      end
      if(currentClass == 0)
        @title1 = c[0] + " " + c[4]
        @start1 = startDate + " " + c[1] + ":00"
        @end1 = endDate + " " + c[2] + ":00"
        @allDay1 = allDay
      elsif currentClass == 1
        @title2 = c[0] + " " + c[4]
        @start2 = startDate + " " + c[1] + ":00"
        @end2 = endDate + " " + c[2] + ":00"
        @allDay2 = allDay
      elsif currentClass == 2
        @title3 = c[0] + " " + c[4]
        @start3 = startDate + " " + c[1] + ":00"
        @end3 = endDate + " " + c[2] + ":00"
        @allDay3 = allDay
      elsif currentClass == 3
        @title4 = c[0] + " " + c[4]
        @start4 = startDate + " " + c[1] + ":00"
        @end4 = endDate + " " + c[2] + ":00"
        @allDay4 = allDay
      elsif currentClass == 4
        @title5 = c[0] + " " + c[4]
        @start5 = startDate + " " + c[1] + ":00"
        @end5 = endDate + " " + c[2] + ":00"
        @allDay5 = allDay
      elsif currentClass == 5
        @title6 = c[0] + " " + c[4]
        @start6 = startDate + " " + c[1] + ":00"
        @end6 = endDate + " " + c[2] + ":00"
        @allDay6 = allDay
      elsif currentClass == 6
        @title7 = c[0]  + " " + c[4]
        @start7 = startDate + " " + c[1] + ":00"
        @end7 = endDate + " " + c[2] + ":00"
        @allDay7 = allDay
      elsif currentClass == 7
        @title8 = c[0] + " " + c[4]
        @start8 = startDate + " " + c[1] + ":00"
        @end8 = endDate + " " + c[2] + ":00"
        @allDay8 = allDay
      elsif currentClass == 8
        @title9 = c[0] + " " + c[4]
        @start9 = startDate + " " + c[1] + ":00"
        @end9 = endDate + " " + c[2] + ":00"
        @allDay9 = allDay
      elsif currentClass == 9
        @title10 = c[0] + " " + c[4]
        @start10 = startDate + " " + c[1] + ":00"
        @end10 = endDate + " " + c[2] + ":00"
        @allDay10 = allDay
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
    theseCals = getCalendarsRecursive(allClasses, Array.new, allCalendars)
    filterCals = filterCalendars(theseCals)
    p filterCals
    filterCals
  #printArrayRec(allCalendars, 0)
  end

  def filterCalendars(theseCals)
    list = Array.new
    prefs = Array.new
    Preference.all.each do |c|
      if c.sessionid.to_s == request.session_options[:id].to_s
        pr = Array.new
        pr.push(c.kind)
        pr.push(c.startTime.strftime("%H:%M"))
        if(c.kind == 3)
          pr.push(c.endTime.strftime("%H:%M"))
        end
        pr.push(getDate(c.day))
      prefs.push(pr)
      end
    end
    valid = true
    theseCals.each do |c|
      toAdd = Array.new
      c.each do |cl|
        thisValid = isValid(cl, prefs)
        if thisValid == false
        break
        else
        prefs.push(thisValid)
        toAdd.push(cl)
        end
      end
      if(!toAdd.empty?)
      list.push(toAdd)
      end
    end
    list
  end

  def isValid(c, prefs)
    valid = true
    prefs.each do |pref|
      if pref.fetch(0) == 1
        if(pref.fetch(2)  == c.fetch(3))
          t1 = Time.parse(pref.fetch(1))
          t2 = Time.parse(c.fetch(1))
          if t2 < t1
          valid = false
          break
          end
        end
      end
      if pref.fetch(0) == 2
        if(pref.fetch(2)  == c.fetch(3))
          t1 = Time.parse(pref.fetch(1))
          t2 = Time.parse(c.fetch(2))
          if t2 > t1
          valid = false
          break
          end
        end
      end
      if pref.fetch(0) == 3
        if(pref.fetch(3)  == c.fetch(3))
          prefT1 = Time.parse(pref.fetch(1))
          prefT2 = Time.parse(pref.fetch(2))
          cT1 = Time.parse(c.fetch(2))
          cT2 = Time.parse(c.fetch(2))
          if (cT1 > prefT1 && cT1 < prefT2) || (cT2 > prefT1 && cT2 < prefT2)
          valid = false
          break
          end
          if(cT1 < prefT1 && cT2 > prefT2)
          valid = false
          break
          end
        end
      end
    end
    if(valid)
      puts "Valid"
      pref = Array.new
    pref.push(3)
    pref.push(c.fetch(1))
    pref.push(c.fetch(2))
    pref.push(c.fetch(3))
    return pref
    else
      puts "Not Valid"
    end
    valid
  end

  def getDate(day)
    ret = ""
    if(day == "M")
      ret = "2001-01-01"
    elsif (day == "T")
      ret = "2001-01-02"
    elsif (day == "W")
      ret = "2001-01-03"
    elsif (day == "R")
      ret = "2001-01-04"
    elsif (day == "F")
      ret = "2001-01-05"
    elsif (day == "Sa")
      ret = "2001-01-06"
    elsif (day == "Su")
      ret = "2001-01-07"
    end
    ret
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
        newDate = Date.strptime('2001-01-01', '%Y-%m-%d')
        individualClassGroup = Array.new
        for i in 1..5
          if(newDate.wday == 1)
            if c[3].include? "M"
              thisClass = Array.new
            thisClass.push(c[0])
            thisClass.push(c[1])
            thisClass.push(c[2])
            thisClass.push(newDate.to_s)
            thisClass.push(c[4])
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
            thisClass.push(c[4])
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
            thisClass.push(c[4])
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
            thisClass.push(c[4])
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
            thisClass.push(c[4])
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
      sectionList = Array.new
      individualClass.push(classDep + " " + classNumber)
      doc.search('//th').each do |tr|
        str = tr.content
        if(str.include? "Section")
        sectionList.push(str)
        end
      end
      currentSection = 0
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
          individualClass.push(sectionList[currentSection])
          currentSection = currentSection + 1
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