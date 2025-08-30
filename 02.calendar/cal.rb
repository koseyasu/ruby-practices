#!/usr/bin/env ruby

require 'optparse'
require 'date'

params = ARGV.getopts("m:y:")

if params["y"] == nil
  cal_year = Date.today.year
else
  cal_year = params["y"].to_i
end

if params["m"] == nil
  cal_month = Date.today.month
else
  cal_month = params["m"].to_i
end

firstday = Date.new(cal_year,cal_month,1)
lastday = (firstday.next_month(1)-1).day

day_of_week = ["日","月","火","水","木","金","土"]
firstday_of_week = firstday.wday
display_area = firstday_of_week + lastday

if display_area > 35
  cal_row = 7
elsif display_area > 28
  cal_row = 6
else
  cal_row = 5
end

cal_blocks = Array.new(cal_row){Array.new(7)}
day_counter = 1

cal_blocks.each_with_index do |row_item,i|
  row_item.each_with_index do |col_item,j|
    if i == 0
      cal_blocks[i][j] = day_of_week[j] 
    elsif i == 1
      if j < firstday_of_week
        cal_blocks[i][j] = "  "
      else
        cal_blocks[i][j] = format("%2d",day_counter)
        day_counter += 1
      end
    else
      cal_blocks[i][j] = format("%2d",day_counter) if day_counter <= lastday
      day_counter += 1
    end
  end
end

display_width = 20
puts "#{cal_month}月 #{cal_year}".center(display_width)
cal_blocks.each{|e| puts e.join " "}
