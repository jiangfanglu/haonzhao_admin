xml.mo(:version=>"1.0.0") do
  xml.head do
    xml.businessType("PRODUCT_RECORD")
  end
  xml.body do
    xml.productRecordList do
      @products.each do |product|
        xml.productRecord do
          xml.jkfSign do
            xml.companyCode(HZ_COMPANY_CODE)
            xml.businessNo(product.product_id)
            xml.businessType("PRODUCT_RECORD")
            xml.declareType("1")
            xml.note("备注")
          end
          xml.productRecordDto do
            xml.companyCode(HZ_COMPANY_NO) #电商平台备案取得的唯一标示
            xml.companyName(HZ_COMPANY_NAME)
            xml.postTaxNo(product.hz_product.post_tax_no) #海关10位行邮税号, 见参数表
            xml.goodsType(product.hz_product.hz_post_tax.item_category)
            xml.goodsName(product.product_description.name)
            xml.barCode(product.hz_product.barcode) #optional
            xml.brand(product.shop.name) #optional
            xml.goodsModel(product.model) #optional
            xml.mainElement(product.hz_product.main_elements) #optional
            xml.purpose(product.hz_product.hz_purpose_code) #optional
            xml.standards(product.hz_product.standard) #optional
            xml.productionEnterprise(product.shop.name) #optional
            xml.productionCountry(product.shop.hz_manufacturer.hz_country.code) #optional
            xml.licenceKey("") #optional
            xml.categoryCode("1234567890") #optional
            xml.materialAddress(product.hz_product.material_address) #指国检要求提交的产品备案材料，此处指材料的片地址, optional
            xml.declareTimeStr(Time.new.strftime("%Y-%m-%d %H:%M:%S")) ##optional yyyy-MM-dd HH:mm:ss
          end
        end
      end
    end
  end
end