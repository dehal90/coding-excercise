# simple two atrributes of each job ar defined as name and dependence
# The initialize method is used to define the action if two of the same jobs are put in
class Job
  attr_reader :name, :dependence

  def initialize(name, dep=nil)
    if dep == name
      raise ArgumentError.new("Jobs cannot be dependent on themselves")
    end
    @name = name
    @dependence = (dep == "") ? nil : dep
  end
end

#validates the behaviour of jobs after data input 
describe Job do
  it "is invalid without a name" do
    expect{
      Job.new
    }.to raise_error(ArgumentError)
  end

  it "cannot depend on itself" do
    expect{
      Job.new("a", "a")
    }.to raise_error(ArgumentError)
  end

  it "returns the job's name when asked" do
    Job.new(:try).name.should be :try
  end

  context "without a dependence" do
    it "returns no dependence" do
      Job.new(:try).dependence.should be_nil
    end
  end

  context "when a dependence is supplied" do
    it "returns the dependence when asked" do
      Job.new(:try, :dep).dependence.should eq(:dep)
    end
  end
end
