From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 10 May 2016 22:55:15 -0700
Subject: [Cocci] remove redundant const qualifiers from function
	arguments
In-Reply-To: <alpine.DEB.2.10.1605110738430.5606@hadrien>
References: <20160511031419.GY3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110738430.5606@hadrien>
Message-ID: <20160511055515.GA3766@xsjsorenbubuntu>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Wed, 2016-05-11 at 07:41:20 +0200, Julia Lawall wrote:
> 
> 
> On Tue, 10 May 2016, S?ren Brinkmann wrote:
> 
> > Hi,
> >
> > I'm trying to remove 'const' qualifiers from function arguments that are
> > passed by value.
> >
> > e.g. I want to convert:
> >
> > void foobar(const int bar, const int *baz);
> > to
> > void foobar(int bar, const int *baz);
> >
> > I came up with this semantic patch:
> > /* Remove const from arguments passed by value */
> > @ rule1 @
> > identifier fi, I;
> > type T;
> > @@
> >  fi ( ...,
> > -	const T
> > +	T
> > 	I
> > 	,...
> >  )
> >  { ... }
> >
> > That seems to work fine on function declarations, but does not cover
> > function prototypes. Extending the patch to function prototypes I ran
> > into some trouble. As complete separate patch, I evolved the above to
> > (just replacing the function body with a ';'):
> > /* Remove const from arguments passed by value */
> > @ rule1 @
> > identifier fi, I;
> > type T;
> > @@
> >  fi ( ...,
> > -	const T
> > +	T
> > 	I
> > 	,...
> >  ) ;
> >
> > But that is not parsed by spatch, causing this error:
> >   init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> >   minus: parse error:
> >     File "const_proto.cocci", line 9, column 1, charpos = 115
> >     around = 'I',
> >     whole content = '     I'
> >
> > Also, using the first version of a patch on a c-file with matching function
> > declarations that also includes function prototypes, results in both,
> > declarations and prototypes, while using it on a header with prototypes
> > only doesn't result in any replacements.
> >
> > I attach the patches and some test files for reference.
> > const.cocci apparently correctly removes all const keywords from the
> > test.c file, but does not change the .h at all (which is correct, just
> > weird that it changes the prototype in the .c).
> >
> > The const_proto.cocci file causes the above-mentioned error.
> >
> > Does anybody know what I'm missing here?
> 
> By default, when you change a function header, Coccinell changes the
> prototype accordingly.  But to be able to do that it needs to have access
> to the prototype.  So you may need to give an argument like --all-includes
> (include all the .h files mentioned in the .c file) or --recursive-incudes
> (include all the .h files recurively included by any .h file mentioned in
> the .c file).  --recursive-includes at least may be slow, but things will
> be done in a consistent manner.

Interesting. I tried different variations of the include switches on the
real code base, but none resulted in the headers to be updated. Though,
with those switches I get 'different modification result for foo.h' warnings.

For the test files, including the header in the c file and running
spatch with --local-includes works as expected.

Guess I'll dig into the headers and check if there are any unusual
constructs causing the problem. Any hints would be appreciated :)

> I will check on why the expliciti prototype rule doesn't parse.

Thanks for looking into it.

	S?ren
