module Bot
    Dir['modules/*.rb'].each { |mod| load mod }
    def self.load_modules(klass, path)
        new_module = Module.new
        const_set(klass.to_sym, new_module)
        #Dir[File.expand_path "lib/**/*.rb"].each{|f| require_relative(f)}
        Dir["modules/#{path}/*.rb"].each { |file| load file }
        new_module.constants.each do |mod|
         new_module.const_get(mod)
        end
    end
    load_modules(:SnackHack, 'events')
end