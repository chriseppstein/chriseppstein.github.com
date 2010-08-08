# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'rubypants'

include Nanoc3::Helpers::LinkTo

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
      @item[meth]
    elsif @item.respond_to?(meth)
      @item.send(meth, *args, &block)
    else
      super
    end
  end
  def respond_to?(meth)
    @item[meth] || @item.respond_to?(meth)
  end
  def date
    if @item.identifier =~ %r{^/posts/(\d{4})-(\d{2})-(\d{2})-(.*)/$}
      Date.parse("#{$1}/#{$2}/#{$3}")
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
