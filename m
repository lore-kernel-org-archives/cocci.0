From: francois.armand.fa@gmail.com (=?UTF-8?Q?Fran=C3=A7ois_Armand?=)
Date: Tue, 31 Mar 2015 17:18:13 +0200
Subject: [Cocci] Patching nested if's?
In-Reply-To: <alpine.DEB.2.10.1503311544490.2749@hadrien>
References: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
 <alpine.DEB.2.10.1503311544490.2749@hadrien>
Message-ID: <CABE47TEmsBv+f7PiqPEJ4ft+kdyaz0+FhGbAVRpuvNEmcF1AHg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Better send my real stuff, than making misleading typos :-)

My code:
#define MAX_RETRIES 3

tmy_status
my_getattr_timeout(tmy_ctx *ctx,
           u64 ino)
{
  tmy_status ret;
  int tries = 0;
  int delay = 1;

 retry:
  ret = my_getattr(ctx, ino);
  if (MY_SUCCESS != ret)
    {
      if (MY_ENOENT != ret &&
          MY_EPERM != ret)
        {
          if (tries < MAX_RETRIES)
            {
              HANDLE_TIMEOUT(tries, delay, "ino %llu", ino);
              goto retry;
            }
          else
            {
              MY_TRACE(MY_ERROR, 0u, "getattr: ino %llu"": I/O error", ino);
              return MY_FAILURE;
            }
        }
    }
  return ret;
}

A working patch
@@
expression t;
constant M;
@@
       if (
-       t < M
+          foo(&ctx->retry_ctx)
          )
          {
      ...
      } else {
      ...
      }

A patch I can't make to work. That last one exists w/o producing anything

@@
expression t;
constant M;
@@
 if (...)
 {
    if (...)
    {
       if (
-       t < M
+          foo(&ctx->retry_ctx)
          )
          {
      ...
      } else {
      ...
      }
    }
  }


2015-03-31 15:47 GMT+02:00 Julia Lawall <julia.lawall@lip6.fr>:

> > I came up with the following invalid attempt
> > @@
> > expression t;
> > constant M;
> > @@
> >  if (...)
>
> I think that the only problem is that you are missing an open brace here,
> after the first if line.
>
> >     if (...)
> >     {
> >        if (
> > -       t < M
> > +          myfunc()
> >           )
> >           {
> >       ...
> >       } else {
> >       ...
> >       }
>
> Markus suggested to put else S here.  Doing that would allow the else to
> disappear, if sometimes in your code there is no else in this case.  If
> any of your ifs may or may not have an else, you can put eg else S1, else
> S2, else S3.  An isomorphism will allow them all to disppear.
>
> julia
>
> >     }
> >   }
> >
> > Thanks for any hint.
> >
> >
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150331/628f0ced/attachment.html>
