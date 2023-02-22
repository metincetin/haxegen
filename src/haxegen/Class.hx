package haxegen;

typedef ClassValues = {
    name:String,
    ?inheritedClass:Class,
    ?implementedInterfaces:Array<Interface>,
    ?properties: Array<Property>,
    ?functions: Array<Function>,
}

class Class{
    public var name = "";
    public var inheritedClass:Class;
    public var implementedInterfaces = new Array<Interface>();
    public var properties = new Array<Property>();
    public var functions = new Array<Function>();

    public function new(values:ClassValues = null){
        if (values != null){
            this.name = values.name != null ? values.name : "";
            this.inheritedClass = values.inheritedClass;
            this.implementedInterfaces = values.implementedInterfaces != null ? values.implementedInterfaces : [];
            this.properties = values.properties != null ? values.properties : [];
            this.functions = values.functions != null ? values.functions : [];
        }
    }

    function hasFunction(functionName:String){
        for(f in functions){
            if (f.name == functionName){
                return true;
            }
        }
        return false;
    }

    public function generate(){
        var ret = "";
        var interfaceNames = new Array<String>();

        ret += 'class ${name}';
        if (inheritedClass != null){
            ret += ' extends ${inheritedClass.name}';
        }
        if (implementedInterfaces.length > 0){
            interfaceNames = [for(v in implementedInterfaces) 'implements ${v.name}'];
            ret += ' ${interfaceNames.join(" ")}';
        }
        ret += " {";


        // generate properties
        for (p in properties){
            ret += '\n\t${p.generate()}';
        }

        // generate empty functions for non implemented interfaces.
        for(int in implementedInterfaces){
            if (int.functions == null) continue;
            ret += "\n";
            for(f in int.functions){
                if (!hasFunction(f.name)){
                    f.accessModifier = Public;
                    ret += f.generate(1);
                }
            }
        }
        

        if (functions != null){
            for (f in functions){
                ret += '\n${f.generate(1)}\n';
            }
        }

        ret += "}";

        return ret;
    }
}