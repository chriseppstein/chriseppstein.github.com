# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'rubypants'

include Nanoc3::Helpers::LinkTo

class Date
  def to_gm_time
    to_time(new_offset, :gm)
  end

  def to_local_time
    to_time(new_offset(DateTime.now.offset-offset), :local)
  end

  private
  def to_time(dest, method)
    #Convert a fraction of a day to a number of microseconds
    usec = (dest.sec_fraction * 60 * 60 * 24 * (10**6)).to_i
    Time.send(method, dest.year, dest.month, dest.day, dest.hour, dest.min,
              dest.sec, usec)
  end
end

class PageAdapter
  def initialize(item)
    @item = item
  end
  def attempt(meth, *args, &block)
    if respond_to?(meth)
      send(meth, *args, &block)
    else
      nil
    end
  end
  def method_missing(meth, *args, &block)
    if args.size == 0 && !@item[meth].nil?
      @item[meth] || @item[meth.to_s]
    elsif @item.respond_to?(meth)
      @item.send(meth, *args, &block)
    else
      super
    end
  end
  def respond_to?(meth)
    @item[meth] || @item[meth.to_s] || @item.respond_to?(meth)
  end
  def date
    if @item.identifier =~ %r{^/posts/(\d{4})-(\d{2})-(\d{2})-(.*)/$}
      DateTime.parse("#{$1}/#{$2}/#{$3}")
    end
  end
end

def page
  PageAdapter.new(@item)
end

def rp(value)
  RubyPants.new(value).to_html
end

def blog_posts
  @items.select do |item|
    item.identifier =~ %r{^/posts/(\d{4})-(\d{2})-(\d{2})-(.*)/$}
  end.map do |item|
    PageAdapter.new(item)
  end
end

def full_url(path)
  path = path.rep_named(:default).path if path.is_a?(PageAdapter)
  "http://chriseppstein.github.com#{path}"
end

def absolute_url(input)
  input.gsub(/(href|src)(\s*=\s*)(["'])(\/.*?)\3/) { $1 + $2 + $3 + "http://chriseppstein.github.com" + $4 + $3 }
end

