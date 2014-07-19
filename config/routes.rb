HaonzhaoAdmin::Application.routes.draw do


  resources :products do
    member do
      get :inactive, :active
    end
    collection do
      get :newp, :attributes
    end
  end

  resources :custom_categories
  resources :template_to_shops

  resources :template_categories

  resources :templates

  resources :shippings

  resources :shipping_options
  
  resources :orders do
    member do
      get :cancel
    end
  end

  # resources :products do
  #   member do
  #     get :inactive, :active
  #   end
    
  # end

  resources :profiles

  resources :profile_groups

  resources :profile_values

  resources :coupon_products

  resources :categories do
    collection do
      get :edit_attributes, :new_attribute_group, :edit_attribute_group, :show_attribute_group, :edit_attribute, :destroy_attribute
      post :create_attribute_group, :update_attribute_group
      patch :create_attribute, :update_attribute
    end
  end

  resources :available_custom_categories


  resources :certificates

  resources :promotions

  resources :coupons

  resources :vouchers

  resources :featured_shops

  resources :featured_products

  resources :category_groups do
    
    collection do
      delete :destroy
    end
  end

  resources :transact do
    collection do
      get :paid_by_shop, :unpaid_by_shop, :create_settlement, :settlement, :settlements
      post :complete_settlement
      patch :update_settlement
    end
  end
  
  resources :shops do
    collection do
      get :close, :allow, :login
      post :login_check
    end
  end
  
  resources :transactions do
    
    collection do
      get :shop, :shops, :pay, :unpay, :paid_with_shop, :unpaid_with_shop
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'shops#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
