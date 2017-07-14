From: mansourmoufid@gmail.com (Mansour Moufid)
Date: Fri, 14 Jul 2017 18:26:16 -0400
Subject: [Cocci] how to ignore a list of identifiers
Message-ID: <CALogXGWDui-TbWueMb5c9FEH+h81n-MnR+Dn=BPA=aREoRmkCg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi everyone,

I'm trying to add the const qualifier to variables of a certain type,
except for a few.

For example, I'd like to modify this program:

    void foo(void) {
        int a = 1;
        int b = 2;
        int c = 3;
        int d = 4;
    }

to:

    void foo(void) {
        const int a = 1;
        int b = 2;
        const int c = 3;
        int d = 4;
    }

So far I've tried this semantic patch:

    @@
    identifier x != {b, d};
    @@
    + const
      int x = ...;

This works but only if all the identifiers in the list are in the source.

If the list is {b, z} for example, it doesn't work, and spatch says:

    (ONCE) Expected tokens z b

Is there an easy way to do this?

Thanks for your time.
