module ActsAsFilterable
  module Util

    def self.rails32? ; rails_version == '3.2' ; end
    def self.rails40? ; rails_version == '4.0' ; end
    def self.rails41? ; rails_version == '4.1' ; end
    def self.rails42? ; rails_version == '4.1' ; end

    def self.rails_version ; ::Rails.version.split('.')[0,2].join('.') ; end

  end
end
