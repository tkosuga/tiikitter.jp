module CommandHelper
  
  def yield_with_termination
    yield
    exit(0)
  rescue => e
    logger.error(e)
    exit(1)
  end  
  
end
