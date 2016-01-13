component "libxslt" do |pkg, settings, platform|
  pkg.version "1.1.28"
  pkg.md5sum "9667bf6f9310b957254fdcf6596600b7"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{pkg.get_name}-#{pkg.get_version}.tar.gz"

  pkg.build_requires "libxml2"

  if !platform.is_osx?
    pkg.build_requires "pl-gcc"
    pkg.build_requires "make"
    pkg.environment "LDFLAGS" => settings[:ldflags]
    pkg.environment "CFLAGS" => settings[:cflags]
  end

  pkg.configure do
    ["./configure --prefix=#{settings[:prefix]} --docdir=/tmp --with-libxml-prefix=#{settings[:prefix]} #{settings[:host]}"]
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
