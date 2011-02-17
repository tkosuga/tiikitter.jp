module ErrorHelper
  
  def yield_with_logging
    yield
  rescue => e
    logger.error(e)
  end
  
end
