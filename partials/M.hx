package partials;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.Json;
import sys.io.File;

import haxe.Serializer;
import haxe.Unserializer;



#if macro

  using haxe.macro.ExprTools;
  using haxe.macro.TypedExprTools;
  using haxe.macro.ComplexTypeTools;
  using tink.MacroApi;
#end

class M {

  static function get_fields(s:String) {
    trace(s.asComplexType().toType());
    trace(s.asComplexType().toType());
    trace(s.asComplexType().toType());
    var x:haxe.macro.Type = s.asComplexType().toType().sure();
    trace(x.getFields().sure());
    return 'suca';
  }


  public static inline function load_ast(name:String):Array<Field> {

        var s = File.getContent('__tmp/______${name}');


        var unserializer = new partials.Unserializer(s);
        var old_fields:Array<Field> = unserializer.unserialize();

/*
        var new_fields:Array<Field> = [for (field in old_fields) {
          field.pos = Context.currentPos();


          if (field.getVar().isSuccess()) {
            var vr = field.getVar().sure();

            switch (field.kind) {
              case FVar(_,expr):expr.pos = Context.currentPos();
              case _:null;
            }
            vr.expr = vr.expr.transform(function(_) {
              _.pos = null;
              return _;
            });
          }

          if (field.getFunction().isSuccess()) {
            var fn = field.getFunction().sure();
            fn.expr = fn.expr.transform(function(_) {
              _.pos = Context.currentPos();
              return _;
            });
          }

          field;
        }];
*/
        return old_fields;
  }


  public static inline function clean_pos(expr:haxe.macro.Expr) {
    return expr.transform(function(_) {
      _.pos = null;
      if (_.expr != null) trace(_.expr);
      //if (_.expr != null) _.expr = clean_pos(_.expr);

      return _;
    });

  }

  public static inline function save_ast(name:String,fields:Array<Field>) {
/*
    var new_fields:Array<Field> = [for (field in fields) {
      field.pos = null;



      if (field.getVar().isSuccess()) {
        var vr = field.getVar().sure();
        switch (field.kind) {
          case FVar(_,expr):{
            expr.pos = null;
            if (expr.expr != null) {
              expr = expr.transform(function(_) {
                _.pos = null;
                return _;
              });

            }
            expr;
          };
          case _:null;
        }
        vr.expr = vr.expr.transform(function(_) {
          _.pos = null;

          return _;
        });
      }

      if (field.getFunction().isSuccess()) {
        var fn = field.getFunction().sure();



        fn.expr = fn.expr.transform(function(_) {
          _.pos = null;
          return _;
        });
      }
      field;
    }];
*/

    var serializer = new partials.Serializer();
    serializer.serialize(fields);
    var s = serializer.toString();

    File.saveContent('__tmp/______${name}',s);

  }


  public static macro function get_ast(moduleName:ExprOf<String>):Array<Field> {
    var s = moduleName.getValue();
    trace(s);
    return load_ast(s);
  }

  public static macro function store_ast():Array<Field> {

    var local = Context.getLocalModule();
    var fields = Context.getBuildFields();

    save_ast(local,fields);
    //var _new_fields = load_ast(local);
/*
    var new_fields:Array<Field> = [for (field in fields) {
      field.pos = null;

      trace(field.pos);

      if (field.getVar().isSuccess()) {
        var vr = field.getVar().sure();
        trace(field);
        switch (field.kind) {
          case FVar(_,expr):expr.pos = null;
          case _:null;
        }
        vr.expr = vr.expr.transform(function(_) {
          _.pos = null;
          return _;
        });
      }

      if (field.getFunction().isSuccess()) {
        var fn = field.getFunction().sure();
        fn.expr = fn.expr.transform(function(_) {
          _.pos = null;
          return _;
        });
      }

      field;
    }];

    trace(new_fields);




    var serializer = new Serializer();
    serializer.serialize(new_fields);
    var s = serializer.toString();

    var unserializer = new Unserializer(s);
    var old_fields:Array<Field> = unserializer.unserialize();


    var new_fields:Array<Field> = [for (field in old_fields) {
      field.pos = Context.currentPos();


      if (field.getVar().isSuccess()) {
        var vr = field.getVar().sure();

        switch (field.kind) {
          case FVar(_,expr):expr.pos = Context.currentPos();
          case _:null;
        }
        vr.expr = vr.expr.transform(function(_) {
          _.pos = null;
          return _;
        });
      }

      if (field.getFunction().isSuccess()) {
        var fn = field.getFunction().sure();
        fn.expr = fn.expr.transform(function(_) {
          _.pos = Context.currentPos();
          return _;
        });
      }

      field;
    }];


    //trace(get_fields('Manna'));


    //var _s = new hxbit.Serializer();
    //var bytes = _s.serialize(_s);
/*
    fields = [for (field in fields) {
      trace(field);
      field.pos = null;
      field;
    }];

    var defl = new serialization.Deflater();
    defl.serialize(fields);
    var s = defl.toString();

    File.saveContent(local,s);
*/

    //trace(fields[0]);
    //var new_fields:Array<Field> = Json.parse(File.getContent(local));

    //var f = new FieldSerializer();

    //for (field in new_fields) {
    //  trace(field);
    //  field.pos = Context.currentPos();
    //}

    return [];

  }

}
