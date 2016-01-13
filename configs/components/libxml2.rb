component "libxml2" do |pkg, settings, platform|
  pkg.version "2.9.3"
  pkg.md5sum "daece17e045f1c107610e137ab50c179"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{pkg.get_name}-#{pkg.get_version}.tar.gz"

  if !platform.is_osx?
    pkg.build_requires "pl-gcc"
    pkg.build_requires "make"
    pkg.environment "LDFLAGS" => settings[:ldflags]
    pkg.environment "CFLAGS" => settings[:cflags]
  end

  pkg.configure do
    ["./configure --prefix=#{settings[:prefix]} --without-python #{settings[:host]}"]
  end

  pkg.build do
    ["#{platform[:make]} VERBOSE=1 -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"]
  end

  pkg.install do
    [
      "#{platform[:make]} VERBOSE=1 -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install",
      "rm -rf #{settings[:datadir]}/gtk-doc",
      "rm -rf #{settings[:datadir]}/doc/#{pkg.get_name}*"
    ]
  end

end
