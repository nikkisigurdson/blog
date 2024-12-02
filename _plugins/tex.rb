module Jekyll
  class TexConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /^\.tex$/i
    end

    def output_ext(_ext)
      '.html'
    end

    def running_in_docker?
      File.exist?('/.dockerenv')
    end

    def convert(content)
      # Calculate a unique hash for the content of the .tex file
      content_hash = Digest::MD5.hexdigest(content)

      # Check if there is a cached HTML version for this content
      cached_html_path = File.join(Dir.tmpdir, "tex_converter_cache_#{content_hash}.html")

      if File.exist?(cached_html_path)
        # If a cached version exists, return it
        return File.read(cached_html_path)
      else
        # If no cached version exists, proceed with the conversion
        temp_input_path = File.join(Dir.tmpdir, "#{SecureRandom.uuid}.tex")
        File.write(temp_input_path, content)

        if running_in_docker?
          # Run engrafo directly since we're already in the container
          system("engrafo #{temp_input_path} /tmp --javascript /assets/engrafo.js --css \"data:text/css;base64,\"")
          html_output = File.read('/tmp/index.html')
        else
          # Use Docker command when running locally
          docker_command = "sudo docker run -v #{Shellwords.escape(temp_input_path)}:/workdir/input.tex -w /workdir arxivvanity/engrafo sh -c 'engrafo input.tex /tmp --javascript /assets/engrafo.js --css \"data:text/css;base64,\" >&2 && cat /tmp/index.html'"
          html_output = `#{docker_command}`
          
          unless $?.success?
            raise "Error running engrafo:\n#{html_output}"
          end
        end

        # Clean up the temporary input file
        File.delete(temp_input_path)

        # Save the generated HTML to the cache for future use
        File.write(cached_html_path, html_output)

        html_output
      end
    end
  end
end
