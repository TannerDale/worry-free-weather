module ParamValidator
  def present?(key)
    return if params[key].present?

    raise ActionController::BadRequest, "No #{key} provided"
  end

  def all_present?(keys)
    missing = keys.reject { |key| params[key].present? }

    return if missing.empty?

    raise ActionController::BadRequest, "Missing #{missing.to_sentence} field(s)"
  end
end
