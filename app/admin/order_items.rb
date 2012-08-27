ActiveAdmin.register OrderItem do
  index do
    id_column
    column :order_id
    column :product_id do |item|
      Product.find(item.product_id).name
    end
    column :quantity
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :order_id,
              :as => :select,
              :collection => Order.all.map { |order| order.id }
      f.input :product_id,
              :as => :select,
              :collection => Product.all.map { |product| [product.name, product.id] }
      f.input :quantity
    end
    f.buttons
  end

  show do |order_item|
    attributes_table do
      row :id
      row :order_id do
        link_to(order_item.order_id, admin_order_path(order_item.order_id))
      end
      row :product_id do
        product = Product.find(order_item.product_id)
        link_to("#{product.name}", admin_product_path(order_item.product_id))
      end
      row :quantity
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
