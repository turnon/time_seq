require 'active_support/core_ext/integer/time'

class TimeSeq < DelegateClass(Enumerator::Lazy)

  class << self

    alias_method :init, :new
    private :init

    def new(opt={})
      init(nil).instance_eval do
        extract opt
        build_enum
      end
    end
  end

  Attrs = %w{from step to}.tap do |attrs|
    attrs.each do |attr|
      attr_accessor attr
      private attr + '='
    end
  end

  def inspect
    "#<#{self.class}:#{object_id} #{inspect_attrs}>"
  end

  private

  def extract(opt={})
    Attrs.each do |attr|
      send(attr + '=', opt[attr] || opt[attr.to_sym])
    end
  end

  def build_enum
    @e = Enumerator.new do |yielder|
      time_point = from
      loop do
        yielder << time_point
        time_point = step.since time_point
        break if to and time_point > to
      end
    end.lazy
    __setobj__ @e
  end

  def inspect_attrs
    Attrs.map do |attr|
      value = send attr
      value ? "@#{attr}=#{value.inspect}" : nil
    end.compact.join ', '
  end

end

require 'time_seq/version'
