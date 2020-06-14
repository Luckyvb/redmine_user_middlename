require 'user_middlename/patches/user_patch'

module UserMiddlename
  def self.apply_patch
    ::User.send :include, Patches::UserPatch
  end
end
