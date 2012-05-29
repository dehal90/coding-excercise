class JobProcessor
  def self.generate(outcome)
    outcome.split("\n").inject(Hash.new){ |acc, spec_line|
      j = Job.new(*spec_line.split('=>').map(&:strip))
      acc[j.name] = j
      acc
    }
  end
end

describe JobProcessor do
  let(:generated_job) { JobProcessor.generate("a => b") }

  context "If a single job is given" do
    it "shows the job list by name" do
      generated_job.keys.should include("a")
      generated_job.keys.length.should be(1)
    end

    it "puts job(s) on the list" do
      generated_job["a"].should be_a(Job)
    end

    it "states the correct job " do
      generated_job["a"].name.should eq("a")
    end

    it "will set up the right dependencey" do
      generated_job["a"].dependence.should eq("b")
    end

  end
  context "with many jobs" do
    let(:generated_jobs){ JobProcessor.generate("a => b
b =>
c => ")}

    it "creates the correct number of jobs" do
      generated_jobs.length.should be(3)
    end

    it "generates the args correctly" do
      generated_jobs.values.map(&:name).should =~ ["a", "b", "c"]
    end
  end
end
