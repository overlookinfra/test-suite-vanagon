component "dummy" do |pkg, settings, platform|
  pkg.add_source "file://resources/testfile1.sh"

  # The purpose of this component is to build as fast as possible, primarily used for testing changes to vanagon

  pkg.install_file 'testfile1.sh', "#{settings[:install_root]}/dummtestfile1.omg"

  pkg.install do
    "touch #{settings[:install_root]}/foo"
  end
end
