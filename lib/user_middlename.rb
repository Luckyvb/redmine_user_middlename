require 'user_middlename/patches/user_patch'

module UserMiddlename
  def self.apply_patch
    ::User.send :include, Patches::UserPatch
  end

end

class ExtendedProfileHook  < Redmine::Hook::ViewListener
  #render_on :view_sidebar_author_box_bottom, :partial => 'author'
  #render_on :view_account_left_bottom,       :partial => 'user'
  #render_on :view_my_account,                :partial => 'account'
end
