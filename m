From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 7 Oct 2014 22:26:12 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <54344B08.6000008@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <5434416C.40205@users.sourceforge.net>
 <alpine.DEB.2.02.1410072144150.2079@localhost6.localdomain6>
 <54344B08.6000008@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1410072225400.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 7 Oct 2014, SF Markus Elfring wrote:

> >> Would you like to clarify corresponding details?
> > 
> > It is completely useless to me without knowing what C files are affected.
> 
> They are stored in a public repository.
> http://git.minix3.org/index.cgi?p=minix.git;a=tree
> 
> I guess that the 24 occurrences of the message 'Failure("lexing: empty token")'
> can be discussed a bit later.
> 
> 
> I got the message 'EXN:File "./ctlcocci_integration.ml", line 246, characters
> 4-10: Assertion failed' for the following source files.
> 1. external/bsd/llvm/dist/clang/test/Sema/statements.c
> 2. external/bsd/llvm/dist/clang/test/Sema/vla.c
> 3. external/bsd/llvm/dist/clang/test/Sema/scope-check.c
> 
> 
> I got the message 'EXN:Common.Timeout' for the following source files.
> 1. sys/external/bsd/compiler_rt/dist/test/Unit/udivmodti4_test.c
> 2. external/bsd/llvm/dist/clang/test/Parser/parser_overflow.c
> 3. external/public-domain/sqlite/dist/sqlite3.c
> 
> The command-line parameter "show-trying" does not display more useful
> information in these cases. Is this a bit strange?
> 
> 
> I got the message 'EXN:Failure("is_pass_through: node 612: return ...[1,2,259]
> in getanswer reachable by inconsistent control-flow paths")' for the source file
> 'lib/libc/net/gethnamaddr.c'.
> 
> 
> I got the message 'EXN:Failure("internal error: there is no noconst or
> novolatile keyword")' for the source file
> 'external/bsd/llvm/dist/clang/test/Sema/declspec.c'.

OK, thanks.  I will take a look at the cases other than the timeouts.  
Timeouts seem inevitable for this rule.

julia
