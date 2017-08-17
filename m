From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Aug 2017 18:54:51 +0200 (CEST)
Subject: [Cocci] spatch / semantic patch missing some conversions?
In-Reply-To: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
References: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708171853140.3748@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 17 Aug 2017, Dan Williams wrote:

> Hi,
>
> I'm trying to write a semantic patch that will add a flags argument to
> all mmap routines that appear in a struct file_operations instance.
> The semantic patch at the bottom of this mail mostly works, but I
> still end up needing to add rules like:
>
> @@
> identifier x, y;
> @@
>
> int bochs_mmap(struct file *x,
>                 struct vm_area_struct *y
> - )
> + , unsigned long map_flags)
> {
> ...
> }
>
> ...to catch straggling routines that get missed. What is confusing me
> is that when I run the below with --all-includes the *header* file
> where bochs_mmap() is declared is properly updated, but not the actual
> definition.  Is it possible that the identification of bochs_mmap() as
> an mmap operation occurs after we've already processed the file with
> the definition? That seems to be the common pattern among the failures
> I've seen (cirrus_mmap, qxl_mmap, hibmc_mmap...). I.e. occasions where
> the mmap routine is defined in a different file than the struct
> file_operations that consumes it get missed.
>
> ---
>
> @ a @
> identifier fn;
> identifier ops;
> @@
>
> struct file_operations ops = { ..., .mmap = fn, ...};
>
> @@
> identifier a.fn;
> identifier x, y;
> @@
>
> int fn(struct file *x,
>         struct file *y

Actually, the main problem is here.  y should have type vm_area_struct.
So I guess that no function definitions were getting updated at all,
regardless of the file in which they were defined.  I have made the more
general rule in any case, and will send it as soon as it looks like
everything is ok.

julia

> -       )
> +       , unsigned long map_flags)
> {
> ...
> }
>
> @@
> identifier a.fn;
> identifier x, y;
> @@
>
> int fn(struct file *x,
>         struct vm_area_struct *y
> -       );
> +       , unsigned long map_flags);
>
> @@
> identifier a.fn;
> @@
>
> int fn(struct file *,
>         struct vm_area_struct *
> -       );
> +       , unsigned long);
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
