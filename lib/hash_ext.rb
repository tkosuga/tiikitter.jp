class Hash
  #
  # 配列に変換されたマップを返します。
  # 返された配列は数字の値でソートされています。
  #　数字以外の値、空の値は除外されます。
  #
  def to_order_sorted_array
    to_a.reject{|v| 
      v[0].blank? || v[1].blank? || !v[1].is_a?(Numeric)
    }.sort{|a, b|
     (b[1] <=> a[1])
    }
  end
end