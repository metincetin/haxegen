package haxegen;

import haxe.CallStack.StackItem;

typedef SourceFileValues = {
	name:String,
	classes:Array<Class>,
    ?packageName:String,
	?imports:Array<String>,
}

class SourceFile {
	var name = "";
	var classes:Array<Class>;
	var imports:Array<String>;
    var packageName = "";

	public function new(values:SourceFileValues = null) {
		if (values != null) {
			this.name = values.name != null ? values.name : "";
            this.packageName = values.packageName != null ? values.packageName : "";
			this.classes = values.classes != null ? values.classes : [];
			this.imports = values.imports != null ? values.imports : [];
		}
	}

    public function getFileName(){
        return name+".hx";
    }

    public function generate(){
        var ret = "";

        if (packageName == ""){
            ret += "package;\n";
        }else{
            ret+="package " + packageName + ";\n";
        }

        ret += imports.map(function(x) {return "import " + x + ";\n";}).join("");

        for(cl in classes){
            ret += cl.generate();
        }
        return ret;
    }

}
