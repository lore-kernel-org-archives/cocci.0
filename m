From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 6 Oct 2014 12:49:52 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141006102500.GC8551@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.02.1410021858360.2062@localhost6.localdomain6>
 <20141006102500.GC8551@rei.suse.cz>
Message-ID: <alpine.DEB.2.10.1410061249210.2354@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 6 Oct 2014, Cyril Hrubis wrote:

> Hi!
> > > I've found a small nit in the handling of strings that spans over
> > > multiple lines:
> > >
> > > nit.c:
> > > int main(void)
> > > {
> > >         f("This is a string that continues to the next line"
> > >           " just string continuation");
> > > }
> >
> > The patch below solves this problem as well as the one with the long
> > string in the argument list.
>
> It's better but it produces changes like this:
>
> @@ -250,9 +250,14 @@ void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
>         off_t offloc;
>
>         if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
> -               tst_resm(TFAIL, "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
> -                        offloc, fdesc, offset, whence, checkoff, errno);
> -               tst_exit();
> +               tst_brkm(TFAIL, NULL,
> +                        "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
> +                        offloc,
> +                        fdesc,
> +                        offset,
> +                        whence,
> +                        checkoff,
> +                        errno);
>         }
>  }
>
> Which seems to be waste of vertical space to me.

Ah.  Indeed.  Thanks for the report.  I will look into it.  Some counter
must not be getting reset.

julia
