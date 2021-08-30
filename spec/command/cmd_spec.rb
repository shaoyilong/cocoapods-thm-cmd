require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Cmd do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ cmd }).should.be.instance_of Command::Cmd
      end
    end
  end
end

