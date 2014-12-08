module PrimEngine
  module Filters
    # Apply filters specified in the request params to a Participant.
    class Participant
      MATCH_QUERY_KEYS = %w(
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
      RANGE_QUERY_KEYS = %w(
        participants.date_of_birth.date
      )

      def initialize(request_params)
        @request_params = request_params
      end

      def filter(participants)
        filtered = apply_match_queries(participants)

        apply_range_queries(filtered)
      end

      private

      def apply_match_queries(relation, query_keys = MATCH_QUERY_KEYS)
        return relation if query_keys.count == 0

        filtered = filter_matches_by(relation, query_keys.first)
        filtered = filter_negations_by(filtered, query_keys.first)

        apply_match_queries(filtered, query_keys[1..-1])
      end

      def apply_range_queries(relation, query_keys = RANGE_QUERY_KEYS)
        return relation if query_keys.count == 0

        filtered = filter_ranges_by(relation, query_keys.first)

        apply_range_queries(filtered, query_keys[1..-1])
      end

      # Returns an ActiveRecord::Relation. Either the original relation, or one
      # filtered according to the query_key.
      # query_key will look like 'participants.emails.email'
      def filter_matches_by(relation, query_key)
        # the value to be matched
        query_value = @request_params.fetch(query_key, nil)

        return relation if query_value.nil?

        _p, association, query_attribute = query_key.split('.')
        association_class = association.singularize.classify.constantize
        # an ActiveRecord::Relation matching the query
        matches = association_class.where(query_attribute => query_value)

        relation.joins(association.to_sym).merge(matches)
      end

      def filter_negations_by(relation, query_key)
        key = "#{ query_key }.neq"
        query_value = @request_params.fetch(key, nil)

        return relation if query_value.nil?

        _p, association, query_attribute, _op = key.split('.')
        association_class = association.singularize.classify.constantize
        # an ActiveRecord::Relation matching the query
        matches = association_class.where.not(query_attribute => query_value)

        relation.joins(association.to_sym).merge(matches)
      end

      def filter_ranges_by(relation, query_key)
        %w( lt lteq gt gteq ).reduce(relation) do |filtered, operation|
          key = "#{ query_key }.#{ operation }"
          query_value = @request_params.fetch(key, nil)

          if query_value.nil?
            filtered
          else
            _p, association, query_attribute, _op = key.split('.')
            association_class = association.singularize.classify.constantize
            condition = association_class
                        .arel_table[query_attribute]
                        .send(operation, query_value)
            # an ActiveRecord::Relation matching the query
            matches = association_class.where(condition)

            filtered.joins(association.to_sym).merge(matches)
          end
        end
      end
    end
  end
end
