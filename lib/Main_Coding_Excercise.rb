# combined all required files for the main doc
require 'Jobs.rb'
require 'Job_Processor.rb'
require 'Job_Sequence.rb'
require 'rspec'

# rspec is used to try this code 
# follow the instructions to install rspec off github
# type  rspec main_coding_excercise.rb in a terminal 
# the main part of this excercise is outlined here
describe JobSequence do
  context "Given you are passed an empty string (no jobs)" do
    it "should be an empty sequence" do
      JobSequence.process("").should eq([])
    end
  end

  context "when a single job is given" do
    it "should be a show 'a'" do
      JobSequence.process("a => ").should eq(["a"])
    end
  end

context "when multiple jobs are given with no dependencies" do
       let(:outcome){ "a =>
b => c=>" }
    it "should be a sequence containing all three jobs abc in no significant order" do
      
            jobs = JobSequence.process(outcome)
            jobs.length.should be 3
    end 
  end

  context "multiple jobs with single dependence" do
    let(:outcome){ "a =>
b => c
c=>" }
    it "will put c before b" do
      jobs = JobSequence.process(outcome)
      jobs.join.should =~ /c.*b/
    end
  end

  context "multiple jobs with multiple dependancies" do
    let(:jobs){ JobSequence.process("a =>
b => c
c => f
d => a
e => b
f => ")}
    it "will put f before c, c before b, b before e, a before d" do
      jobs.join.should =~ /f.*c/
      jobs.join.should =~ /c.*b/
      jobs.join.should =~ /b.*e/
      jobs.join.should =~ /a.*d/
    end

    it "will contains all six letter in the correct sequence" do jobs.length.should be 6
    end
  end

  context "for jobs that are self referential " do let(:outcome){ "a =>
b => c
c => f
d => a
e =>
f => b"}
    it "shows an Error" do
      expect {
        JobSequence.process(outcome)}.to raise_error(StandardError)
    end
  end
end


