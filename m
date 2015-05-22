From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 22 May 2015 13:11:34 +0200 (CEST)
Subject: [Cocci] array index range checking
In-Reply-To: <CABBGRWtoj4=eyKeeW5x1yK2x2msUQDts-i9TjukxTX-HosfDOg@mail.gmail.com>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
 <555E4A91.2010300@users.sourceforge.net>
 <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
 <555EC300.50503@users.sourceforge.net>
 <CABBGRWsyH6LZe-4wxZOyG7zcc0yp=t4MPE07ETBC+jnMne45bw@mail.gmail.com>
 <555EFF6F.2030603@users.sourceforge.net>
 <CABBGRWtoj4=eyKeeW5x1yK2x2msUQDts-i9TjukxTX-HosfDOg@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1505221311210.1551@cocci>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 22 May 2015, Zied Habtoul wrote:

> i want that the script compare the index to the size of the array. if the
> index is superior to the size , a warning must be printed.
> i don't know if coccinelle can do this.
>

I doubt that Coccinelle is really the right tecnique for this problem. 
Coccinelle can detect when there are no checks at all.  But it will not 
detect the case where you check but on the wrong value.  Coccinelle 
doesn't know anything about eg the values of particular variables.  Maybe 
some other tools in the Linux kernel such as smatch or sparse would be 
more helpful in this case.

julia


> 2015-05-22 12:05 GMT+02:00 SF Markus Elfring
> <elfring@users.sourceforge.net>:
>       > i don't get the expected result , ?
>
>       How does it differ from your expectations?
> 
>
>       > the script must detect all the possible cases of the array
>       size overflow.
>
>       The goal is clear. How many software development challenges
>       are you going to consider for such a purpose?
>
>       Regards,
>       Markus
> 
> 
> 
>
