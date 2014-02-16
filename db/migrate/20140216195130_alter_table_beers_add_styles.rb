class AlterTableBeersAddStyles < ActiveRecord::Migration
  def up
    add_column :beers, :style_id, :integer

    Beer.uniq.pluck(:style).each do |style|
      s = Style.find_by(name:style)
      if s.nil?
        Style.create name:style
      end
    end
    Beer.all.each do |beer|
      style = Style.find_by(name:beer[:style])
      beer.style_id = style.id
      beer.save
    end
    remove_column :beers, :style
  end

  def down
    add_column :beers, :style, :string
    Beer.all.each do |b|
      b[:style] = b.style.name
      b.save
    end
    remove_column :beers, :style_id
  end
end
