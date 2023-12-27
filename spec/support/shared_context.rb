# frozen_string_literal: true

RSpec.shared_examples 'creates_object_for' do |model_name|
  subject { described_class.new(attributes) }

  let(:attributes) { attributes_for(model_name) }

  it 'creates object' do
    expect(subject.valid?).to be_truthy
    expect { subject.save! }.to change { described_class.count }.by(1)
  end
end

RSpec.shared_examples 'not_create_object_for' do |model_name, parameter|
  subject { described_class.new(attributes) }

  let(:attributes) { attributes_for(model_name, parameter) }

  it 'should not be valid' do
    expect(subject.valid?).to be_falsy
  end

  it 'does not create object' do
    expect { subject.save }.not_to change { described_class.count }
  end

  it 'raise RecordInvalid error' do
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
