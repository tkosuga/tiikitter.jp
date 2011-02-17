class Array
  def count(&action)
    ret = 0
    self.each { |v| ret = ret + 1 if action.call(v) }
    ret
  end
end