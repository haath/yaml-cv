require "mustache"
require "yaml"

def load_asset(asset_file)
    file_path = File.join(File.dirname(__FILE__), "assets")
    file_path = File.join(file_path, asset_file)
    File.read(file_path)
end

class CV < Mustache

	self.template_file = File.join(File.dirname(__FILE__), "cv.mustache")

	def initialize(file_path)
		@cv = YAML.load_file(file_path)
    end
    
    def details
        @cv["details"]
    end
	
	def full_name
		details["last_name"] + " " + details["first_name"]
    end
    
    def css
        load_asset("style.css")
    end

    def contact
        @cv["contact"]
    end

    def icon(name)
        load_asset("icons/#{name.strip!}.svg")
    end
end