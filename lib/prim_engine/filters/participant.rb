module PrimEngine
  module Filters
    # Apply filters specified in the request params to a Participant.
    class Participant
      QUERY_KEYS = %w(
        participants.emails.email
        participants.date_of_birth.date
      )

      def initialize(request_params)
        @request_params = request_params
      end

      def apply_to(participants, query_keys = QUERY_KEYS)
        return participants if query_keys.count == 0

        filtered = filter_matches_by(participants, query_keys.first)

        apply_to(filtered, query_keys[1..-1])
      end

      private

      # Returns an ActiveRecord::Relation. Either the original relation, or one
      # filtered according to the query_key.
      # query_key will look like 'participants.emails.email'
      def filter_matches_by(participants, query_key)
        # the value to be matched
        query_value = @request_params.fetch(query_key, nil)

        return participants if query_value.nil?

        _p, association_name, query_attribute = query_key.split('.')
        association_class = association_name.singularize.classify.constantize
        # an ActiveRecord::Relation matching the query
        matches = association_class.where(query_attribute => query_value)

        participants.joins(association_name.to_sym).merge(matches)
      end
    end
  end
end
