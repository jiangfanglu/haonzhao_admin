xml.mo(:version=>"1.0.0") do
  xml.head do
    xml.businessType("PRODUCT_RECORD")
  end
  xml.body do
    xml.productRecordList do
      xml.productRecord do
        xml.jkfSign do
          xml.companyCode("发送方海关十位数编码")
          xml.businessNo("业务编码")
          xml.businessType("PRODUCT_RECORD")
          xml.declareType("1")
          xml.note("备注")
        end
        xml.productRecordDto do
          xml.companyCode("电商平台编号") #电商平台备案取得的唯一标示
          xml.companyName("电商平台名称")
          xml.postTaxNo("行邮税号") #海关10位行邮税号, 见参数表
          xml.goodsType("商品类别")
          xml.goodsName("商品名称")
          xml.barCode("条形码") #optional
          xml.brand("品牌") #optional
          xml.goodsModel("规格型号") #optional
          xml.mainElement("主要成份") #optional
          xml.purpose("用途") #optional
          xml.standards("适用标准") #optional
          xml.productionEnterprise("生产企业") #optional
          xml.productionCountry("生产国") #optional
          xml.licenceKey("许可证号") #optional
          xml.categoryCode("类目编码") #optional
          xml.materialAddress("材料地址") #指国检要求提交的产品备案材料，此处指材料的片地址, optional
          xml.declareTimeStr("申请时间") ##optional
        end
      end
    end
  end
end