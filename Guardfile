# A sample Guardfile
# More info at https://github.com/guard/guard#readme
#

guard :coffeescript, :input => 'src', :output => 'lib'

guard :coffeescript, :input => 'tests', :output => 'tests'

# Copy the newly created lib file for minification.
guard 'process', :name => 'Copy to min', :command => 'cp lib/hevents.js lib/hevents.min.js' do
  watch %r{lib/hevents.js}
end

# Use uglify.js to minify the Javascript for maximum smallness
guard 'uglify', :destination_file => "lib/hevents.min.js" do
  watch (%r{lib/hevents.min.js})
end

