require_dependency 'application_helper'

module UserMiddlename
  module Patches
    module UserPatch

      # The available user formats are stored in User::USER_FORMATS (app/models/user.rb)
      # We cannot modify User::USER_FORMATS, as it's a constant
      # Therefore we define an own hash which will be merged with USER_FORMATS
      User::USER_FORMATS[:lastname_firstname_middlename] = {
          :string => '#{lastname} #{firstname} #{middlename}',
          :order => %w(lastname firstname login id),
          :setting_order => 4.1
        }
      User::USER_FORMATS[:lastname_firstname_middleinitial] = {
          :string => '#{lastname} #{firstname} #{middlename.to_s.chars.first}.',
          :order => %w(lastname firstname login id),
          :setting_order => 4.2
        }
      User::USER_FORMATS[:lastname_firstinitial_middleinitial] = {
          :string => '#{lastname} #{firstname.to_s.chars.first}.#{middlename.to_s.chars.first}.',
          :order => %w(lastname firstname login id),
          :setting_order => 4.3
        }
      User::USER_FORMATS[:lastname_comma_firstname_middlename] = {
          :string => '#{lastname}, #{firstname} #{middlename}',
          :order => %w(lastname firstname login id),
          :setting_order => 6.1
        }
      User::USER_FORMATS[:lastname_comma_firstname_middleinitial] = {
          :string => '#{lastname}, #{firstname} #{middlename.to_s.chars.first}.',
          :order => %w(lastname firstname login id),
          :setting_order => 6.2
        }
      User::USER_FORMATS[:lastname_comma_firstinitial_middleinitial] = {
          :string => '#{lastname}, #{firstname.to_s.chars.first}.#{middlename.to_s.chars.first}.',
          :order => %w(lastname firstname login id),
          :setting_order => 6.3
        }

      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          #alias_method :name_formatter_without_middlename, :name_formatter
          #alias_method :name_formatter, :name_formatter_with_middlename
        end
      end

      module InstanceMethods
        def middlename
          setting = Setting.plugin_user_middlename
          Rails.logger.info setting
          fid = setting['field_id'] #setting['field_id'].nil? ? setting[:default]['field_id'] : setting['field_id']
          # look for our custom field in the database
          if !fid.blank?
            cf = CustomField.where(["id = ?", 1]).first
            if cf
              # get the value for the custom field (the method is provided by act_as_customizable behavior plugin)
              custom_value_for(cf)
            end
          end
        end

        private

      end

    end
  end
end
