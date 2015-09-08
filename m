From: joern@purestorage.com (=?iso-8859-1?Q?J=F6rn?= Engel)
Date: Tue, 8 Sep 2015 11:07:59 -0700
Subject: [Cocci] coccinelle problems with kernel code
Message-ID: <20150908180759.GA27133@Sligo.logfs.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Tried to use coccinelle on the linux kernel for the first time.  It
seems to get things mostly right, but not quite.  Here is the semantic
patch:

@@ expression E; @@
-down_read(&E->mmap_sem)
+mm_read_lock(E)
@@ expression E; @@
-down_read_trylock(&E->mmap_sem)
+mm_read_trylock(E)
@@ expression E; @@
-up_read(&E->mmap_sem)
+mm_read_unlock(E)
@@ expression E; @@
-down_write(&E->mmap_sem)
+mm_write_lock(E)
@@ expression E; @@
-down_write_trylock(&E->mmap_sem)
+mm_write_trylock(E)
@@ expression E; @@
-up_write(&E->mmap_sem)
+mm_write_unlock(E)

I run into problems whenever handling system calls.  Looks like the
SYSCALL_DEFINE5() macro and friends are causing problems.  Here is my
attempt to handle things.

#define SYSCALL_DEFINE1(func, t1, a1) \
	asmlinkage unsigned long func(t1 a1)
#define SYSCALL_DEFINE2(func, t1, a1, t2, a2) \
	asmlinkage unsigned long func(t1 a1, t2 a2)
#define SYSCALL_DEFINE3(func, t1, a1, t2, a2, t3, a3) \
	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3)
#define SYSCALL_DEFINE4(func, t1, a1, t2, a2, t3, a3, t4, a4) \
	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4)
#define SYSCALL_DEFINE5(func, t1, a1, t2, a2, t3, a3, t4, a4, t5, a5) \
	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4, t5 a5)
#define SYSCALL_DEFINE6(func, t1, a1, t2, a2, t3, a3, t4, a4, t5, a5, t6, a6) \
	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4, t5 a5, t6 a6)

Should that be included into standard.h?

J?rn

--
It is a clich? that most clich?s are true, but then, like most clich?s,
that clich? is untrue.
-- Stephen Fry
