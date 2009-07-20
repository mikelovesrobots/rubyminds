class BenchmarkingFilter
  def self.filter(controller, &block)
    timing = Benchmark.measure(&block)
    controller.response.body.sub! '<!-- rendered_in -->', "%.3f" % timing.total
    true
  end
end

