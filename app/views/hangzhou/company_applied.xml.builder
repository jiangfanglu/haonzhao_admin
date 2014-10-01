xml.mo(version: "1.0.0") do
  xml.head do
    xml.businessType("IMPORT_COMPANY")
  end
  xml.body do
    xml.jkfSign do
        xml.businessNo("1SHOO001")
        xml.businessType("IMPORT_COMPANY")
        xml.platformCode("电商平台编码")
        xml.platformName("电商平台名称")
        xml.declareType(1)
        xml.note("备注")
    end 
    xml.ImportCompanyList do
      @companies.each do |company|
        xml.ImportCompany do
          xml.busiId("1SHOO#{company.id}")
          xml.companyCode(company.company_code)
          xml.orgCode(company.org_code)
          xml.companyName(company.company_name)
          xml.companyType(company.company_type)
          xml.companyAddress(company.company_address)
          xml.registeredCapital(company.registered_capital)
          xml.totalInvestment(company.total_investment)
          xml.businessScope(company.business_cope)
          xml.contactPerson(company.contact_person)
          xml.contactInfo(company.contact_info)
          xml.faxNo(company.fax_no)
          xml.zipCode(company.zipcode)
          xml.websiteUrl(company.website_url)
          xml.EMail(company.email)
          xml.customsCode(company.custom_code)
        end
      end
    end
  end
end