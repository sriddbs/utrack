class Base
  def failure(message, object=nil, status=422)
    puts object.inspect
    OpenStruct.new(success: false, message: message, object: object)
  end

  def success(message, object)
    OpenStruct.new(success: true, message: message, object: object)
  end
end
