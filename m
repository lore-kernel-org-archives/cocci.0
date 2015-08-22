From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Aug 2015 07:09:54 -0700 (PDT)
Subject: [Cocci] 1.0.2
Message-ID: <alpine.DEB.2.10.1508220653050.2531@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Some of the main changes:

* OCaml 3.10 is no longer supported.

* --use-gitgrep falls back to --use-coccigrep for a non-git repository.
Thus, it is generally safe to use --use-gitgrep, except when processing an
unmanaged subdirectory of a git repository.

* It is no longer possible to create an identifier in OCaml code by saying
x := "identifier_name".  Instead some constructors have been added for
constructing various kinds of code:

val make_ident : string -> Ast_c.metavar_binding_kind
   (* string is the identifier name *)

val make_expr : string -> Ast_c.metavar_binding_kind
   (* string is the expression *)

val make_expr_with_env : string -> string -> Ast_c.metavar_binding_kind
   (* The first argument is a series of variable declarations, designed to
      provide type information for the second argument, which is an
      expression.  For example, make_expr_with_env "int x;" "x+3". *)

val make_stmt : string -> Ast_c.metavar_binding_kind
   (* The string argument is a statement *)

val make_stmt_with_env : string -> string -> Ast_c.metavar_binding_kind
   (* The first argument is a series of declarations and the second
      argument is the statement to create *)

val make_type : string -> Ast_c.metavar_binding_kind
   (* The string is the type to create *)

val make_listlen : int -> Ast_c.metavar_binding_kind
   (* The integer is the list length to create, eg for a parameter list *)

val make_position :
  Common.filename ->
  string -> int -> int -> int -> int -> Ast_c.metavar_binding_kind
    (* The arguments are: file name (string), function name, start line,
       start column, end line, end column.  Lines start with 1, columns
       start with 0. *)

* exp at S will bind statement metavariable to the smallest statement
enclosing the expression exp.  For example, for the C code, return x;, x at S
would match S to return x;

* If an identifier metavariable is constrained to match a set of possible
names, eg identifier fn = {kmalloc, kfree};, then these names will be
taken into account when selecting files.  On the other hand, constraints
expressed as regular expressions are still not taken into account.

* Autogen creates a version number that corresponds to the most recent
commit.

* -j should now work correctly.

julia
