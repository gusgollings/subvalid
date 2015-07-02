require "subvalid/validator_registry"

module Subvalid
  module Validator
    class BlockValidator

      class Context
        include DSL
        include API
      end

      def self.validate(object, validation_result=ValidationResult.new, *args)
        #return unless object # don't pass nil object into block - this should be handled with a PresenceValidator if it needs to be flagged as a validation error
        block = args[0]

        context = Context.new
        context.instance_exec(&block)
        context.validate(object, validation_result, args)
      end
    end
    ValidatorRegistry.register(:block, BlockValidator)
  end
end