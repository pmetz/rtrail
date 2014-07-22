# Custom RSpec matchers

RSpec::Matchers.define :be_a_list_of do |klass|
  match do |list|
    expect(list).to be_an(Array)
    expect(list.first).to be_a(klass)
  end
end

RSpec::Matchers.define :have_fields do |fields|
  match do |obj|
    #expect(hash).to be_a(Hashie::Mash)
    fields.each do |k, v|
      expect(obj).to include(k)
      expect(obj[k]).to eq(v)
    end
  end
end

