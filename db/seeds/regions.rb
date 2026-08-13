regions = [
  { country_code: "SA", name_en: "Riyadh", name_ar: "الرياض", code: "SA-01" },
  { country_code: "SA", name_en: "Makkah", name_ar: "مكة المكرمة", code: "SA-02" },
  { country_code: "SA", name_en: "Medina", name_ar: "المدينة المنورة", code: "SA-03" },
  { country_code: "SA", name_en: "Eastern Province", name_ar: "المنطقة الشرقية", code: "SA-04" },
  { country_code: "SA", name_en: "Asir", name_ar: "عسير", code: "SA-14" },
  { country_code: "SA", name_en: "Tabuk", name_ar: "تبوك", code: "SA-07" },
  { country_code: "SA", name_en: "Hail", name_ar: "حائل", code: "SA-06" },
  { country_code: "SA", name_en: "Al-Jouf", name_ar: "الجوف", code: "SA-12" },
  { country_code: "SA", name_en: "Northern Borders", name_ar: "الحدود الشمالية", code: "SA-08" },
  { country_code: "SA", name_en: "Jazan", name_ar: "جازان", code: "SA-09" },
  { country_code: "SA", name_en: "Najran", name_ar: "نجران", code: "SA-10" },
  { country_code: "SA", name_en: "Al-Bahah", name_ar: "الباحة", code: "SA-11" },
  { country_code: "SA", name_en: "Al-Qassim", name_ar: "القصيم", code: "SA-05" },
  { country_code: "SA", name_en: "Other", name_ar: "أخرى" }
]

regions.each do |region|
  country = Country.find_by!(code: region[:country_code])

  Region.create!(
    name_en: region[:name_en],
    name_ar: region[:name_ar],
    code: region[:code],
    country: country
  )
end

