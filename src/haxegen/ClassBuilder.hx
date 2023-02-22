package haxegen;

class ClassBuilder{
    var classInstance: Class;
    function new(){}
    public static function create(){
        var x = new ClassBuilder();
        return x;
    }
    public function name(v:String){
        classInstance.name = v;

        return this;
    }

    public function addFunction(name:String){
        
    }
}