module Rails3JQueryAutocomplete
  module Orm
    module Mongoid
      def get_autocomplete_order(method, options, model=nil)
        order = options[:order]
        if order
          order.split(',').collect do |fields|
            sfields = fields.split
            [sfields[0].downcase.to_sym, sfields[1].downcase.to_sym]
          end
        else
          [[method.to_sym, :asc]]
        end
      end

      def get_autocomplete_items(parameters)
        model          = parameters[:model]
        method         = parameters[:method]
        options        = parameters[:options]
        is_full_search = options[:full]
        term           = parameters[:term]
        limit          = get_autocomplete_limit(options)
        order          = get_autocomplete_order(method, options)
        param_scopes = Array(options[:param_scopes])

        search = (is_full_search ? '.*' : '^') + term + '.*'

        items = model.scoped

        param_scopes.each do |scope|
          items = items.send(scope[:scope],method(scope[:param]).call)
        end unless param_scopes.empty?

        items  = items.where(method.to_sym => /#{search}/i).limit(limit).order_by(order)

      end
    end
  end
end
