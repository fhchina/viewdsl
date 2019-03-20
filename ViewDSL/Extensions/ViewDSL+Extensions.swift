//
//  ViewDSL.swift
//  ViewDSL
//
//  Created by PRIME on 20/03/19.
//  Copyright © 2019 PondokIT. All rights reserved.
//

import Foundation

extension ViewDSL {
    
    /// Base DSL
    ///
    /// - Parameter closure: callback with explicit parameter type. e.g: (stack: UIStackView)
    /// - Returns: UIView instance of closure parameter type
    @discardableResult
    func add<T>(_ closure: (T) -> Void) -> T where T: UIView {
        let view = T()
        put(view)
        closure(view)
        return view
    }
    
    
    /// Base DSL
    ///
    /// - Parameter closure: function to build UIView instance
    /// - Returns: UIView instance of closure return type
    @discardableResult
    func add<T>(_ closure: () -> T) -> T where T: UIView {
        let view = closure()
        put(view)
        return view
    }
}

extension ViewDSL {
    /// Delegated DSL
    ///
    /// - Parameter closure: function accept parameter of receiver type
    /// - Returns: Object of closure return type
    @discardableResult
    func dsl<O>(delegatedTo closure: (Self) -> O) -> O where Self: ViewDSL {
        return closure(self)
    }
    
    /// Delegated DSL
    ///
    /// - Parameter closure: function accept parameter of receiver type
    func dsl(delegatedTo closure: (Self) -> Void) {
        closure(self)
    }
}

extension ViewDSL {
    
    /// Delegated DSL
    ///
    /// - Parameter builder: LayoutBuilderDSL instance
    /// - Returns: Parameter supplied object
    @discardableResult
    func dsl<B>(delegatedTo builder: B) -> B where B: LayoutBuilderDSL {
        builder.layout(self)
        return builder
    }
    
    
    /// Delegated DSL
    ///
    /// - Parameter withInstanceOf: Type conform InitializableLayoutBuilderDSL
    /// - Returns: instance of Parameter type
    @discardableResult
    func dsl<B>(withInstanceOf: B.Type) -> B where B: InitializableLayoutBuilderDSL {
        let builder = B()
        return dsl(delegatedTo: builder)
    }
}
