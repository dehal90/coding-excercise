class JobSequence
  
# a method that defines the parsing of the sequence   
  def self.process(outcomes)
    @sequence = JobProcessor.generate(outcomes)
    categorize!(JobProcessor.generate(outcomes))
  end

# circular dependency 
  def self.circular_dependence(jobs)
    jobs.each do |job_name, job|
      dependency_chain = Set.new

      while(job = jobs[job.dependence])
        break if !job.dependence
        if dependency_chain.add?(job.name).nil?
          return true
        end
      end
    end
    return false
  end
# categorize method raises errors if circular dependencies occur
  def self.categorize!(jobs)
    raise(StandardError) if circular_dependence(jobs)

    jobs.values.inject([]) { |categorized_jobs, job|
      if !categorized_jobs.include? job.name
        categorized_jobs << job.name
      end
      if job.dependence
        categorized_jobs.delete(job.dependence)
        job_pos = categorized_jobs.index(job.name)
        categorized_jobs.insert(job_pos, job.dependence)
      end
      categorized_jobs
    }
  end
end
