xml.mo(:version=>"1.0.0") do
  xml.head do
    xml.businessType("PERSONAL_GOODS_DECLAR")
  end
  xml.body do
    xml.goodsDeclareModuleList do
      @orders.each do |order|
        xml.goodsDeclareModule do
          xml.jkfSign do
            xml.companyCode(HZ_COMPANY_NO)
            xml.businessNo(order.order_sn)
            xml.businessType("PERSONAL_GOODS_DECLAR")
            xml.declareType("1")
            xml.note("") #can be null
          end
          xml.goodsDeclare do
            xml.accountBookNo("") #optional
            xml.ieFlag("I")
            xml.preEntryNumber("预录入号码")
            xml.importType("0") #0：一般进口, 1：保税进口
            xml.inOutDateStr("") #格式：2014-02-18 20:33:33
            xml.iePort(order.hz_order.ie_port) #见参数表
            xml.destinationPort(order.hz_order.destination_port) #见参数表
            xml.trafName("运输工具名称") #包括字母和数字.可以填写中文.转关时填写@+16位转关单号. optional
            xml.voyageNo("运输工具航次(班)号") #新增，包括字母和数字，可以有中文. optional
            xml.trafMode(order.hz_order.tranf_mode) #参照运输方式代码表(TRANSF)
            xml.declareCompanyType("个人委托电商企业申报") #个人委托电商企业申报;个人委托物流企业申报;个人委托第三方申报
            xml.declareCompanyCode(HZ_COMPANY_NO) #指委托申报单位代码
            xml.declareCompanyName(HZ_COMPANY_NAME) #指委托申报单位名称
            xml.eCommerceCode(HZ_ECOMMERCE_COMPANY_NO) 
            xml.eCommerceName(HZ_ECOMMERCE_COMPANY_NAME)
            xml.orderNo(order.order_sn)
            xml.wayBill(order.hz_way_bills.collect{|wb| wb.way_bill_no}.join(","))
            xml.tradeCountry(order.shop.hz_manufacturer.hz_country_code) #参照国别代码表(COUNTRY)
            xml.packNo(order.order_products.sum("oc_order_product.quantity")) #只能有数字
            xml.grossWeight(order.hz_order.gross_weight) 
            xml.netWeight("") #optional
            xml.warpType(order.hz_order.package_type) #参照包装种类代码表
            xml.remark("") #optional
            xml.declPort(order.hz_order.decl_port) #对应参数表
            xml.enteringPerson(order.hz_order.entering_person) #默认9999
            xml.enteringCompanyName(HZ_COMPANY_NAME) #默认9999
            xml.declarantNo("") #optional
            xml.customsField(order.hz_order.customs_field) #对应参数表
            xml.senderName(order.hz_order.sender_name)
            xml.consignee(order.firstname)
            xml.senderCountry(order.hz_order.sender_country) #参数表
            xml.senderCity(order.hz_order.sender_city)
            xml.paperType("0" + order.customer.user.customer_identifications.where("identification_type = '1'").first.identification_type.to_s) #身份证（试点时期）
            xml.paperNumber(order.customer.user.customer_identifications.where("identification_type = '1'").first.identification_no)
            #xml.paperType("") #身份证（试点时期）
            #xml.paperNumber("")
            xml.worth(order.total) #只有数字，表体所有商品成交总价的和
            xml.currCode(order.hz_order.currency_code)  #对应参数表
            xml.mainGName(order.order_products.collect{|t| t.name}.join(","))  #可以数字和字母或者中文
            xml.internalAreaCompanyNo("") #optional
            xml.internalAreaCompanyName("") #optional
            xml.applicationFormNo("") #optional
            xml.isAuthorize("1")
          end
          xml.goodsDeclareDetails do
            order.order_products.each do |product|
              xml.goodsDeclareDetail do
                xml.goodsOrder(product.product_id)
                xml.codeTs(product.product.hz_product.post_tax_no)
                xml.goodsItemNo(product.product_id)
                xml.goodsName(product.name)
                xml.goodsModel(product.model)
                xml.originCountry(product.product.shop.hz_manufacturer.hz_country_code) #参照国别代码表(COUNTRY)
                xml.tradeCurr(order.hz_order.currency_code) #参照币制代码表(CURR)
                xml.tradeTotal(order.total) 
                xml.declPrice(product.price)
                xml.declTotalPrice(product.price*product.quantity)
                xml.useTo(product.hz_product.hz_purpose_code) #参照用途代码表
                xml.declareCount(product.quantity)
                xml.goodsUnit(product.hz_product.unit_code) #参照计量单位代码表(UNIT)
                xml.goodsGrossWeight(product.product.weight) #optional
                xml.firstUnit(product.hz_product.unit_code) #optional
                xml.firstCount(product.quantity) #optional
                xml.secondUnit("") #optional
                xml.secondCount("") #optional
                xml.productRecordNo(product.hz_product.record_code) #通过向国检备案获取
                xml.webSite(product.hz_product.url) #optional
              end
            end
          end
        end
      end
    end
  end
end