package codegen;

import haxe.display.Display.Define;

typedef FunctionValues = {
    name:String,
	?returnType:String,
	?functionParameters:Array<FunctionParameter>,
    ?functionBody:String,
    ?isStatic:Bool,
    ?isOverride:Bool,
    ?accessModifier:AccessModifier
}

class Function {
	public var name = "";
	public var returnType = "";
	public var functionParameters = new Array<FunctionParameter>();
    public var functionBody ="";
    public var isStatic = false;
    public var isOverride = false;

	public var accessModifier:AccessModifier;

	public function new(values:FunctionValues = null) {
        if (values != null){
            this.name = values.name;
            this.returnType = values.returnType != null? values.returnType : "";
            this.accessModifier = values.accessModifier!= null ? values.accessModifier : Public;
            this.functionParameters = values.functionParameters!= null ? values.functionParameters : [];
            this.functionBody = values.functionBody!= null ? values.functionBody : "";
            this.isOverride = values.isOverride!= null ? values.isOverride : false;
            this.isStatic = values.isStatic!= null ? values.isStatic : false;
        }
    }

	public function generate(indention:Int = 0) {
        var tabs = "";
        for (i in 0...indention){
            tabs += "\t";
        }
        if (isOverride && isStatic){
            throw ("Override functions cannot be static");
            return "";
        }
		var ret = tabs;

		if (accessModifier == Public) {
            ret += "public ";
		}
        if (isStatic){
            ret += "static ";
        }
        if (isOverride){
            ret += "override ";
        }
        
        ret += 'function ${name}';
        if (functionParameters.length > 0){
            var parameterNames = [for (v in functionParameters) v.name + ":" + v.type];
            ret += ' ${parameterNames.join(", ")}';
        }

		if (returnType != "") {
			ret += ':${returnType}';
		}
		ret += " {\n";
        ret += tabs + "\t" + functionBody;
		ret += '\n${tabs}}';

		return ret;
	}
}

class FunctionParameter {
	public var name = "";
	public var type = "";

	public function new(name:String, type:String) {
		this.name = name;
		this.type = type;
	}
}
