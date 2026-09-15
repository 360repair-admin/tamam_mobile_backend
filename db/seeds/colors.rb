colors = [
  { name_en: "White",  name_ar: "أبيض" },
  { name_en: "Black",  name_ar: "أسود" },
  { name_en: "Silver", name_ar: "فضي" },
  { name_en: "Gray",   name_ar: "رمادي" },
  { name_en: "Red",    name_ar: "أحمر" },
  { name_en: "Blue",   name_ar: "أزرق" },
  { name_en: "Green",  name_ar: "أخضر" },
  { name_en: "Brown",  name_ar: "بني" },
  { name_en: "Beige",  name_ar: "بيج" },
  { name_en: "Gold",   name_ar: "ذهبي" },
  { name_en: "Orange", name_ar: "برتقالي" },
  { name_en: "Yellow", name_ar: "أصفر" },
  { name_en: "Purple", name_ar: "بنفسجي" }
]

colors.each do |attributes|
  Color.find_or_create_by!(name_en: attributes[:name_en]) do |color|
    color.name_ar = attributes[:name_ar]
  end
end
