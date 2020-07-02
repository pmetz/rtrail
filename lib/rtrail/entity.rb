require_relative 'helpers'

module RTrail
  # Base class for RTrail objects
  class Entity
    include Helpers

    # FIXME: Find a better way to do this hinky @@client stuff
    class << self
      def client=(client)
        @@client = client
      end

      def client
        @@client
      end

      # Return the plain lowercase name of the derived class,
      # ex. "project", "suite", "case", suitable for passing
      # to the `get_*` API methods.
      def basename
        return self.name.downcase.gsub(/^.*::/, '')
      end
    end

    def client
      return self.class.client
    end

    # Create a new Entity with the given field data.
    #
    # @param [Hash, Entity] data
    #   Field values to store in the Entity instance, or an
    #   Entity instance to clone.
    #
    def initialize(data={})
      if data.is_a?(Hash)
        @data = Hashie.new(data)
      elsif data.is_a?(Entity)
        @data = Hashie.new(data.data)
      else
        raise ArgumentError.new("data must be a Hash or Entity.")
      end
    end
    attr_accessor :data

    # Pass-through to Hashie::Mash for attribute access
    def method_missing(meth, *args, &block)
      if data.respond_to?(meth)
        return data.send(meth, *args, &block)
      else
        super
      end
    end

    # TODO: Factor these out into helper modules

    # Return a list of entities retrieved from `get_<thing>s/<id>`.
    def get_entities(klass, parent_id, params={})
      path = path_with_params(
        "get_#{klass.basename}s/#{parent_id}", params)

      return client.get(path).map do |data|
        klass.new(data)
      end
    end

    # Add a new entity by invoking POST `add_<thing>/<id>`.
    def add_entity(klass, parent_id, params={})
      path = "add_#{klass.basename}/#{parent_id}"
      return klass.new(client.post(path, params))
    end
  end
end # module RTrail

