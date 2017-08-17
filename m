From: dan.j.williams@gmail.com (Dan Williams)
Date: Thu, 17 Aug 2017 08:35:02 -0700
Subject: [Cocci] spatch / semantic patch missing some conversions?
Message-ID: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm trying to write a semantic patch that will add a flags argument to
all mmap routines that appear in a struct file_operations instance.
The semantic patch at the bottom of this mail mostly works, but I
still end up needing to add rules like:

@@
identifier x, y;
@@

int bochs_mmap(struct file *x,
                struct vm_area_struct *y
- )
+ , unsigned long map_flags)
{
...
}

...to catch straggling routines that get missed. What is confusing me
is that when I run the below with --all-includes the *header* file
where bochs_mmap() is declared is properly updated, but not the actual
definition.  Is it possible that the identification of bochs_mmap() as
an mmap operation occurs after we've already processed the file with
the definition? That seems to be the common pattern among the failures
I've seen (cirrus_mmap, qxl_mmap, hibmc_mmap...). I.e. occasions where
the mmap routine is defined in a different file than the struct
file_operations that consumes it get missed.

---

@ a @
identifier fn;
identifier ops;
@@

struct file_operations ops = { ..., .mmap = fn, ...};

@@
identifier a.fn;
identifier x, y;
@@

int fn(struct file *x,
        struct file *y
-       )
+       , unsigned long map_flags)
{
...
}

@@
identifier a.fn;
identifier x, y;
@@

int fn(struct file *x,
        struct vm_area_struct *y
-       );
+       , unsigned long map_flags);

@@
identifier a.fn;
@@

int fn(struct file *,
        struct vm_area_struct *
-       );
+       , unsigned long);
