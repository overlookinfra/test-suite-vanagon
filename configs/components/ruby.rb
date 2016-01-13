component "ruby" do |pkg, settings, platform|
  pkg.version "2.1.7"
  pkg.md5sum "2e143b8e19b056df46479ae4412550c9"
  pkg.url "http://buildsources.delivery.puppetlabs.net/ruby-#{pkg.get_version}.tar.gz"

  base = 'resources/patches/ruby'
  pkg.apply_patch "#{base}/libyaml_cve-2014-9130.patch"
  pkg.apply_patch "#{base}/2.1.7_pthreads_mem_allocation.patch"

  pkg.build_requires "openssl"

  if platform.is_deb?
    pkg.build_requires "zlib1g-dev"
  elsif platform.is_rpm?
    pkg.build_requires "zlib-devel"
  end

  # Here we set --enable-bundled-libyaml to ensure that the libyaml included in
  # ruby is used, even if the build system has a copy of libyaml available
  pkg.configure do
    [
      "bash configure \
        --prefix=#{settings[:prefix]} \
        --with-opt-dir=#{settings[:prefix]} \
        --enable-shared \
        --enable-bundled-libyaml \
        --disable-install-doc \
        --disable-install-rdoc \
        #{settings[:host]}"
     ]
  end

  pkg.build do
    "#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"
  end

  pkg.install do
    "#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install"
  end
end
