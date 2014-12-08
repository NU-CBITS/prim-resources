module PrimEngine
  module Filters
    # Apply filters specified in the request params to a Participant.
    class Participant
      QUERY_KEYS = %w(
        participants.addresses.name
        participants.addresses.street_1
        participants.addresses.street_2
        participants.addresses.city
        participants.addresses.state
        participants.addresses.zip
        participants.addresses.primary
        participants.phones.name
        participants.phones.number
        participants.phones.primary
        participants.emails.email
        participants.emails.primary
        participants.date_of_birth.date
        participants.name.first_name
        participants.name.last_name
        participants.name.middle_name
        participants.name.prefix
        participants.name.suffix
        participants.gender.value
        participants.ethnicity.value
        participants.race.value
        participants.education_level.value
      )

      def initialize(request_params)
        @request_params = request_params
      end

      def apply_to(participants, query_keys = QUERY_KEYS)
        return participants if query_keys.count == 0

        filtered = filter_matches_by(participants, query_keys.first)
        filtered = filter_negations_by(filtered, query_keys.first)

        apply_to(filtered, query_keys[1..-1])
      end

      private

      # Returns an ActiveRecord::Relation. Either the original relation, or one
      # filtered according to the query_key.
      # query_key will look like 'participants.emails.email'
      def filter_matches_by(relation, query_key)
        # the value to be matched
        query_value = @request_params.fetch(query_key, nil)

        return relation if query_value.nil?

        _p, association_name, query_attribute = query_key.split('.')
        association_class = association_name.singularize.classify.constantize
        # an ActiveRecord::Relation matching the query
        matches = association_class.where(query_attribute => query_value)

        relation.joins(association_name.to_sym).merge(matches)
      end

      def filter_negations_by(relation, query_key)
        key = "#{ query_key }.neq"
        query_value = @request_params.fetch(key, nil)

        return relation if query_value.nil?

        _p, association_name, query_attribute, _op = key.split('.')
        association_class = association_name.singularize.classify.constantize
        # an ActiveRecord::Relation matching the query
        matches = association_class.where.not(query_attribute => query_value)

        relation.joins(association_name.to_sym).merge(matches)
      end
    end
  end
end
