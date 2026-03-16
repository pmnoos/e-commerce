# Patch for Ruby 3.4 / Solidus 4.6 incompatibility in sign_in_if_change_own_password.
# In Ruby 3.4, warden's internal sign-in flow raises NoMethodError
# ("undefined method 'absolute_path' for an instance of String") when the admin
# changes their own password. The password IS saved correctly — the problem is
# only in the re-authentication step that follows. This patch rescues that error
# and redirects to the admin login page with a success notice instead.

Rails.application.config.after_initialize do
  Spree::Admin::UsersController.class_eval do
    # Remove the original after_action and replace with a patched version.
    skip_after_action :sign_in_if_change_own_password, only: :update

    after_action :sign_in_if_change_own_password_safe, only: :update

    def sign_in_if_change_own_password_safe
      return unless @user == spree_current_user && @user.password.present?

      begin
        sign_in(@user, event: :authentication)
        flash[:success] = Spree.t(:account_updated)
        redirect_to spree.edit_admin_user_path(@user)
      rescue NoMethodError => e
        raise unless e.message.include?("absolute_path")
        # Ruby 3.4 compatibility: password was saved; ask the admin to log in again.
        sign_out spree_current_user
        flash[:success] = "Password updated. Please log in with your new password."
        redirect_to spree.admin_login_path
      end
    end
  end
end
