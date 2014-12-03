# Methods for request specs.
module RequestHelpers
  def json
    @json ||= JSON.parse(response.body)
  end
end
