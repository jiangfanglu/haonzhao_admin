module CodeLib

  def valied_code? code
    create_code(code[0..11]) == code
  end

  def create_code code
    code += Digest::MD5.hexdigest(code + self::KEY).first(4)
  end

end