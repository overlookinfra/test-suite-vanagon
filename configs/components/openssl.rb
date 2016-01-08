component "openssl" do |pkg, settings, platform|
  pkg.version "1.0.2e"
  pkg.md5sum "5262bfa25b60ed9de9f28d5d52d77fc5"
  pkg.url "http://buildsources.delivery.puppetlabs.net/openssl-#{pkg.get_version}.tar.gz"

  # Use our toolchain on linux systems (it's not available on osx)
  if platform.is_linux?
    pkg.build_requires 'pl-binutils'
    pkg.build_requires 'pl-gcc'
    if platform.name =~ /el-4/
      pkg.build_requires 'runtime'
    end
  end

  pkg.environment "PATH" => "/opt/pl-build-tools/bin:$$PATH:/usr/local/bin"
  if platform.architecture =~ /86$/
    target = 'linux-elf'
    sslflags = '386'
  elsif platform.architecture =~ /64$/
    target = 'linux-x86_64'
  end
  cflags = settings[:cflags]
  ldflags = "#{settings[:ldflags]} -Wl,-z,relro"

  pkg.configure do
    [# OpenSSL Configure doesn't honor CFLAGS or LDFLAGS as environment variables.
    # Instead, those should be passed to Configure at the end of its options, as
    # any unrecognized options are passed straight through to ${CC}. Defining
    # --libdir ensures that we avoid the multilib (lib/ vs. lib64/) problem,
    # since configure uses the existence of a lib64 directory to determine
    # if it should install its own libs into a multilib dir. Yay OpenSSL!
    "./Configure \
      --prefix=#{settings[:prefix]} \
      --libdir=lib \
      --openssldir=#{settings[:prefix]}/ssl \
      shared \
      no-asm \
      #{target} \
      #{sslflags} \
      no-camellia \
      enable-seed \
      enable-tlsext \
      enable-rfc3779 \
      enable-cms \
      no-md2 \
      no-mdc2 \
      no-rc5 \
      no-ec2m \
      no-gost \
      no-srp \
      no-ssl2 \
      no-ssl3 \
      #{cflags} \
      #{ldflags}"]
  end

  pkg.build do
    ["#{platform[:make]} depend",
    "#{platform[:make]}"]
  end

  pkg.install do
    ["#{platform[:make]} INSTALL_PREFIX=/ install"]
  end

  pkg.install_file "LICENSE", "#{settings[:prefix]}/share/doc/openssl-#{pkg.get_version}/LICENSE"
end
