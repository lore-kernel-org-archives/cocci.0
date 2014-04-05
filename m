From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 5 Apr 2014 22:13:19 +0200 (CEST)
Subject: [Cocci] Trivial question about renaming prototypes in .h files
In-Reply-To: <20140405193259.GA10489@harvey.netwinder.org>
References: <20140405155421.GA20098@harvey.netwinder.org>
 <alpine.DEB.2.02.1404051944510.2029@localhost6.localdomain6>
 <20140405193259.GA10489@harvey.netwinder.org>
Message-ID: <alpine.DEB.2.02.1404052207160.2029@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> By the way, the HTML version of the same document seems to have some
> extraneous symbols such as @M which results in syntax errors from spatch.
> http://coccinelle.lip6.fr/docs/main_grammar013.html#toc1

Thanks for the report.  I have the impression that those are intended to 
produce colors in the pdf version, but it is not very nice for them to be 
preserved in the html version.  I will see if something can be done about 
it.

> > If you want to rename the function foo to bar, then you would write:
> > 
> > @@
> > @@
> > 
> > - foo
> > + bar
> >     () { ... }
> > 
> > This should update any prototype of the function as well.
> 
> Thanks, that helps. I'll have to study some more to understand why that
> works. In particular, I would not have expected {...} to match against
> a function prototype, which just has ";" in that position. Perhaps that
> is handled by one of the standard isomophisms?

Yes, it transforms any change on the header of a function definition to 
make the corresponding change on any detected prototype.

> I have also found that the .h files are only patched correctly when I
> list them explicitly on the command line. Seemingly as a result of this,
> the --dir option does not work for processing .h files:
> 
> spatch --sp-file rename.cocci test.c test.h   # works correctly, both .c/.h
> spatch --sp-file rename.cocci test.c          # works correctly, only .c
> spatch --sp-file rename.cocci test.h          # no patch is emitted
> spatch --sp-file rename.cocci --dir .         # only patches .c
> spatch --sp-file rename.coccy --dir . --include-headers # only patches .c

I think that the issue is that the prototype rules require the 
corresponding function definition rule to match.  So, actually, you have 
to use an argument like --all-includes to get it to look for all of the 
include files of each .c file.  You can then drop the --include-headers 
argument.  That treats the .h files individually, which doesn't help you, 
because it only sees the prototype.

Of course, you can just make a rule for the prototype by yourself.  Then 
if you use --include-headers if should use your prototype rule on the 
header files.

Note that for a function definition, you don't have to specify the return 
type, but for a rule that is to match a prototype, you do have to.  
Otherwise, the parser has a conflict with a function call.  If you have no 
type in mind, you can define a metavariable type T; and then use T.

julia
