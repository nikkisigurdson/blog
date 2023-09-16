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

    def convert(content)
      # Temporarily write the content to a temporary file
      temp_input_path = File.join(Dir.tmpdir, "#{SecureRandom.uuid}.tex")
      File.write(temp_input_path, content)

      # Define the Docker command to run engrafo and cat the HTML output
      docker_command = "sudo docker run -v #{Shellwords.escape(temp_input_path)}:/workdir/input.tex -w /workdir arxivvanity/engrafo sh -c 'engrafo input.tex /tmp --javascript /assets/engrafo.js --css \"data:text/css;base64,\" >&2 && cat /tmp/index.html'"

      # Execute the Docker command and capture the HTML output
      html_output = `#{docker_command}`

      # Check for errors in the Docker command execution
      unless $?.success?
        raise "Error running engrafo:\n#{html_output}"
      end

      # Clean up the temporary input file
      File.delete(temp_input_path)

      html_output
    end
  end
end
