From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Fri, 22 May 2015 10:59:21 +0200
Subject: [Cocci] array index range checking
In-Reply-To: <555EC300.50503@users.sourceforge.net>
References: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
 <555E4A91.2010300@users.sourceforge.net>
 <CABBGRWtnRi0UmDeaemtx-=S8bznO2K-_8jjB_v9sEgHnQUN9QQ@mail.gmail.com>
 <555EC300.50503@users.sourceforge.net>
Message-ID: <CABBGRWsyH6LZe-4wxZOyG7zcc0yp=t4MPE07ETBC+jnMne45bw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

i don't get the expected result , because my goal is to detect the overflow
of the array size.
when we have a defined array, when we access to this array the script must
print a warning when the index is superior to the size of the array. this
index can be a constant or a variable. the script must detect all the
possible cases of the array size overflow.

2015-05-22 7:47 GMT+02:00 SF Markus Elfring <elfring@users.sourceforge.net>:

> > i tried this script
> >
> > @r@
> > position p1;
> > identifier  arr;
> > constant i , var;
> > type T;
> > @@
> >  T arr[var];
>
> Does this SmPL approach work a bit as you expect?
> Which details did not satisfy you so far?
>
>
> > ... when != (i < var/ )
>
> How do you think about to omit parentheses here?
>
>
> > ...
> > * arr[i]@p1
>
> Would you like to reuse the data from the position variable anywhere?
>
> How do you want to handle scopes for the involved array indexes?
> http://en.cppreference.com/w/c/language/scope
>
> Regards,
> Markus
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150522/627757b5/attachment-0001.html>
