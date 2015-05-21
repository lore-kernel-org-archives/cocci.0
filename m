From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Thu, 21 May 2015 23:55:35 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <555E4A91.2010300@users.sourceforge.net>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
 <555E4A91.2010300@users.sourceforge.net>
Message-ID: <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

i tried this script

@r@
position p1;
identifier  arr;
constant i , var;
type T;
@@
 T arr[var];
... when != (i < var/ )
...
* arr[i]@p1

2015-05-21 23:13 GMT+02:00 SF Markus Elfring <elfring@users.sourceforge.net>
:

> > the script must detect an error on ( T[20] = 5 ;)
> > because there is an overflow of the array size.
>
> Did you experiment with any SmPL script already?
>
>
> > any suggestions please to implement this script ?
>
> Would you like to analyse affected source code
> only with constant array indexes?
>
> Do you need to check for inappropriate numbers with
> a bit of additional Python or OCaml programming?
>
> Regards,
> Markus
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150521/3ce0a78f/attachment.html>
