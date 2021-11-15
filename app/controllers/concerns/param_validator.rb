module ParamValidator
  def present?(key)
    return if params[key].present?

    raise ActionController::BadRequest, "No #{key} provided"
  end
end
