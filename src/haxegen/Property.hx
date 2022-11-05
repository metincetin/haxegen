package codegen;

typedef PropertyValues = {
    name:String,
    ?accessModifier:AccessModifier,
    ?defaultValue:String,
    ?type:String
}

class Property{
    public var name = "";
    public var accessModifier:AccessModifier = Private;
    public var defaultValue = "";
    public var type = "";
    public function new(values:PropertyValues = null){
        if (values != null){
            this.name = values.name;
            this.accessModifier = values.accessModifier != null? values.accessModifier : Private;
            this.defaultValue = values.defaultValue != null ? values.defaultValue : "";
            this.type = values.type != null ? values.type : "";
        }
    }

    public function generate(){
        var ret = "";
        
        if (accessModifier == Public){
            ret += "public ";
        }
        ret += 'var ${name}';

        if (type!=""){
            ret += ':${type}';
        }
        if (defaultValue != ""){
            ret += ' = ${defaultValue}';
        }

        ret += ";";
        return ret;
    }
}