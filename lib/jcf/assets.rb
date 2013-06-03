require 'rake-pipeline'

module JCF
  class Assets
    autoload :Filters, 'jcf/assets/filters'
    autoload :Helpers, 'jcf/assets/helpers'
    autoload :Version, 'jcf/assets/version'

    TYPES = [:styles, :scripts, :images, :static, :vendor]
    VENDOR_ORDER = %w(jquery minispade)

    attr_reader :roots, :env

    def initialize(roots = '.')
      @roots = Array(roots).map { |root| Pathname.new(File.expand_path(root)) }
      @env = ENV['ENV']
    end

    def development?
      env != 'production'
    end

    def production?
      !development?
    end

    def vendor_order
      VENDOR_ORDER.map { |name| "vendor/#{name}.js" }
    end

    def setup_compass
      Compass.configuration.images_path = images.first
      styles.each do |path|
        Compass.configuration.add_import_path(path)
      end
    end

    def update_version
      JCF::Assets::Version.new.update
    end

    TYPES.each { |type| define_method(type) { paths[type] } }

    def paths
      @paths ||= TYPES.inject({}) do |paths, type|
        paths.merge(type.to_sym => roots.map { |root| root.join("assets/#{type}").to_s })
      end
    end
  end
end

Rake::Pipeline::DSL::PipelineDSL.send(:include, JCF::Assets::Helpers)
