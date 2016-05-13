From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 May 2016 19:08:06 +0200 (CEST)
Subject: [Cocci] remove redundant const qualifiers from function
 arguments
In-Reply-To: <20160511184830.GG3766@xsjsorenbubuntu>
References: <20160511031419.GY3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110738430.5606@hadrien>
 <20160511055515.GA3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110758230.5606@hadrien>
 <20160511060438.GB3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605111148220.5036@hadrien>
 <20160511184830.GG3766@xsjsorenbubuntu>
Message-ID: <alpine.DEB.2.10.1605131906170.3223@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 11 May 2016, S?ren Brinkmann wrote:

> Hi Julia,
>
> On Wed, 2016-05-11 at 11:51:43 +0200, Julia Lawall wrote:
> >
> >
> > On Tue, 10 May 2016, S?ren Brinkmann wrote:
> >
> > > On Wed, 2016-05-11 at 07:59:06 +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 10 May 2016, S?ren Brinkmann wrote:
> > > >
> > > > > Hi Julia,
> > > > >
> > > > > On Wed, 2016-05-11 at 07:41:20 +0200, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Tue, 10 May 2016, S?ren Brinkmann wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > I'm trying to remove 'const' qualifiers from function arguments that are
> > > > > > > passed by value.
> > > > > > >
> > > > > > > e.g. I want to convert:
> > > > > > >
> > > > > > > void foobar(const int bar, const int *baz);
> > > > > > > to
> > > > > > > void foobar(int bar, const int *baz);
> > > > > > >
> > > > > > > I came up with this semantic patch:
> > > > > > > /* Remove const from arguments passed by value */
> > > > > > > @ rule1 @
> > > > > > > identifier fi, I;
> > > > > > > type T;
> > > > > > > @@
> > > > > > >  fi ( ...,
> > > > > > > -	const T
> > > > > > > +	T
> > > > > > > 	I
> > > > > > > 	,...
> > > > > > >  )
> > > > > > >  { ... }
> > > > > > >
> > > > > > > That seems to work fine on function declarations, but does not cover
> > > > > > > function prototypes. Extending the patch to function prototypes I ran
> > > > > > > into some trouble. As complete separate patch, I evolved the above to
> > > > > > > (just replacing the function body with a ';'):
> > > > > > > /* Remove const from arguments passed by value */
> > > > > > > @ rule1 @
> > > > > > > identifier fi, I;
> > > > > > > type T;
> > > > > > > @@
> > > > > > >  fi ( ...,
> > > > > > > -	const T
> > > > > > > +	T
> > > > > > > 	I
> > > > > > > 	,...
> > > > > > >  ) ;
> > > > > > >
> > > > > > > But that is not parsed by spatch, causing this error:
> > > > > > >   init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> > > > > > >   minus: parse error:
> > > > > > >     File "const_proto.cocci", line 9, column 1, charpos = 115
> > > > > > >     around = 'I',
> > > > > > >     whole content = '     I'
> > > > > > >
> > > > > > > Also, using the first version of a patch on a c-file with matching function
> > > > > > > declarations that also includes function prototypes, results in both,
> > > > > > > declarations and prototypes, while using it on a header with prototypes
> > > > > > > only doesn't result in any replacements.
> > > > > > >
> > > > > > > I attach the patches and some test files for reference.
> > > > > > > const.cocci apparently correctly removes all const keywords from the
> > > > > > > test.c file, but does not change the .h at all (which is correct, just
> > > > > > > weird that it changes the prototype in the .c).
> > > > > > >
> > > > > > > The const_proto.cocci file causes the above-mentioned error.
> > > > > > >
> > > > > > > Does anybody know what I'm missing here?
> > > > > >
> > > > > > By default, when you change a function header, Coccinell changes the
> > > > > > prototype accordingly.  But to be able to do that it needs to have access
> > > > > > to the prototype.  So you may need to give an argument like --all-includes
> > > > > > (include all the .h files mentioned in the .c file) or --recursive-incudes
> > > > > > (include all the .h files recurively included by any .h file mentioned in
> > > > > > the .c file).  --recursive-includes at least may be slow, but things will
> > > > > > be done in a consistent manner.
> > > > >
> > > > > Interesting. I tried different variations of the include switches on the
> > > > > real code base, but none resulted in the headers to be updated. Though,
> > > > > with those switches I get 'different modification result for foo.h' warnings.
> > > > >
> > > > > For the test files, including the header in the c file and running
> > > > > spatch with --local-includes works as expected.
> > > > >
> > > > > Guess I'll dig into the headers and check if there are any unusual
> > > > > constructs causing the problem. Any hints would be appreciated :)
> > > > >
> > > > > > I will check on why the expliciti prototype rule doesn't parse.
> > > > >
> > > > > Thanks for looking into it.
> > > >
> > > > Could you send an example of a .c and .h file where the result is not as
> > > > expected?
> > >
> > > It works now... It seems something is handled significantly different
> > > depending on how the target files are specified on the command line.
> > >
> > > Initially I ran:
> > >   spatch --sp-file const.cocci --local-includes --in-place --dir .
> > > and now with your hints, I changed to
> > >   spatch --sp-file const.cocci --local-includes --in-place *.c
> > >
> > > That way headers are updated as expected and the warnings are gone.
> > >
> > > I can try to condense a small test case tomorrow, if you're interested/necessary.
> >
> > --dir is the proper solution.  Since it is not working, I would be
> > interested in having a test case.  I guess it should be a directory with
> > multiple .c files.
> >
> > When you put multiple files on the command line, you are treating them all
> > at once, ie they are all parsed and in memory at the same time.  This is
> > good if there are references between .c files that have to be taken into
> > account.  But obviously it doesn't scale.  On the other hand, .h files
> > should be treated at the same time as the .c files that reference them, so
> > it should work.
>
> I think I have a test case that is minimal.
> I attach the following files:
>  - module_a.c  -- c source
>  - module_a.h  -- c header providing prototypes for functions in module_a.c
>  - module_b.c  -- c source including module_a.h
>  - const.cocci  -- semantic patch using fundecl syntax
>  - const_proto.cocci  -- semantic patch using funproto syntax
>
> The patch with funproto syntax fails as described above and is also
> redundant when headers are included in the transformation the other
> patch is doing.
>
> When I run:
>   spatch --sp-file const.cocci --local-includes --in-place *.c
> things work fine and both, module_a[ch], get updated as intended.
>
> When I run
>   spatch --sp-file const.cocci --local-includes --in-place --dir .
> then only the c files are updated (in-place). But, the patch output
> includes the correct header transformation (I was expecting headers to
> be updated in-place too, just as in the first case).
> Also, removing module_b.c from the test, makes spatch update both
> module.[ch] in place.

Thanks for the example files.  When you run with --dir ., the output
gives:

different modification result for ./module_a.h

It detects that the resulting files are different when processed via the
different includes, so it doesn't want to overwrite the file with one
thing or the other.

julia
