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
movies_data.each do |movie|
  begin
    # 映画を作成
    movie_record = Movie.create!(
      name: movie[:name],
      year: movie[:year],
      description: movie[:description],
      image_url: movie[:image_url],
      is_showing: movie[:is_showing]
    )

    # スケジュールを作成
    movie_record.schedules.create!(
      start_time: '12:00',
      end_time: '14:00'
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating movie or schedule: #{e.message}"
  rescue ActiveRecord::RecordNotSaved => e
    puts "Parent movie not saved: #{e.message}"
  end
end

# シートデータの挿入
Sheet.create([
  { column: 1, row: 'a' }, { column: 2, row: 'a' }, { column: 3, row: 'a' }, { column: 4, row: 'a' }, { column: 5, row: 'a' },
  { column: 1, row: 'b' }, { column: 2, row: 'b' }, { column: 3, row: 'b' }, { column: 4, row: 'b' }, { column: 5, row: 'b' },
  { column: 1, row: 'c' }, { column: 2, row: 'c' }, { column: 3, row: 'c' }, { column: 4, row: 'c' }, { column: 5, row: 'c' }
])

Reservation.create([
  { date: '2024-10-31', schedule_id: 1, sheet_id: 1, email: 'example1@example.com', name: 'User One' },
  { date: '2024-10-31', schedule_id: 1, sheet_id: 2, email: 'example2@example.com', name: 'User Two' }
])