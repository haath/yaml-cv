require "mustache"
require "yaml"
require "tempfile"
require "uri"
require "open3"

def load_asset(asset_file)
    file_path = File.join(File.dirname(__FILE__), "assets")
    file_path = File.join(file_path, asset_file)
    File.read(file_path)
end

class CV < Mustache

	self.template_file = File.join(File.dirname(__FILE__), "assets/cv.mustache")

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

    def write_html(file_path)

        html = render
        File.open(file_path, 'w') { |file| file.write(html) }
    end

    def write_pdf(file_path)

        temp_file = Tempfile.new(["cv", ".html"])
        temp_file << render
        temp_file.flush

        system("wkhtmltopdf #{temp_file.path} #{file_path}")
    end
end