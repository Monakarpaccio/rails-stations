# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 映画データの作成
movies_data = [
  {
    name: '映画1',
    year: '2023',
    description: '映画1の説明文です。',
    image_url: 'https://picsum.photos/200/300',
    is_showing: true
  },
  {
    name: '映画2',
    year: '2022',
    description: '映画2の説明文です。',
    image_url: 'https://picsum.photos/200/300',
    is_showing: true
  },
  {
    name: '映画3',
    year: '2021',
    description: '映画3の説明文です。',
    image_url: 'https://picsum.photos/200/300',
    is_showing: false
  },
  {
    name: '映画4',
    year: '2020',
    description: '映画4の説明文です。',
    image_url: 'https://picsum.photos/200/300',
    is_showing: true
  },
  {
    name: '映画5',
    year: '2019',
    description: '映画5の説明文です。',
    image_url: 'https://picsum.photos/200/300',
    is_showing: true
  }
]

# データベースに映画データを挿入
movies_data.each do |movie|
  Movie.create(
    name: movie[:name],
    year: movie[:year],
    description: movie[:description],
    image_url: movie[:image_url],
    is_showing: movie[:is_showing]
  )
end