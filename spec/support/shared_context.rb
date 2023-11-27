# frozen_string_literal: true

RSpec.shared_examples 'creates_object_for' do |model_name|
  subject { described_class.create(attributes) }

  let(:attributes) { FactoryBot.attributes_for(model_name) }

  it 'creates object' do
    expect { subject.save! }.to change { described_class.count }.by(1)
  end
end

RSpec.shared_examples 'not_create_object_for' do |model_name, parameter|
  subject { described_class.create(attributes) }

  let(:attributes) { FactoryBot.attributes_for(model_name, parameter) }

  it 'does not create object' do
    expect { subject.save }.to change { described_class.count }.by(0)
  end

  it 'raise RecordInvalid error' do
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
