module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_device

    def connect
      self.current_device = find_verified_device
      current_device.connected!
    end

    def disconnect
      return if current_device.nil?

      current_device.disconnected!
    end

    private

    def find_verified_device
      if (verified_device = Device.find_by(id: cookies.encrypted[:device_id]))
        verified_device
      else
        reject_unauthorized_connection
      end
    end
  end
end
