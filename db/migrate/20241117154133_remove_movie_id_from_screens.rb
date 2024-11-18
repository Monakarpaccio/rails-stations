class RemoveMovieIdFromScreens < ActiveRecord::Migration[7.1]
  def change
    remove_reference :screens, :movie, null: false, foreign_key: true
  end
end
