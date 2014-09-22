xml.instruct!
xml.mo(:version=>"1.0.0") do
	xml.head do
		xml.businessType("IMPORTORDER")
	end
	xml.body do
		xml.orderInfoList do
			#@orders.each do |order|
			xml.orderInfo do
				xml.jkfSign do
					xml.companyCode("发送方海关十位数编码")
					xml.businessNo("业务编号") #order number
					xml.businessType("IMPORTORDER")
					xml.declareType("1")
					xml.note("备注") #optional
				end
				xml.jkfOrderImportHead do
					xml.eCommerceCode("电商企业编号")
					xml.eCommerceName("电商企业名称")
					xml.ieFlag("I")
					xml.payType("支付类型")
					xml.payCompanyCode("支付公司编码")
					xml.payNumber("支付单号")
					xml.orderTotalAmount("订单总金额")
					xml.orderNo("订单编号")
					xml.orderTaxAmount("订单税款") #according to goods amount, can be 0
					xml.orderGoodsAmount("订单货款") 
					xml.feeAmount("运费") #can be 0, optional
					xml.companyName("企业备案名称")
					xml.companyCode("企业备案编码")
					xml.tradeTime("成交时间") #格式：2014-02-18 20:33:33
					xml.currCode("成交币制") #见参数表
					xml.totalAmount("成交总价")
					xml.consigneeEmail("收件人邮箱")
					xml.consigneeTel("收件人电话")
					xml.consignee("收件人")
					xml.consigneeAddress("收件人地址")
					xml.totalCount("总件数")
					xml.postMode("发货方式（物流方式）") #见参数表
					xml.senderCountry("发件人国别") #见参数表
					xml.senderName("发件人名称")
					xml.purchaserId("购买人ID")
					xml.logisCompanyName("物流企业名称")
					xml.logisCompanyCode("物流企业编码")
					xml.zipCode("邮编") #optional
					xml.note("备注信息") #optional
					xml.wayBills("运单号列表,单号之间分号隔开") #optional
				end
				xml.jkfOrderDetailList do
					#@order_products.each do |product|
					xml.jkfOrderDetail do 
						xml.goodsOrder("商品序号")
						xml.goodsName("物品名称")
						xml.goodsModel("规格型号") #optional
						xml.codeTs("行邮税号") #必须已备案，且与 参数说明文档中的行邮税号 中的税号一致
						xml.grossWeight("毛重") #optional
						xml.unitPrice("申报单价")
						xml.goodsUnit("申报计量单位") #见参数表
						xml.goodsCount("申报数量")
						xml.originCountry("产销国") #见参数表
					end
					#end
				end
				xml.jkfGoodsPurchaser do
					xml.id("购买人ID")
					xml.name("购买人名称")
					xml.email("购买人邮箱") #optional
					xml.telNumber("联系电话")
					xml.address("地址")
					xml.paperType("证件类型") 
					xml.paperNumber("证件号码")
				end
			end
			#end
		end
	end  
end
