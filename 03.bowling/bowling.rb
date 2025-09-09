#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  shots << if s == 'X'
             10
           else
             s.to_i
           end
end

point = 0
spare_point = 0
frames_counter = 1
throw_in_frame = 1

shots.each_with_index do |shot, i|
  if frames_counter < 10
    if throw_in_frame == 1 && shot == 10
      point = point + 10 + shots[i + 1] + shots[i + 2]
      frames_counter += 1
    elsif throw_in_frame == 2
      spare_point = shots[i + 1] if (shots[i - 1] + shot) == 10
      point = point + shots[i - 1] + shot + spare_point
      frames_counter += 1
      throw_in_frame = 1
      spare_point = 0
    else
      throw_in_frame = 2
    end
  elsif frames_counter == 10
    point += shot
  end
end
puts point
