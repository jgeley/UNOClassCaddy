require 'rubygems'
require 'nokogiri'
require 'open-uri'

module ApplicationHelper
  def getClasses(listOfStuff)
    url = "http://www.unomaha.edu/class-search/"
    final = ""
    class1 = "CSCI 1620"
    class2 = "CIST 1400"
    class3 = "MATH 1960"
    class4 = "SPCH 1110"
    class5 = "ART 1010"
    term = listOfStuff.shift
    termNum = term.strip.split("\s").shift
    #termArray = Array.new
    doc = Nokogiri::HTML(open(url))
    # doc.css('//select[@id="term"]/option').each do |node|
    # termArray.push("" + node.attr('value') +" "+ node.text)
    # end
    map = "content"
    allClasses = Array.new
    listOfStuff.each do |thisClass|
      classNumberList = thisClass.strip.split("\s")
      classDep = classNumberList.shift
      classNumber = classNumberList.shift
      url = "http://www.unomaha.edu/class-search/?term="+ termNum + "&session=&subject=" + classDep + "&catalog_nbr=" + classNumber + "&career=&instructor=&class_start_time=&class_end_time=&location=&special=&instruction_mode="
      doc = Nokogiri::HTML(open(url))
      classList = Array.new
      classList.push(classDep + " " + classNumber)
      time = ""
      days = ""
      location = ""
      doc.search('//table/tr/td/table/tr').each do |tr|
        if(location == "" || days == "" || time == "")
          str = tr.content
          if(str.include? "Time")
            time = str.sub("Time","")
          end
          if(str.include? "Days")
            days = str.sub("Days","")
          end
          if(str.include? "Location")
            location = str.sub("Location","")
          end
        else
          classList.push(Schoolclass.new(time,days,location))
          time = ""
          days = ""
          location = ""
        end
      end
      allClasses.push(classList)
    end
    allClasses
  end
end

