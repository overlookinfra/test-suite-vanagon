component "test-component" do |pkg, settings, platform|
  VERSION = '1.0.0'
  pkg.load_from_json('configs/components/test-component.json')

  pkg.provides 'test-component', VERSION

  pkg.build_requires "ruby"
  pkg.build_requires 'openssl'

  pkg.configure do
    ['/bin/true' ]
  end

  pkg.build do
    [ settings[:host_gem] + ' build test-component.gemspec' ]
  end

  pkg.install do
    [ settings[:gem_install] + ' test-component-' + VERSION + '.gem' ]
  end
end
