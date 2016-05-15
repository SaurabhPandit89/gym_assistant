ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel 'Subscription expiring in next 30 days' do
          table_for User.expiring_subscription.order('expiration_date asc') do
            column ('ID')   {|user| link_to user.id, admin_user_path(user)}
            column ('Name') {|user| "#{user.first_name} #{user.last_name}"}
            column ('Membership Plan') {|user| user.membership_plan.plan_name}
            column ('Package (in Months)') {|user| "#{user.package.contract_length} "}
            column ('Date of Joning') {|user| user.joining_date.try(:strftime, "%b %d, %Y")}
            column ('Subscription End Date') {|user| user.expiration_date.try(:strftime, "%b %d, %Y")}
            column ('Days Remaining') {|user| (user.expiration_date.to_date - Date.today).to_i}
          end
        end
      end
    end

    columns do
      column do
        panel 'Recently joined Members' do
          table_for User.recently_added.order('created_at desc').limit(10) do
            column ('ID')   {|user| link_to user.id, admin_user_path(user)}
            column ('Name') {|user| "#{user.first_name} #{user.last_name}"}
            column ('Membership Plan') {|user| user.membership_plan.plan_name}
            column ('Package (in Months)') {|user| "#{user.package.contract_length} "}
            column ('Date of Joning') {|user| user.joining_date.try(:strftime, "%b %d, %Y")}
            column ('Subscription End Date') {|user| user.expiration_date.try(:strftime, "%b %d, %Y")}
          end
        end
      end

      column do
        panel "Members&nbsp|&nbsp;#{link_to 'Add new member', new_admin_user_path}".html_safe do
          table_for '' do
            column ('Recently Added') {User.recently_added.count}
            column ('Subscription Expiring') {User.expiring_subscription.count}
            column ('Active') {User.all.count}
          end
        end
      end

      # column do
      #   panel 'Plans' do
      #     ul do
      #       MembershipPlan.all.map do |mp|
      #         li link_to mp.plan_name, admin_membership_plan_path(mp)
      #       end
      #     end
      #   end
      # end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
