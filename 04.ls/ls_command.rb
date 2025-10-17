# frozen_string_literal: true

DISPLAY_MAX_COLUMNS = 3

def list_files(params)
  params.include?('-a') ? Dir.entries('.').sort : Dir.glob('*')
end

def round_to_specified_size(length, round_num)
  ((length + round_num) / round_num) * round_num
end

def build_columns(lists, columns)
  display_rows = (lists.length.to_f / columns).ceil
  lists.fill('', lists.length, display_rows * columns - lists.length)
  lists.each_slice(display_rows).to_a.transpose
end

def display_list_files(params)
  files = list_files(params)
  return if files.empty?

  max_length = files.map(&:length).max
  build_columns(files, DISPLAY_MAX_COLUMNS).each do |row|
    puts row.map { |f| f.ljust(round_to_specified_size(max_length, 8)) }.join
  end
end

params = ARGV
display_list_files(params)
