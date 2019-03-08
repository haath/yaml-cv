require "mustache"
require "yaml"
require "tempfile"
require "uri"
require "open3"
require "base64"

def load_asset(asset_file)
    file_path = File.join(File.dirname(__FILE__), "assets")
    file_path = File.join(file_path, asset_file)
    File.read(file_path)
end

def format_period(period)
    month_names = {
        1 => "Jun",
        2 => "Feb",
        3 => "Mar",
        4 => "Apr",
        5 => "May",
        6 => "Jun",
        7 => "Jul",
        8 => "Aug",
        9 => "Sep",
        10 => "Oct",
        11 => "Nov",
        12 => "Dec"
    }
    index = period["month"]
    period["month"] = month_names[ index ]
    period
end

class CV < Mustache

    self.template_file = File.join(File.dirname(__FILE__), "assets/cv.mustache")
    
    attr_accessor :is_pdf

	def initialize(file_path)
        @file_path = file_path
		@cv = YAML.load_file(file_path)

        if  @cv["contact"]
            @cv["contact"] = @cv["contact"].map { |c|
                c["icon"] = icon(c["icon"])
                c
            }
        end
    end
    
    def details
        @cv["details"]
    end

    def profile
        @cv["profile"]
    end

    def has_profile
        @cv.key?("profile")
    end

    def skills
        @cv["skills"]
    end

    def has_skills
        @cv.key?("skills")
    end

    def technical
        @cv["technical"]
    end

    def has_technical
        @cv.key?("technical")
    end

    def sections
        if !@cv["sections"]
            return
        end

        @cv["sections"].map { |s|
            s["items"] = format_subsections s["items"]
            s
        }
    end
	
	def full_name
		details["last_name"] + " " + details["first_name"]
    end
    
    def css
        load_asset("style.css")
    end
    
    def pdf_css
        load_asset("pdf.css")
    end

    def enable_pdf(enable = true)
        @is_pdf = true
    end

    def contact
        @cv["contact"]
    end

    def contact_padding
        if !contact
            return 0
        end

        columns = (contact.length / 3.0).ceil
        padding = (2 - columns) * 3

        Array.new(padding) { |i| 0 }
    end

    def icon(name)
        load_asset("icons/#{name.strip}.svg")
    end

    def format_subsections(subsections)
        if !subsections
            return
        end
    
        subsections.map { |e|
            if e["from"]
                e["from"] = format_period e["from"]
            end
            if e["to"]
                e["to"] = format_period e["to"]
            end
    
            if e["logo"]
                e["logo"] = read_image e["logo"]
            end
    
            e
        }
    end

    def read_image(img_path)
        file_path = File.join(File.dirname(@file_path), img_path)
        file = File.open(file_path, "rb")
        data = file.read
        Base64.strict_encode64(data)
    end

    def render
        template = load_asset("cv.mustache")
        super(template)
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

        temp_file.close
    end
end