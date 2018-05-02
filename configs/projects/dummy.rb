# A vanagon project to test vanagon pipelines
project "dummy" do |proj|
  # Project level settings our components will care about
  proj.setting(:install_root, "/opt/testpkg")
  proj.setting(:prefix, File.join(proj.install_root, "test"))

  proj.setting(:sysconfdir, "/etc/testpkg")

  proj.setting(:puppet_configdir, File.join(proj.sysconfdir, 'puppet'))
  proj.setting(:puppet_codedir, File.join(proj.sysconfdir, 'code'))
  proj.setting(:logdir, "/var/log/testpkg")
  proj.setting(:piddir, "/var/run/testpkg")
  proj.setting(:bindir, File.join(proj.prefix, "bin"))
  proj.setting(:link_bindir, "/opt/testpkg/bin")
  proj.setting(:libdir, File.join(proj.prefix, "lib"))
  proj.setting(:includedir, File.join(proj.prefix, "include"))
  proj.setting(:datadir, File.join(proj.prefix, "share"))
  proj.setting(:mandir, File.join(proj.datadir, "man"))
  proj.setting(:gem_home, File.join(proj.libdir, "ruby/gems/2.1.0"))
  proj.setting(:tmpfilesdir, "/usr/lib/tmpfiles.d")
  proj.setting(:ruby_vendordir, File.join(proj.libdir, "ruby", "vendor_ruby"))
  proj.setting(:host_ruby, File.join(proj.bindir, "ruby"))
  proj.setting(:host_gem, File.join(proj.bindir, "gem"))

  platform = proj.get_platform

  proj.setting(:gem_install, "#{proj.host_gem} install --no-rdoc --no-ri --local ")

  proj.description "A test package for testing Vanagon project pipelines."
  proj.version_from_git
  proj.write_version_file File.join(proj.prefix, 'VERSION')
  proj.license "See components"
  proj.vendor "Text PKG <info@testpkg.com>"
  proj.homepage "https://www.testpkg.com"
  proj.target_repo "PC1"

  # Platform specific
  proj.setting(:cflags, "-I#{proj.includedir}" )
  proj.setting(:ldflags, "-L#{proj.libdir} -Wl,-rpath=#{proj.libdir}")

  # First our stuff

  # Then the dependencies
  proj.component "dummy"

  proj.directory proj.prefix
end
