package codegen;

import codegen.Function;

typedef InterfaceValues = {
    name:String,
    ?functions:Array<Function>
}

class Interface{
    public var name = "";
    public var functions = new Array<Function>();
    public function new(values:InterfaceValues = null){
        if (values!=null){
            this.name = values.name;
            this.functions = values.functions;
        }
    }

    public function generate(){
        var ret = "";
        return ret;
    }
}