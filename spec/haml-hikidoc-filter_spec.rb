require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Haml::Filters::HikiDoc do
  def haml(src, options = {})
    Haml::Engine.new(src, options).render
  end

  describe 'paragraph' do
    subject do
      haml <<-HAML
:hikidoc
  例えば、
  こういう風に記述すると、これらの行は
  一つのパラグラフとして整形されます。
      HAML
    end

    it { should == "<p>例えば、\nこういう風に記述すると、これらの行は\n一つのパラグラフとして整形されます。</p>\n" }
  end

  describe 'pre' do
    subject do
      haml <<-HAML
:hikidoc
  foo
   bar
      HAML
    end

    it { should == "<p>foo</p>\n<pre>bar</pre>\n" }
  end

  describe 'link to image' do
    before do
      @src = <<-HAML
:hikidoc
  http://example.com/image.png
      HAML
    end

    subject { haml @src }
    it { should == %(<p><img src="http://example.com/image.png" alt="image.png" /></p>\n) }

    context 'HTML' do
      subject { haml @src, :format => :html5 }
      it { should == %(<p><img src="http://example.com/image.png" alt="image.png"></p>\n) }
    end
  end

  describe 'WikiName' do
    before do
      @src = <<-HAML
:hikidoc
  WikiName
      HAML
    end

    subject { haml @src }
    it { should == %(<p><a href="WikiName">WikiName</a></p>\n) }

    context 'disabled by option' do
      subject { haml @src, :hikidoc => {:use_wiki_name => false} }
      it { should == %(<p>WikiName</p>\n) }
    end
  end
end
