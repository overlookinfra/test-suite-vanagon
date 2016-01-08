component "test-component" do |pkg, settings, platform|
  pkg.load_from_json('configs/components/test-component.json')

  pkg.provides 'test-component', '1.0.0'

  pkg.build_requires "ruby"
  pkg.build_requires 'openssl'

  pkg.configure do
    puts "We're configurin' stuff, yeah!"
  end


  pkg.build do
    puts "And now we're buildin' things!"
  end

  pkg.install do
    puts "Shit's gettin' real, things are done installed up in here!"
  end
end
