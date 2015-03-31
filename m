From: francois.armand.fa@gmail.com (=?UTF-8?Q?Fran=C3=A7ois_Armand?=)
Date: Tue, 31 Mar 2015 18:06:41 +0200
Subject: [Cocci] Patching nested if's?
In-Reply-To: <alpine.DEB.2.10.1503311748380.2749@hadrien>
References: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
 <alpine.DEB.2.10.1503311544490.2749@hadrien>
 <CABE47TEmsBv+f7PiqPEJ4ft+kdyaz0+FhGbAVRpuvNEmcF1AHg@mail.gmail.com>
 <alpine.DEB.2.10.1503311748380.2749@hadrien>
Message-ID: <CABE47TEqToaLdirtJgcsrgswLa3qt1Lwdaz1FQNA3fb13YLeCw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm on Ubuntu 14.04
spatch version 1.0.0-rc19 with Python support and with PCRE support



2015-03-31 17:49 GMT+02:00 Julia Lawall <julia.lawall@lip6.fr>:

>
>
> On Tue, 31 Mar 2015, Fran?ois Armand wrote:
>
> > Better send my real stuff, than making misleading typos :-)
> >
> > My code:
> > #define MAX_RETRIES 3
> >
> > tmy_status
> > my_getattr_timeout(tmy_ctx *ctx,
> >            u64 ino)
> > {
> >   tmy_status ret;
> >   int tries = 0;
> >   int delay = 1;
> >
> >  retry:
> >   ret = my_getattr(ctx, ino);
> >   if (MY_SUCCESS != ret)
> >     {
> >       if (MY_ENOENT != ret &&
> >           MY_EPERM != ret)
> >         {
> >           if (tries < MAX_RETRIES)
> >             {
> >               HANDLE_TIMEOUT(tries, delay, "ino %llu", ino);
> >               goto retry;
> >             }
> >           else
> >             {
> >               MY_TRACE(MY_ERROR, 0u, "getattr: ino %llu"": I/O error",
> ino);
> >               return MY_FAILURE;
> >             }
> >         }
> >     }
> >   return ret;
> > }
> >
> > A working patch
> > @@
> > expression t;
> > constant M;
> > @@
> >        if (
> > -       t < M
> > +          foo(&ctx->retry_ctx)
> >           )
> >           {
> >       ...
> >       } else {
> >       ...
> >       }
> >
> > A patch I can't make to work. That last one exists w/o producing anything
> >
> > @@
> > expression t;
> > constant M;
> > @@
> >  if (...)
> >  {
> >     if (...)
> >     {
> >        if (
> > -       t < M
> > +          foo(&ctx->retry_ctx)
> >           )
> >           {
> >       ...
> >       } else {
> >       ...
> >       }
> >     }
> >   }
>
> It seems to work fine for me:
>
> @@ -15,7 +15,7 @@ my_getattr_timeout(tmy_ctx *ctx,
>              if (MY_ENOENT != ret &&
>                           MY_EPERM != ret)
>                 {
> -                 if (tries < MAX_RETRIES)
> +                 if (foo(&ctx->retry_ctx))
>                       {
>                         HANDLE_TIMEOUT(tries, delay, "ino %llu", ino);
>                       goto retry;
>
> What version of Coccinelle do you have?
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150331/f929bd49/attachment-0001.html>
