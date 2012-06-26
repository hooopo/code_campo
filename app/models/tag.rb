# -*- encoding : utf-8 -*-
class Tag
  include Mongoid::Document

  identity :type => String
  field :value, :type => Integer, :default => 0

  def self.suggest_tags(limit = 500)
    self.order_by([[:value, :desc]]).limit(limit).map(&:_id)
  end

  def self.recount
    map = <<-EOF
      function() {
        if (!this.tags) {
            return;
        }

        for (index in this.tags) {
            emit(this.tags[index], 1);
        }
      }
    EOF

    reduce= <<-EOF
      function(previous, current) {
        var count = 0;

        for (index in current) {
            count += current[index];
        }

        return count;
      }
    EOF
    Topic.collection.map_reduce(map, reduce, :out => self.collection_name)
  end
end
