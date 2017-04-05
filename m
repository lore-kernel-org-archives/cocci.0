From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Apr 2017 07:25:37 +0200 (CEST)
Subject: [Cocci] question on parsing g_assert_cmpint() macro
In-Reply-To: <ec3eceb6-9f04-b04c-a09c-92f744d23f36@redhat.com>
References: <ec3eceb6-9f04-b04c-a09c-92f744d23f36@redhat.com>
Message-ID: <alpine.DEB.2.20.1704050723290.2242@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Apr 2017, Eric Blake wrote:

> I'm trying to use the following rather-simple coccinelle patch to
> simplify qemu:
>
> @@
> expression Obj, Key, E;
> @@
> - qdict_put(Obj, Key, qint_from_int(E));
> + qdict_put_int(Obj, Key, E);
>
> I noticed by chance, however, that it only found some, and not all,
> instances of the pattern in the file tests/check-qdict.c
> (git.qemu-project.org/?p=qemu.git;a=blob;f=tests/check-qdict.c;h=81162ee).
>  Running 'spatch --verbose-parsing ...' finally let me figure out why:
>
> ...
> parse error
>  = File "tests/check-qdict.c", line 473, column 55, charpos = 10131
>   around = '==',
>   whole content =     g_assert_cmpint(qdict_array_entries(dict, "foo."),
> ==, 0);
> badcount: 44
> bad: }
> bad:
> bad: static void qdict_array_entries_test(void)
> bad: {
> bad:     QDict *dict = qdict_new();
> bad:
> BAD:!!!!!     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 0);
> bad:
> bad:     qdict_put(dict, "bar", qint_from_int(0));
> bad:     qdict_put(dict, "baz.0", qint_from_int(0));
> ...
>
> So the fact that the g_assert_cmpint() macro (from glib,
> https://developer.gnome.org/glib/stable/glib-Testing.html#g-assert-cmpint)
> has unusual semantics that make it called differently than a normal C
> function (the second argument '==' is what the parser chokes on) means
> that coccinelle is then ignoring the ENTIRE function where the parse
> problem occurred, and missing the instance of my pattern just afterwards.
>
> What is the trick for teaching coccinelle about what g_assert_cmpint()
> expands to, and/or completely ignoring the use of that macro, so that I
> don't have to manually look for spots that the cleanup missed?

Try adding

#define g_assert_cmpint(x,y,z)

to the macro definition file standard.h.  Or you can make your own macro
definition file for qemu and give it as an argument --macro-file file.h

Write back if that does not solve the problem.

julia


>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>
