require 'spec_helper'

describe Dotloop::Tasklist do
  let(:client) { Dotloop::Client.new(access_token: SecureRandom.uuid) }
  subject { Dotloop::Tasklist.new(client: client) }

  describe '#initialize' do
    it 'exist' do
      expect(subject).to_not be_nil
    end

    it 'set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'return a list of tasklists' do
      dotloop_mock(:tasklists)
      tasklists = subject.all(profile_id: 1_234, loop_id: 76_046)
      expect(tasklists).not_to be_empty
      expect(tasklists).to all(be_a(Dotloop::Models::Tasklist))
      expect(tasklists.first).to have_attributes(name: 'My Tasks')
    end
  end

  describe '#find' do
    it 'return a tasklist' do
      dotloop_mock(:tasklist)
      tasklist = subject.find(profile_id: 1_234, loop_id: 76_046, task_list_id: 123)
      expect(tasklist).to be_a(Dotloop::Models::Tasklist)
      expect(tasklist).to have_attributes(name: 'My Tasks')
    end
  end
end
