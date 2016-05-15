ActiveAdmin.register MembershipPlan do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :id, :plan_name, :plan_description,
                packages_attributes: [:id, :contract_length, :signup_fee, :_destroy]

  menu priority: 3

  index do
    selectable_column
    column :plan_name
    column :plan_description
    column 'Packages' do |mp|
      table_for mp.packages do
        column :contract_length
        column :signup_fee
      end
    end
    actions
  end

  filter :plan_name

  form decorate: true do |f|
    tabs do
      tab 'Membership Plan' do
        f.inputs 'Plan Details' do
          f.input :plan_name
          f.input :plan_description
        end
      end
      tab 'Packages' do
        f.inputs 'Package details' do
          f.has_many :packages, heading: '', allow_destroy: true, new_record: true do |p|
            p.inputs :contract_length
            p.inputs :signup_fee
          end
        end
      end
    end
    para "Press cancel to return to the list without saving."
    f.actions
  end

  show do
    attributes_table do
      row :plan_name
      row :plan_description
    end
    active_admin_comments
  end

  sidebar 'Packages', only: :show do
    table_for membership_plan.packages do
      column "Contract Length(in months)" do |p|
        p.contract_length
      end
      column :signup_fee
    end
  end

end
