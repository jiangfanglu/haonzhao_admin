require 'nokogiri'
class Updater 
  class << self
    
    def add_all_products
      documents = []
      Product.where(status: true).each do |product| 
        nokogiri = Nokogiri::HTML(product.meta_description)
        documents << {id: product.product_id, name: product.name, model: product.model, description: nokogiri.text.gsub(/[\r\n]+/,' ')}
      end
      solr.add documents
      solr.commit
      # solr.update data: '<commit/>'
    end
    
    def delete_all_products
      solr.delete_by_query '*:*'
      solr.commit
      # solr.update data: '<commit/>'
    end
    
    def update_all_products
      delete_all_products
      add_all_products
    end
    
    def add_product product_id
      product = Product.find product_id
      nokogiri = Nokogiri::HTML(product.meta_description)
      solr.add id: product.product_id, name: product.name, model: product.model, description: nokogiri.text.gsub(/[\r\n]+/,' ')
      solr.commit
      # solr.update data: '<commit/>'
    end
    
    def delete_product product_id
      solr.delete_by_id product_id
      solr.commit
      # solr.update data: '<commit/>'
    end
    
    def update_product product_id
      delete_product product_id
      add_product product_id
    end
        
    def update_categories
      
    end
    
    def update_category category
      
    end
    
    def solr
      @solr ||= RSolr.connect :url =>"#{SOLR}/solr/product"
    end
    
  end
end
