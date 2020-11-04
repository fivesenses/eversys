# frozen_string_literal: true

module Eversys
  class Machine < Eversys::Base
    def machines
      response = @client.get("machines")
      handle_error(response: response)
      process(response: response)
    end

    def machine(machine_id:)
      response = @client.get("machines/#{machine_id}")
      puts response.body.class
      handle_error(response: response)
      process(response: response).first
    end

    def by_group(group_id:)
      response = @client.get("group/#{group_id}/machines")
      handle_error(response: response)
      process(response: response)
    end
  end
end
