Gem::Specification.new do |s|
  s.name              = 'integrity-irccat'
  s.version           = '0.0.2'
  s.date              = '2008-12-11'
  s.summary           = 'IrcCat notifier for the Integrity continuous integration server'
  s.summary           = 'IrcCat notifier for the Integrity continuous integration server'
  s.homepage          = 'http://integrityapp.com'
  s.email             = ['tim@spork.in', 'atmos@atmos.org']
  s.authors           = ['Tim Carey-Smith', 'Corey Donohoe']
  s.has_rdoc          = false
  s.files             = %w[README.markdown lib/notifier/config.haml lib/notifier/irccat.rb]
  s.test_files        = %w[spec/irccat_spec.rb]
  s.add_dependency 'integrity', '~>0.1.9.1'
  s.add_dependency 'irc_cat', '~>0.2.1.1'  #halorgium's repo on github
end
