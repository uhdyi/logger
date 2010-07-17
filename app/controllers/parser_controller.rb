class ParserController < ApplicationController
  filter_access_to :all

  def index
    respond_to do |format|
      format.html
      format.xml 
    end
  end

  def parse_csv

    parts = Hash.new
    serials = Hash.new
    serial_loc = Hash.new
    loc = Hash.new
    sta = Hash.new
    dup = Hash.new
    nilSerial = Hash.new
    dup_pro = Hash.new
    index = 0
    loc_error = Array.new

    file = File.new(params['csv_file'], "r")
    while(line = file.gets)
      
      p = line.split(',')
      index = index +1

      description = p[0].strip
      part_number = p[1].strip
      serial_number = p[2].strip
      if !p[3].nil?
        location= p[3].strip
      else
        location = ''
      end
      if !p[4].nil?
        loc_detail = (p[4].strip).capitalize
      else
        loc_detail = ''
      end
      if !p[5].nil?
        status = (p[5].strip).downcase
      else
        status = ''
      end
      if !p[6].nil?
        status_note = (p[6].strip).downcase
      else
        status_note = ''
      end
      if !p[7].nil?
        loc_code = (p[7].strip).upcase
      else
        loc_code = ''
      end

      # for product table
      if !parts.has_key?(part_number) and part_number.length > 0
        parts[part_number] = description
      else
        if part_number.length > 0
          dup_pro[part_number] = serial_number + '/' + description
        else
          dup_pro['N/A'] = serial_number + '/' + description
        end
      end

      # for location table
      # if !loc.has_value?(location) and location.length > 0
      #  loc[serial_number] = location 
      # end
      if location.length > 0
        loc[index] = {
          "name" => location,
          "detail" => loc_detail,
          "code" => loc_code
        }
      end

      # for status table
      if !sta.has_value?(status) and status.length > 0
         sta[serial_number] = status
      end
      
      # for serails table
      if !serials.has_key?(serial_number) and serial_number.length > 0
        serials[serial_number] = {
          "part_number" => part_number,
          "location" => location,
          "status" => status
        }
      else 
        if serial_number.length > 0
          dup[serial_number] = part_number + '/' +location + '/'+ loc_detail + ' *** ' + serials[serial_number]["part_number"] + '/' + serials[serial_number]["location"]
        else 
          dup['N/A'] = part_number + '/' + location + '/' + loc_detail
        end
      end
      
    end
    file.close       

    pr = Product.new(:part_number => 'N/A', :description => 'N/A')
    pr.save
    parts.each { |key, value|
      pr = Product.new(:part_number => key, :description => value)
      pr.save
    }

    serials.each { |key, value|
      
      if serials[key]["part_number"].empty?
        product_id = 1
      else
        if Product.find_by_part_number(serials[key]["part_number"]).nil?
          nilSerial[key] = value["part_number"]
          product_id = 0
        else 
          product_id = Product.find_by_part_number(serials[key]["part_number"]).id
        end
      end
      
      if !product_id.nil?
        se = Serial.new(:serial_number => key, :product_id => product_id)
        se.save
      end
    }

    # comment out this one because of the mis-spelling  
    lo = Location.new(:name => 'N/A',:detail => 'N/A', :code => 'N/A') # id = 1
    lo.save
    loc.each { |key, value|
      lo = Location.new(:name => value["name"], :detail => value["detail"], :code => value["code"])
      lo.save
    }

    st = Status.new(:name => 'N/A')  # id = 1
    st.save
    sta.each { |key, value|
      st = Status.new(:name => value)
      st.save
    }

    sta_note = ''
    serials.each { |key, value|
      se_loc = serials[key]["location"]
      if se_loc.empty?
        loc_id = 1
      else
        tmp = Location.find_by_name(se_loc)
        if tmp.nil?
          loc_error << se_loc
        else 
          loc_id = tmp.id
        end
      end

      se_sta = serials[key]["status"]
      if se_sta.empty?
        sta_id = 1
      else 
        sta_id = Status.find_by_name(se_sta).id
        # sta_note += 'key=' + key + ' status=' + se_sta + ' <br> ' 
      end

      # the following works only if you setup a user in User table with user id set to 1, and 
      # ussually the first user in the table is admin. 
      user_id = 1
      en = Entry.new(:location_id => loc_id, :user_id => user_id, :status_id => sta_id)      

      if Serial.find_by_serial_number(key).nil?
        serial_id = 0
      else
        serial_id = Serial.find_by_serial_number(key).id
      end
      log = Log.new(:serial_id => serial_id)

      log.entries << en
      en.log_id = log.id

      log.save
      en.save
    }

    fout = File.open("/home/dan/projects/hoanalog/excels/dup.txt", "w")
    dup.each { |key, value|
      fout.puts key + ' : ' + value
    }

    # fout.puts '========'

    # nilSerial.each {|key, value|
    #  fout.puts key + ' : ' + value
    # }

    # fout.puts '========'

    # dup_pro.each { |key, value|
    #  fout.puts key + ' : ' + value
    # }
    fout.close

    flash[:notice] = "Successfully parse data into database."
    redirect_to(:action => "index")
  end
  
end
