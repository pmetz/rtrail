[
  'api',
  'case',
  'client',
  'entity',
  'exceptions',
  'plan',
  'project',
  'result',
  'run',
  'suite',
  'test'
].each do |file|
  require_relative "rtrail/#{file}"
end

module RTrail
end

