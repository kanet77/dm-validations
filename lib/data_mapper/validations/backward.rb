module DataMapper
  module Validations

    # TODO: this Exception class is not referenced within dm-validations
    #   any reason not to remove it?
    class ValidationError < StandardError; end

    class ErrorSet
      extend Deprecate

      deprecate :clear!, :clear

      def self.default_error_message(violation_type, attribute_name, *violation_data)
        MessageTransformer::Default.error_message(violation_type, attribute_name, *violation_data)
      end
    end

    class ContextualRuleSet
      extend Deprecate

      deprecate :clear!,  :clear

      def execute(context_name, resource)
        # warn "#{self.class}#execute is deprecated. Use #{self.class}#validate instead."
        context(context_name).execute(resource)
      end
    end

    class Rule
      extend Deprecate

      # TODO: remove :field_name alias
      deprecate :field_name, :attribute_name
    end

    class RuleSet
      extend Deprecate

      # This is present to provide a backwards-compatible codepath to
      # ContextualRuleSet#execute
      def execute(resource)
        rules = rules_for_resource(resource)
        rules.map { |rule| rule.call(resource) }.all?
      end
    end

    class Violation
      # TODO: Extract the correct custom message for a Rule's context
      # in ContextualRuleSet#add
      def [](context_name)
        warn "Accessing custom messages by context name will be removed in a future version"
        @custom_message[context_name]
      end
    end

    module Macros
      extend Deprecate

      deprecate :validates_absent,        :validates_absence_of
      deprecate :validates_format,        :validates_format_of
      deprecate :validates_present,       :validates_presence_of
      deprecate :validates_length,        :validates_length_of
      deprecate :validates_is_accepted,   :validates_acceptance_of
      deprecate :validates_is_confirmed,  :validates_confirmation_of
      deprecate :validates_is_number,     :validates_numericality_of
      deprecate :validates_is_primitive,  :validates_primitive_type_of
      deprecate :validates_is_unique,     :validates_uniqueness_of
    end

    module Inferred
      extend Deprecate

      # TODO: why are there 3 entry points to this ivar?
      # #disable_auto_validations, #disabled_auto_validations?, #auto_validations_disabled?
      # def disable_auto_validations
      #   !infer_validations?
      # end

      # Checks whether auto validations are currently
      # disabled (see +disable_auto_validations+ method
      # that takes a block)
      #
      # @return [TrueClass, FalseClass]
      #   true if auto validation is currently disabled
      #
      # @api semipublic
      # def disabled_auto_validations?
      #   !infer_validations?
      # end

      # deprecate :auto_validations_disabled?,  :infer_validations?
      # deprecate :without_auto_validations,    :without_inferred_validations

    end # module Inferred

    AutoValidations = Inferred
    ContextualValidators = ContextualRuleSet
    ValidationErrors = ErrorSet

  end # module Validations

  Validate = Validations

end # module DataMapper