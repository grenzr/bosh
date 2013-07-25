require 'spec_helper'
require 'bosh/dev/writable_manifest'
require 'fakefs/spec_helpers'

module Bosh::Dev
  describe WritableManifest do
    include FakeFS::SpecHelpers

    context 'when mixed into a manifest that implements #to_h' do
      let(:manifest) do
        double('FakeManifest', to_h: {'foo' => 'bar'})
      end

      before do
        manifest.extend(WritableManifest)
      end

      it 'writes it to disk as yaml' do
        expect {
          manifest.write('foo.yml')
        }.to change { File.exist?('foo.yml') }.to(true)

        File.read('foo.yml').should eq("---\nfoo: bar\n")
      end
    end
  end
end
