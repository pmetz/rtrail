module RTrail
  module Helpers
    # ----------------
    # Class methods
    # ----------------

    # Allow `include` to pull in both class and instance methods
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def has_post(*actions)
        actions.each do |action|
          define_method(action) do |data|
            kind = self.class.basename
            puts "in POST #{action}_#{kind}/#{self.id}, data = #{data.inspect}"
            #return client.post("#{action}_#{kind}")
          end
        end
      end
    end

    # ----------------
    # Instance methods
    # ----------------

    # Return true if `name_or_id` appears to be a numeric id,
    # false otherwise.
    def is_id?(name_or_id)
      # Use !! to convert regex comparison to boolean
      return !!(name_or_id.to_s =~ /^[0-9]+$/)
    end

    # Return an HTTP path with parameters appended in GET syntax.
    def path_with_params(path, params={})
      if params.empty?
        return path
      else
        # FIXME: What if value contains a space?
        param_string = params.map do |k,v|
          "#{k}=#{v}"
        end.join("&")
        return path + "&" + param_string
      end
    end

    # Include this in any Entity with a `created_on` attribute
    # to allow getting creation date as a Time instance.
    module HasCreateTime
      def create_time
        return Time.at(self[:created_on].to_i).utc
      end
    end
  end # module Helpers
end # module RTrail

