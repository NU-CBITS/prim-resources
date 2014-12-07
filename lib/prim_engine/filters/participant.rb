module PrimEngine
  module Filters
    # Apply filters specified in the request params to a Participant.
    class Participant
      def initialize(request_params)
        @request_params = request_params
      end

      def apply_to(participants)
        match = @request_params.fetch('participants.emails.email', nil)

        return participants if match.nil?

        emails = Email.where(email: match)

        participants.joins(:emails).merge(emails)
      end
    end
  end
end
