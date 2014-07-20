module RTrail
  module Methods
    # Add a `get_<entity>/:id` wrapper to any class.
    module Get
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        # Get data for the entity with the given ID, and return a new
        # Entity subclass instance.
        # Wraps `GET get_<entity>/<id>`
        #
        def get(entity_id)
          entity_data = client.get("get_#{self.basename}/#{entity_id}")
          return self.new(entity_data)
        end
      end
    end # module Get

    module Update
      # Update TestRail with local changes to this Entity.
      # Wraps `POST update_<entity>/<id>`
      #
      # @param [Hash] fields
      #   Individual fields to update. If omitted, the data currently
      #   stored in the local Entity instance is posted.
      #
      def update(fields={})
        fields = @data.merge(fields)
        client.post("update_#{self.class.basename}/#{self.id}", fields)
      end
    end # module Update

    module Delete
      # Delete this Entity from TestRail.
      # Wraps `POST delete_<entity>/<id>`.
      #
      def delete
        client.post("delete_#{self.class.basename}/#{self.id}")
      end
    end # module Delete

    module Close
      def close
        client.post("close_#{self.class.basename}/#{self.id}")
      end
    end # module Close
  end
end # module RTrail

