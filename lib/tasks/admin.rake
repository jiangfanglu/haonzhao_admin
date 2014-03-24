namespace :admin do
  
  task init: :environment do
    
    User.where('email like ?', '%@1shoo.com').each do |user|
      admin = Admin.find_by_email user.email
      admin = Admin.create(user.attributes.merge({password: user.password, salt: user.customer.salt})) unless admin
      k = user.attributes.merge({password: user.password, salt: user.customer.salt})
      p k
      # admin.attributes.merge({salt: user.customer.salt})
      # admin.save
    end
    
  end
  
end
