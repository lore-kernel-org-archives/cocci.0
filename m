From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 20 Apr 2016 17:51:17 +0100
Subject: [Cocci] Dependencies between spatch hunks
In-Reply-To: <alpine.DEB.2.10.1604201827090.3089@hadrien>
References: <571787F0.7050200@gmail.com>
 <alpine.DEB.2.10.1604201749590.3089@hadrien>
 <5717ADB2.1050403@gmail.com>
 <alpine.DEB.2.10.1604201827090.3089@hadrien>
Message-ID: <CAB3z_RqnG46pYiFaFpFPzUHxHcnck9jtGTPgF7TJgwe+K8n7dg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20 Apr 2016 17:31, "Julia Lawall" <julia.lawall@lip6.fr> wrote:
>
>
>
> On Wed, 20 Apr 2016, Kieran Bingham wrote:
>
> > On 20/04/16 16:53, Julia Lawall wrote:
> > >
> > > On Wed, 20 Apr 2016, Kieran Bingham wrote:
> > >
> > >> Hi all,
> > >>
> > >> I am finding that a rule which matches a part of code, sometimes
causes
> > >> hunks which depend on it to act, and sometimes not to act
> > >>
> > >> My spatch is successfully removing and converting hunks that I desire
> > >> changed, however the requirement became apparent *to not process the
> > >> file at all* if the variable is used in the probe function, so I
added
> > >> in a dependency on probe_id_unused (established in my previous mail
thread).
> > >
> > > I'll check on the rest shortly, but if you really want to not process
the
> > > file at all, just look for the condition in which that is the case,
and
> > > then write a python rule that depends on it, and run Cocci.exit() (not
> > > sure about the exact syntax - writing an ocaml rule and putting
> > > Coccilib.exit() will also work).
> >
> >
> > Thanks Julia,
> >
> > The following worked for my needs:
> >
> > @ script:python depends on driver && !probe_id_unused @
> > @@
> > print("Probe function uses the ID parameter")
> > cocci.exit()
> >
> > However, interestingly - it's not useful if I specify a minimal set of
> > files on the command line:
> >
> > Using the command:
> > spatch --linux-spacing --sp-file patches/i2c-dt.cocci $A $B $C $D
> > HANDLING: sound/soc/codecs/wm8737.c drivers/staging/iio/light/isl29018.c
> > drivers/gpio/gpio-pca953x.c ./drivers/rtc/rtc-ds1307.c
> > Probe function uses the ID parameter
> > kbingham at CookieMonster:/opt/projects/linux/kbuild-bbb/sources/linux$
> >
> > appears to stop at the first file (which is expected to stop) without
> > processing the next files.
> >
> > However, simply using the '.' target - does appear to iterate through
> > the entire sources successfully, parsing files it can, and stopping on
> > files that it should stop on.
>
> Putting multiple files on the command line is not the right way to process
> multiple files.  What that means is to process those files all at once.
> Normally Coccinelle processes only one file at a time, which means that
> when there is a call from a function in one file to a function in another,
> it won't find the definition of the called function.  If you put multiple
> files on the command line, it will see them all at once.  The downside
> though is that Coccinelle will ultimately run more slowly, because it will
> be using a lot more memory at a given time.
>
> If you have a directory where you want to process only some of the files,
> you can use the --file-groups <file> option.  <file> could be eg
>
> path/foo.c
> path/bar.c
>
> path/xyz.c
>
> Then foo.c and bar.c will be processed at once, and xyz.c will be
> processed separately.
>
> But it could be easier to just work on the whole directory and let
> Coccinelle to fail to do anything with most of the files.

Ah I see.  I bet that explains my other dependency issue as well.  It was
probably matching state from other processed files in the same processing
group.

I had been specifying a group of files to make sure the right thing was
being done in the processing. In the whole tree about 250 files match so I
was trying to reduce the set to verify.

It looks like the act of me trying to reduce the set changed the processing
though ;-)

I guess I could create a single folder with the reduced set in, but it
looks like its doing the right thing now with the exit ()

Thanks

Kieran

>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160420/81814080/attachment.html>
