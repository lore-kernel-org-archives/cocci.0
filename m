From: eblake@redhat.com (Eric Blake)
Date: Tue, 4 Apr 2017 17:11:28 -0500
Subject: [Cocci] question on parsing g_assert_cmpint() macro
Message-ID: <ec3eceb6-9f04-b04c-a09c-92f744d23f36@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to use the following rather-simple coccinelle patch to
simplify qemu:

@@
expression Obj, Key, E;
@@
- qdict_put(Obj, Key, qint_from_int(E));
+ qdict_put_int(Obj, Key, E);

I noticed by chance, however, that it only found some, and not all,
instances of the pattern in the file tests/check-qdict.c
(git.qemu-project.org/?p=qemu.git;a=blob;f=tests/check-qdict.c;h=81162ee).
 Running 'spatch --verbose-parsing ...' finally let me figure out why:

...
parse error
 = File "tests/check-qdict.c", line 473, column 55, charpos = 10131
  around = '==',
  whole content =     g_assert_cmpint(qdict_array_entries(dict, "foo."),
==, 0);
badcount: 44
bad: }
bad:
bad: static void qdict_array_entries_test(void)
bad: {
bad:     QDict *dict = qdict_new();
bad:
BAD:!!!!!     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 0);
bad:
bad:     qdict_put(dict, "bar", qint_from_int(0));
bad:     qdict_put(dict, "baz.0", qint_from_int(0));
...

So the fact that the g_assert_cmpint() macro (from glib,
https://developer.gnome.org/glib/stable/glib-Testing.html#g-assert-cmpint)
has unusual semantics that make it called differently than a normal C
function (the second argument '==' is what the parser chokes on) means
that coccinelle is then ignoring the ENTIRE function where the parse
problem occurred, and missing the instance of my pattern just afterwards.

What is the trick for teaching coccinelle about what g_assert_cmpint()
expands to, and/or completely ignoring the use of that macro, so that I
don't have to manually look for spots that the cleanup missed?

-- 
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 604 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170404/45f19db4/attachment.asc>
