class Labeling < ActiveRecord::Base
  belongs_to :labelable, polymorphic: true #in can mutate into different types of objects through the interface
  belongs_to :label
end 

