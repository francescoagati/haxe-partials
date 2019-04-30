package partials;


import haxe.Serializer;
import haxe.Unserializer;
import haxe.macro.Context;
import haxe.macro.Compiler;
import haxe.macro.Expr;

import haxe.rtti.Meta;

import haxe.ds.StringMap;


class PCache {

  public function new() {

  }

  //public inline function keys() return Reflect.fields(untyped __dollar__loader);

  public inline function set(key:String,value:Array<Field>) {
    return partials.M.save_ast(key,value);
  }

 public inline function get(key:String):Array<Field> {
   return partials.M.load_ast(key);
 }

}
