ActiveAdmin.register User do

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

  permit_params :id, :first_name, :middle_name, :last_name, :birth_date, :gender, :email, :emergency_contact, :package_id, :joining_date,
                addresses_attributes: [:id, :address_type, :address_line_1, :address_line_2, :city, :state, :zipcode, :_destroy],
                phones_attributes: [:id, :p_type, :p_number, :_destroy]

  menu priority: 4

  index do
    selectable_column
    id_column
    column 'Name' do |u|
      middle_name = u.middle_name.present? ? u.middle_name : ''
      "#{u.first_name} #{middle_name} #{u.last_name}"
    end
    column :birth_date
    column :gender
    column :email
    column :emergency_contact
    actions
  end

  filter :first_name
  filter :middle_name
  filter :last_name
  filter :birth_date
  filter :gender, as: :check_boxes, collection: ['Male', 'Female']
  filter :email

  form decorate: true do |f|
    tabs do
      tab 'Basic info' do
        f.inputs 'User Information' do
          f.input :first_name
          f.input :middle_name
          f.input :last_name
          f.input :birth_date, label: 'Date of Birth', as: :datepicker, datepicker_options: { min_date: "1950-1-1", max_date: Date.today, change_month: true, change_year: true }
          f.input :gender, as: :select, collection: [['Male', 'Male'], ['Female', 'Female']]
          f.input :email
          f.input :emergency_contact
          f.input :package_id, label: 'Packages', as: :radio, collection: Package.all.collect {|p| ["Plan: #{p.membership_plan.plan_name}<br/>&nbsp;&nbsp;&nbsp;&nbsp;Contract Length (in months): #{p.contract_length}<br/>&nbsp;&nbsp;&nbsp;&nbsp;Sign up Fee: #{p.signup_fee}".html_safe, p.id]}
          f.input :joining_date, as: :datepicker, datepicker_options: {'defaultDate': Date.today, change_month: true, change_year: true}
        end
      end
      tab 'Address details' do
        f.inputs 'Address Information' do
          f.has_many :addresses, heading: '', allow_destroy: true, new_record: true do |a|
            a.input :address_type, as: :select, collection: [['Permanent', 'Permanent'], ['Temporary', 'Temporary'], ['Office', 'Office']]
            a.input :address_line_1
            a.input :address_line_2
            a.input :city
            a.input :state
            a.input :zipcode  
          end
        end
      end
      tab 'Contact Details' do
        f.inputs 'Contact Information' do
          f.has_many :phones, heading: '', allow_destroy: true, new_record: true do |p|
            p.input :p_type, as: :select, collection: [['Mobile', 'Mobile'], ['Home', 'Home'], ['Office', 'Office']]
            p.input :p_number
          end
        end
      end
      para "Press cancel to return to the list without saving."
      f.actions
    end
  end

  show do
    attributes_table do
      row :id
      row 'Name' do |u|
        "#{u.first_name} #{u.last_name}"
      end
      row :birth_date
      row :gender
      row :email
      row :emergency_contact
      panel 'Address Details' do
        attributes_table_for user.addresses do
          row :address_type
          row :address_line_1
          row :address_line_2
          row :city
          row :state
          row :zipcode
        end
      end
    end
    active_admin_comments
  end

  sidebar :help, except: [:index, :show] do
    'Fields with * mark are mandatory'
  end

  sidebar 'Dates', only: :show do
    attributes_table_for user do
      row :joining_date
      row 'Subscription End date' do |d|
        d.expiration_date.try(:strftime, "%b %d, %Y")
      end
    end
  end

  sidebar 'Package', only: :show do
    attributes_table_for user.package do
      row 'Plan' do |p|
        p.membership_plan.plan_name
      end
      row 'Contract Length(in months)' do |p|
        p.contract_length
      end
      row :signup_fee
    end
  end

  sidebar 'Contact Details', only: :show do
    table_for user.phones do
      column 'Type' do |p|
        p.p_type
      end
      column 'Number' do |p|
        p.p_number
      end
    end
  end

end
