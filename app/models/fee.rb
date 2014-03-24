class Fee < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :fee_type, :rate, :service_type
  
  has_many :services
  
  SERVICE_TYPE = {
    'third-party payment' => 1,
    'fine' => 14
  }
  
end
