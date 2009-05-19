Gem::Specification.new do |s|
  s.name              = 'integrity-irccat'
  s.version           = '0.0.3'
  s.date              = '2009-05-18'
  s.summary           = 'IrcCat notifier for the Integrity continuous integration server'
  s.summary           = 'IrcCat notifier for the Integrity continuous integration server'
  s.homepage          = 'http://integrityapp.com'
  s.email             = ['tim@spork.in', 'atmos@atmos.org']
  s.authors           = ['Tim Carey-Smith', 'Corey Donohoe']
  s.has_rdoc          = false
  s.files             = %w[README.markdown lib/notifier/config.haml lib/notifier/irccat.rb]
  s.test_files        = %w[spec/irccat_spec.rb]
  s.add_dependency 'integrity', '~>0.1.10'
  s.add_dependency 'irc_cat', '~>0.2.1.1'  #halorgium's repo on github
end
