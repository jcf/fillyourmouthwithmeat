require 'rake-pipeline'
require 'execjs'
require 'uglifier'
require 'pathname'
require 'json'

module JCF
  class Assets
    module Filters
      class Drop < Rake::Pipeline::Matcher
        def output_files
          input_files.reject { |f| f.path =~ @pattern }
        end
      end

      class SafeConcat < Rake::Pipeline::ConcatFilter
        def generate_output(inputs, output)
          inputs.each do |input|
            output.write File.read(input.fullpath) + ";"
          end
        end
      end

      class OrderingSafeConcat < SafeConcat
        def initialize(ordering, string = nil, &block)
          @ordering = ordering
          super(string, &block)
        end

        def generate_output(inputs, output)
          @ordering.reverse.each do |name|
            file = inputs.find { |i| i.path == name }
            inputs.unshift(inputs.delete(file)) if file
          end
          super
        end
      end
    end
  end
end
