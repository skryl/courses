DIR = '/Users/skryl/Desktop'

module BIO
  extend self

  def read(path)
    content = File.readlines("#{DIR}/#{path}").map(&:strip)

    content.map do |line|
      if sequence?(line)
        line.split(//)
      elsif numeric?(line)
        line.to_i
      else line
      end
    end

    content.length == 1 ? content.first : content
  end

  def write(path, content)
    content = \
      case content
      when Array  then content.join
      when String then content
      else content.to_s
      end

    file.write("#{DIR}/#{path}", content)
  end

private

  def format_input(content)
  end

  def numeric?(str)
    Float(str) != nil rescue false
  end

  def sequence?(str)
    %w(A G T C).any? { |c| str.include?(c) }
  end

end
