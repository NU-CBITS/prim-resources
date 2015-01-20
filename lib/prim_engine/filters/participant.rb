module PrimEngine
  module Filters
    # Apply filters specified in the request params to a Participant.
    class Participant
      EQUALITY_QUERIES = %w(
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
        participants.consent_form.expires_on
        participants.consent_form.study_number
        participants.consent_form.source
        participants.consent_form.version
      )
      RANGE_QUERIES = %w(
        participants.date_of_birth.date
        participants.consent_form.expires_on
        participants.consent_form.signed_at
      )
      STRING_MATCH_QUERIES = %w(
        participants.addresses.name
        participants.addresses.street_1
        participants.addresses.street_2
        participants.addresses.city
        participants.addresses.state
        participants.addresses.zip
        participants.phones.name
        participants.phones.number
        participants.emails.email
        participants.name.first_name
        participants.name.last_name
        participants.name.middle_name
        participants.name.prefix
        participants.name.suffix
        participants.gender.value
        participants.ethnicity.value
        participants.race.value
        participants.education_level.value
        participants.consent_form.content
        participants.consent_form.study_number
        participants.consent_form.source
        participants.consent_form.version
      )

      def initialize(request_params)
        @request_params = request_params
      end

      def filter(participants)
        %w(
          apply_equality
          apply_range
          apply_matches
        ).reduce(participants) { |filtered, m| send(m, filtered) }
      end

      private

      def apply_equality(relation)
        EQUALITY_QUERIES.reduce(relation) do |filtered, query_key|
          filter_by filtered, query_key, %w( eq not_eq )
        end
      end

      def apply_range(relation)
        RANGE_QUERIES.reduce(relation) do |filtered, query_key|
          filter_by filtered, query_key, %w( lt lteq gt gteq )
        end
      end

      def apply_matches(relation)
        STRING_MATCH_QUERIES.reduce(relation) do |filtered, query_key|
          filter_by filtered, query_key, %w( matches does_not_match ),
                    ->(query_value) { "%#{ query_value }%" }
        end
      end

      def filter_by(relation, query_key, operations,
                    decorate_query_value = ->(v) { v })
        operations.reduce(relation) do |filtered, op|
          query_value = @request_params.fetch("#{ query_key }.#{ op }", nil)

          next filtered if query_value.nil?

          association, query_attribute = query_key.split('.')[1, 2]
          association_class = association.singularize.classify.constantize
          condition = association_class.arel_table[query_attribute]
                      .send(op, decorate_query_value.call(query_value))
          # an ActiveRecord::Relation matching the query
          matches = association_class.where(condition)

          filtered.joins(association.to_sym).merge(matches)
        end
      end
    end
  end
end
