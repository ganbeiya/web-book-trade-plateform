require 'faker'

# Step 1: Create all categories
disciplines = ["Academic Affairs", "Agricultural Systems Management", "Agriscience Education", "Air Force Aerospace Studies", "American Sign Language", "Anatomy", "Animal Sciences", "Anthropology", 
"Arabic", "Architecture", "Art", "Art Education", "Arts and Sciences", "Astronomy", "Atmospheric Sciences", "Aviation", "Biochemistry", "Bioethics", "Biological Chem & Pharmacology", 
"Biology", "Biomedical Education", "Biochemical Engineering", "Business Administration", "Cancer Biology and Genetics", "Chemical and Biomolecular Engineering", "Chemistry", "Chinese", 
"City and Regional Planning", "Civic Thought and Leadership", "Civil Engineering", "Comparative Studies", "Computer Science & Engineering", "Construction Systems Management", "Consumer Sciences", 
"Dance", "Dental Hygiene", "Design", "Disability Studies", "Earth Sciences", "Economics", "Educational Studies", "Electrical and Computer Engineering", "Engineering", "Engineering Education", 
"Entomology", "Environment & Natural Resource", "Environmental Engineering", "Ethnic Studies", "Film Studies", "Food Science & Technology", "French", "Geography", "German", "Greek", "Health and Rehabilitation Science", 
"Health and Wellness", "Hebrew", "Hindi", "History", "Human Nutrition", "Internal Medicine", "International Studies", "Italian", "Japanese", "Jewish Studies", "Kinesiology", "Korean", "Latin", 
"Law", "Linguistics", "Mathematics", "Meat Science", "Mechanical Engineering", "Medical Dietetics", "Medical Laboratory Science", "Microbiology", "Military Science", "Modern Greek", "Molecular Genetics", "Music", "Naval Science", 
"Nuclear Engineering", "Nursing", "Pathology", "Pediatrics", "Pharmacy", "Philosophy", "Physics", "Plant Pathology", "Political Science", "Psychology", "Public Heath", "Religious Studies", "Respiratory Therapy", "Rural Sociology",
"Russian", "Sociology", "Spanish", "Speech and Hearing Science", "Statistics", "Theatre", "Veterinary Clinical Sciences", "Vision Science", "Welding Engineering", "Women's, Gender&Sexuality Statistic", "Yiddish"]

disciplines.each do |discipline|
  Category.find_or_create_by!(name: discipline)
end

puts "✅ Categories seeded: #{Category.count}"

# Step 2: Reset database
User.destroy_all
Book.destroy_all

# Step 3: Create users
users = []
5.times do |i|
  user = User.create!(
    email: "example#{i + 1}@example.com",
    password: "123456",
    password_confirmation: "123456"
  )
  users << user
end

puts "✅ Users created: #{users.count}"

# Step 4: Create books
categories = Category.all 

users.each_with_index do |user, index|
  2.times do |i|
    book = Book.new(
      title: Faker::Book.title,
      author: Faker::Book.author,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      price: rand(5.0..30.0).round(2),
      condition: ["New", "Like New", "Good", "Fair", "Poor"].sample,
      publisher: Faker::Book.publisher,
      isbn: Array.new(13) { rand(0..9) }.join,
      published_at: Faker::Date.backward(days: 3650),
      user: user, 
      status: ["available", "sold", "reserved"].sample,
      category: categories.sample 
    )

    # Add image if exists
    image_path = Rails.root.join("db", "seeds", "images", "Book#{index * 2 + i + 1}.jpg")
    book.image.attach(io: File.open(image_path), filename: "Book#{index * 2 + i + 1}.jpg") if File.exist?(image_path)

    book.save!
  end
end



puts "✅ Books created: #{Book.count}"
