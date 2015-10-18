require 'rails_helper'

RSpec.describe Labeling, type: :model do 
  it {should belong_to :labelable } #labelable is an interface???
end 