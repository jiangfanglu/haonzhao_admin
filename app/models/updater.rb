require 'nokogiri'
require 'util'
module Updater

  class ProductUpdater
    class << self
      include Util::UpdaterUtils
      
      def add_all
        documents = []
        Product.where(status: true).each do |product| 
          nokogiri = Nokogiri::HTML(product.meta_description)
          documents << {id: product.product_id, name: product.name, model: product.model, description: nokogiri.text.gsub(/[\r\n]+/,' '), product_attribute: product.product_attributes.collect{|t|t.text}, product_attribute_id: product.product_attributes.collect{|t|t.attribute_id}}
        end
        solr.add documents
        solr.commit
      end

      def add id
        product = Product.find id
        nokogiri = Nokogiri::HTML(product.meta_description)
        solr.add id: product.product_id, name: product.name, model: product.model, description: nokogiri.text.gsub(/[\r\n]+/,' '), product_attribute: product.product_attributes.collect{|t|t.text}, product_attribute_id: product.product_attributes.collect{|t|t.attribute_id}
        solr.commit
      end

      def solr
        @solr ||= RSolr.connect :url =>"#{SOLR}/solr/product"
      end
    
    end
  end

  class CategoryUpdater
    class << self
      include Util::UpdaterUtils
    
      def add_all
        documents = []
        Category.where(status: true).each do |category| 
          nokogiri = Nokogiri::HTML(category.meta_description)
          documents << {id: category.category_id, name: category.name, description: nokogiri.text.gsub(/[\r\n]+/,' ')}
        end
        solr.add documents
        solr.commit
      end

      def add id
        category = Category.find id
        nokogiri = Nokogiri::HTML(category.meta_description)
        solr.add id: category.category_id, name: category.name, description: nokogiri.text.gsub(/[\r\n]+/,' ')
        solr.commit
      end
    
      def solr
        @solr ||= RSolr.connect :url =>"#{SOLR}/solr/category"
      end
    
    end
  end
  
  class ShopUpdater
    class << self
      include Util::UpdaterUtils
      
      def add_all
        documents = []
        Shop.where(status: 'Allowed').each do |shop|
          nokogiri = Nokogiri::HTML(shop.profile)
          documents << {id: shop.manufacturer_id, profile: nokogiri.text.gsub(/[\r\n]+/,' '), name: shop.name}
        end
        solr.add documents
        solr.commit
      end
      
      def add id
        shop = Shop.find id
        solr.add id: shop.manufacturer_id, profile: shop.profile, name: shop.name
        solr.commit
      end

      def solr
        @solr ||= RSolr.connect :url =>"#{SOLR}/solr/shop"
      end
      
    end
  end

  class TagUpdater
    class << self
      include Util::UpdaterUtils
      
      def add_all
        documents = []
        Tag.all.each do |tag|
          documents << {id: tag.id, name: tag.name, taggable_id: tag.taggable_id, taggable_type: tag.taggable_type}
        end
        solr.add documents
        solr.commit
      end
      
      def add id
        tag = Tag.find id
        solr.add id: tag.id, name: tag.name, taggable_id: tag.taggable_id, taggable_type: tag.taggable_type
        solr.commit
      end

      def solr
        @solr ||= RSolr.connect :url =>"#{SOLR}/solr/tag"
      end
      
    end
  end
  
end

