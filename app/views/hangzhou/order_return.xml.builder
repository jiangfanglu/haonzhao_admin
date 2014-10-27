xml.instruct!
xml.mo(:version=>"1.0.0") do
  xml.head do
    xml.businessType("IMPORT_ORDER_RETURN")
  end
  xml.body do
    xml.goodsReturnModuleList do
      #@orders.each do |order|
        xml.goodsReturnModule do
          xml.jkfSign do
            xml.companyCode(HZ_COMPANY_NO)
            xml.businessNo(@order.order_sn)
            xml.businessType("IMPORT_ORDER_RETURN")
            xml.declareType("1")
            xml.note("")
          end
          xml.goodsReturn do
            xml.appCode("") #退货申报编号
            xml.orderNo(@order.order_sn)
            xml.wayBillNo(@order.hz_order.way_bills)
            xml.eCommerceCode(HZ_ECOMMERCE_COMPANY_NO)
            xml.eCompanyCode(HZ_ECOMMERCE_COMPANY_NAME)
            xml.internalAreaCompanyNo("") #仓储企业代码
            xml.declareCompanyCode(HZ_COMPANY_NO)
            xml.returnWayBillNo("") #退货运单号
            xml.declareTimeStr(Time.new.strftime("%Y-%m-%d %H:%M:%S"))
            xml.customsField(@order.hz_order.customsField)
            xml.declPort(@order.hz_order.decl_port)
            xml.packType(@order.hz_order.package_type)
            xml.packNo(@order.order_products.collect{|t| t.quantity}.inject{|sum,x| sum + x })
            xml.mainGName(@order.order_products.collect{|t| t.name}.join(","))
          end
          n=1
          xml.goodsReturnDetails do
            @order.order_products.each do |product|
              xml.goodsReturnDetail do
                xml.goodsOrder(n)
                xml.codeTs(product.hz_product.post_tax_no)
                xml.goodsItemNo(product.product_id)
                xml.goodsName(product.product.product_description.name)
                xml.goodsModel(product.product.model)
                xml.originCountry(product.product.shop.hz_manufacturer.hz_country_code)
                xml.tradeCurr(@order.hz_order.currency_code)
                xml.tradeTotal(@order.total)
                xml.declarePrice(product.price)
                xml.declareTotalPrice(product.total)
                xml.useTo(product.hz_product.hz_purpose_code)
                xml.declareCount(product.quantity)
                xml.goodsUnit(product.hz_product.unit_code)
                xml.goodsGrossWeight(product.product.weight)
              end
              n+=1
            end
          end
        end
      #end
    end
  end
end