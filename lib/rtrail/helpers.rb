module RTrail
  module Helpers
    # Return true if `name_or_id` appears to be a numeric id,
    # false otherwise.
    def is_id?(name_or_id)
      return name_or_id.to_s =~ /^[0-9]+$/
    end

    # Return an HTTP path with parameters appended in GET syntax.
    def path_with_params(path, params={})
      if params.empty?
        return path
      else
        param_string = params.map do |k,v|
          "#{k}=#{v}"
        end.join("&")
        return path + "&" + param_string
      end
    end

  end # module Helpers
end # module RTrail

