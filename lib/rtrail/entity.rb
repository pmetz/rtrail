require_relative 'helpers'

module RTrail
  # Base class for RTrail objects
  class Entity
    include Helpers

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

    def initialize(id_or_data)
      if id_or_data.is_a?(Hash)
        @data = Hashie::Mash.new(id_or_data)
      else
        @data = fetch(id_or_data)
      end
    end
    attr_accessor :data

    # Fetch data for a derived class object.
    def fetch(id)
      return client.get("get_#{self.class.basename}/#{id}")
    end

    # Pass-through to Hashie::Mash for attribute access
    def method_missing(meth, *args, &block)
      return data.send(meth, *args, &block)
    end

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

