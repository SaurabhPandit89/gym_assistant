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

  permit_params :id, :first_name, :middle_name, :last_name, :birth_date, :gender, :email, :emergency_contact,
                addresses_attributes: [:id, :address_type, :address_line_1, :address_line_2, :city, :state, :zipcode, :_destroy]

  index do
    selectable_column
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

  form do |f|
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
        end
      end
      tab 'Address details' do
        f.inputs 'Address Information' do
          f.has_many :addresses, heading: '', allow_destroy: true, new_record: false do |a|
            a.input :address_type, as: :select, collection: [['Permanent', 'Permanent'], ['Temporary', 'Temporary'], ['Office', 'Office']]
            a.input :address_line_1
            a.input :address_line_2
            a.input :city
            a.input :state
            a.input :zipcode
          end
        end
      end
      para "Press cancel to return to the list without saving."
      f.actions
    end
  end

  sidebar :help, except: [:index, :show] do
    'Fields with * mark are mandatory'
  end

end
