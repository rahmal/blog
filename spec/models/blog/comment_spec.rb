require 'spec_helper'

describe Blog::Comment do
  it { should belong_to(:post) }

  it { should_not allow_value('').for(:author_byline) }
  it { should_not allow_value('').for(:body) }

  describe ".visible" do
    it "includes unfiltered and ham messages, but not spam" do
      @unfiltered = Blog::Comment.make!
      @ham = Blog::Comment.make!(:state => 'filtered_as_ham')
      @ham2 = Blog::Comment.make!(:state => 'marked_as_ham')
      @spam = Blog::Comment.make!(:state => 'filtered_as_spam')
      @spam2 = Blog::Comment.make!(:state => 'marked_as_spam')
      Blog::Comment.visible.should include(@unfiltered)
      Blog::Comment.visible.should include(@ham)
      Blog::Comment.visible.should include(@ham2)
      Blog::Comment.visible.should_not include(@spam)
      Blog::Comment.visible.should_not include(@spam2)
    end
  end

  describe "#state" do
    subject { Blog::Comment.make! }

    def enable_spam_filter
      Rakismet.key = "fakekey"
    end

    def disable_spam_filter
      Rakismet.key = nil
    end

    it "begins in state unfiltered" do
      subject.should be_unfiltered
    end

    it "transitions to filtered_as_ham if rakismet likes it" do
      enable_spam_filter
      subject.stub(:spam?) { false }
      subject.run_spam_filter
      subject.should be_filtered_as_ham
    end

    it "transitions to filtered_as_spam if rakismet doesn't like it" do
      enable_spam_filter
      subject.stub(:spam?) { true }
      subject.run_spam_filter
      subject.should be_filtered_as_spam
    end

    it "remains unfiltered if the rakismet is not configured" do
      disable_spam_filter
      subject.run_spam_filter
      subject.should be_unfiltered
    end

    it "supports manually marking a filtered post as ham" do
      enable_spam_filter
      subject.filter_as_spam
      subject.can_mark_as_ham?.should == true
      subject.should_receive(:ham!)
      subject.mark_as_ham
      subject.should be_marked_as_ham
    end

    it "supports manually marking a filtered post as spam" do
      enable_spam_filter
      subject.filter_as_ham
      subject.can_mark_as_spam?.should == true
      subject.should_receive(:spam!)
      subject.mark_as_spam
      subject.should be_marked_as_spam
    end

    it "supports manually marking an unfiltered post as spam" do
      disable_spam_filter
      subject.can_mark_as_spam?.should == true
      subject.mark_as_spam
      subject.should be_marked_as_spam
    end
  end
end
