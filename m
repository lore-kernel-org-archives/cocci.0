From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 15:46:52 +0100 (CET)
Subject: [Cocci] if (...) {} semantic patch
In-Reply-To: <20131102133648.GA4190@leaf>
References: <20131102133648.GA4190@leaf>
Message-ID: <alpine.DEB.2.02.1311021541590.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I think that there are more side-effecting expressions that you should
consider, eg E += E2, etc.

The following lines from the SmPL lexer shows the operators that are
supported:

  | "-="           { start_line true; mkassign Ast.Minus lexbuf }
  | "+="           { start_line true; mkassign Ast.Plus lexbuf }
  | "*="           { start_line true; mkassign Ast.Mul lexbuf }
  | "/="           { start_line true; mkassign Ast.Div lexbuf }
  | "%="           { start_line true; mkassign Ast.Mod lexbuf }
  | "&="           { start_line true; mkassign Ast.And lexbuf }
  | "|="           { start_line true; mkassign Ast.Or lexbuf }
  | "^="           { start_line true; mkassign Ast.Xor lexbuf }
  | ">?="           { start_line true; mkassign Ast.Max lexbuf }
  | "<?="           { start_line true; mkassign Ast.Min lexbuf }
  | "<<="          { start_line true; mkassign Ast.DecLeft lexbuf }
  | ">>="          { start_line true; mkassign Ast.DecRight lexbuf }

Also, if the output from -D patch is sometimes undesirable, it would be
useful to mention that in the initial comments about the semantic patch,
so that the user knows that there is something to look for.  The
convention seems to be to put such comments after //#

julia
