ActiveAdmin.register Order do
  filter  :user_id,
          :as => :select,
          :collection => User.all.map{ |u| ["#{u.last_name}, #{u.first_name}", u.id] }

  index do
    id_column
    column :user_id do | u |
      user = User.find(u.user_id)
      "#{user.last_name}, #{user.first_name}"
    end
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :user_id,
              :as => :select,
              :collection => User.all.map{ |u| ["#{u.last_name}, #{u.first_name}", u.id] }
    end
    f.buttons
  end

  show do | order |
    attributes_table do
      items = OrderItem.where("order_id=?", order.id)

      row :id
      row :user_id do
        user = User.find(order.user_id)
        link_to("#{user.first_name} #{user.last_name}", admin_user_path(order.user_id))
      end
      row "ORDER ITEMS" do
        ordered = items.map { | item |
          product = Product.find(item.product_id)
          link_to("#{item.quantity} x #{product.name} - #{number_to_currency product.price, :unit => " &euro;"}".html_safe, admin_order_item_path(item.id))
        }
        ordered.join('<br />').html_safe
      end
      row "TOTAL" do
        sum = 0.0
        items.each do | item |
          sum += Product.find(item.product_id).price * item.quantity
        end
        number_to_currency sum, :unit => " &euro;"
      end

      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
