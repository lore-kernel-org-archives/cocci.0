From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Fri, 22 May 2015 12:13:02 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <555EFF6F.2030603@users.sourceforge.net>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
 <555E4A91.2010300@users.sourceforge.net>
 <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
 <555EC300.50503@users.sourceforge.net>
 <CABBGRWsyH6LZe-4wxZOyG7zcc0yp=t4MPE07ETBC+jnMne45bw@mail.gmail.com>
 <555EFF6F.2030603@users.sourceforge.net>
Message-ID: <CABBGRWtoj4=eyKeeW5x1yK2x2msUQDts-i9TjukxTX-HosfDOg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

i want that the script compare the index to the size of the array. if the
index is superior to the size , a warning must be printed.
i don't know if coccinelle can do this.

2015-05-22 12:05 GMT+02:00 SF Markus Elfring <elfring@users.sourceforge.net>
:

> > i don't get the expected result , ?
>
> How does it differ from your expectations?
>
>
> > the script must detect all the possible cases of the array size overflow.
>
> The goal is clear. How many software development challenges
> are you going to consider for such a purpose?
>
> Regards,
> Markus
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150522/31802bd9/attachment.html>
