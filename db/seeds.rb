require 'faker'

# Create 100 dummy articles
100.times do
    Article.create(
        title: Faker::Book.title,
        content: Faker::Lorem.paragraph(sentence_count: 5)
    )
end
