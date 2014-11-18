class CreateUnoClasses < ActiveRecord::Migration
  def change
    create_table :uno_classes do |t|
      t.string :department
      t.integer :course
      t.integer :section
      t.time :startTime
      t.time :endTime
      t.string :days
      t.string :location
      t.string :instructor
      t.string :sessionId

      t.timestamps
    end
  end
end
