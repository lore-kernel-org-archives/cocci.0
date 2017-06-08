From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 8 Jun 2017 13:34:58 +0200 (CEST)
Subject: [Cocci] "bad" macros in struct definitions
In-Reply-To: <alpine.DEB.2.20.1706081328160.3005@hadrien>
References: <CAKwiHFjkufqumwhStrpsqwJb8x8OGc989XhQY_YWbc=rkCXabw@mail.gmail.com>
 <alpine.DEB.2.20.1706081300350.3005@hadrien>
 <CAKwiHFjTA1grGYjjhq=i0-o0D1bjZbgiDBc1q5=RW+i-8styKA@mail.gmail.com>
 <alpine.DEB.2.20.1706081328160.3005@hadrien>
Message-ID: <alpine.DEB.2.20.1706081331230.3005@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 8 Jun 2017, Julia Lawall wrote:

>
>
> On Thu, 8 Jun 2017, Rasmus Villemoes wrote:
>
> > On 8 June 2017 at 13:02, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > >
> > >
> > > Could you send a concrete semantic patch and .c file that is not givig the
> > > desired result?  Coccinelle does parsing in multiple passes.  It may fail
> > > on an earlier pass (and emit error messages if you use --verbose-parsing)
> > > but still succeed on a later one.
> >
> > Something like the attached. As is, I get
> >
> > $ spatch --macro-file test.h --sp-file ./test.cocci ./test.c
>
> Try using --macro-file-builtins instead.

The documentation says:

--macro-file:

  Extra macro definitions to be taken into account when parsing the C
  files.  This uses the provided macro definitions in addition to those in
  the default macro file.

--macro-file-builtins:

  Builtin macro definitions to be taken into account when parsing the C
  files.  This causes the macro definitions provided in the default macro
  file to be ignored and the ones in the specified file to be used instead.

I will check on why --macro-file doesn't work.  But I find the names of
these options very unsatisfactory - I can never remember which is which,
nor even what the choices are.  Maybe it would not be good to remove them,
but I would consider adding --extend-macro-file and --replace-macro-file,
as being more memorable.

julia
