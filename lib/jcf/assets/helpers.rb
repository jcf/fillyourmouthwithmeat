require 'rake-pipeline/dsl'

module JCF
  class Assets
    module Helpers
      def safe_concat(*args, &block)
        if args.first.kind_of?(Array)
          filter(Filters::OrderingSafeConcat, *args, &block)
        else
          filter(Filters::SafeConcat, *args, &block)
        end
      end

      def drop(pattern)
        matcher = pipeline.copy(Filters::Drop)
        matcher.glob = pattern
        pipeline.add_filter matcher
        matcher
      end
      alias skip drop
    end
  end
end
