service_categories = [
  {
    name_en: "Repair",
    name_ar: "إصلاح",
    description_en: "Vehicle repair services.",
    description_ar: "خدمات إصلاح المركبات.",
    active: true
  },
  {
    name_en: "Towing",
    name_ar: "سطحة",
    description_en: "Vehicle towing services.",
    description_ar: "خدمات سحب ونقل المركبات.",
    active: true
  }
]

service_categories.each do |attributes|
  ServiceCategory.find_or_create_by!(name_en: attributes[:name_en]) do |category|
    category.assign_attributes(attributes)
  end
end
