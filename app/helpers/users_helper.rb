require 'rubygems'
require 'nokogiri'
require 'open-uri'

module UsersHelper
  def getClassesNums()
    # classAbrs = ['ACCT','AERO','ANTH','AE','ARCH',
      # 'ART','AVN', 'BIOI','BIOL','BMI', 'BLST','BRCT',
      # 'BSAD','CHEM', 'CHIN', 'CIVE', 'CIST', 'COMM','CEEN',
      # 'CSCI','CONE','CNST','COOP','COUN', 'CRCJ',
      # 'DSGN','ECON','EDL', 'EDUC', 'ELEC', 'EMGT',
      # 'ENGR','ENGL', 'ENVE', 'ENVN', 'FNBK', 'FSMT',
      # 'FSCI', 'FLNG','FREN', 'GEOG','GEOL','GERM', 'GERO',
      # 'GDRH', 'HED', 'HPER','HEBR','HIST', 'HONR', 'HORT',
      # 'HUMN','ILUN', 'IPD','ITIN','IASC', 'ISQA', 'INST',
      # 'JAPN', 'JOUR','LATN','LLS',  'LAWS', 'MGMT',  'MKT',
      # 'MFAW','MATH', 'MTCH', 'MENG','MILS',  'MUS',
      # 'NAMS', 'NSCI', 'NEUR', 'PHIL', 'PE','PEA',
      # 'PHYS', 'PSCI', 'PSYC', 'PA', 'RELU', 'RLS',
      # 'RELI', 'RUSS', 'SOWK','SOC','SPAN', 'SPED','SPCH','STAT',
      # 'TED','THEA','US', 'UBNS', 'WGST', 'WRWS']
    # url = "http://www.unomaha.edu/class-search/"
    # numList = Array.new
    # termNum = "1151"
    # classAbrs.each do |classAbr|
      # url = "http://www.unomaha.edu/class-search/?term="+ termNum + "&session=&subject=" + classAbr + "&catalog_nbr=&career=&instructor=&class_start_time=&class_end_time=&location=&special=&instruction_mode="
      # doc = Nokogiri::HTML(open(url))
      # doc.search('//div/h2').each do |h2|
        # str = h2.content
        # if(str != "Contact Us")
          # stuff = str.strip.split("\s")
          # notneeded = stuff.shift
          # addToList = stuff.shift
          # if !numList.include?(addToList)
          # numList.push(addToList)
          # end
        # end
      # end
    # end
    # numList
   end
end

