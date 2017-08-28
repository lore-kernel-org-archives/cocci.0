From: joe@perches.com (Joe Perches)
Date: Mon, 28 Aug 2017 09:49:19 -0700
Subject: [Cocci] cocci: remove unnecessary casts of void * while avoiding
 casts with __user or __force ?
Message-ID: <1503938959.2040.6.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A simple cocci script that removes unnecessary casts of
a void * will also remove casts with __force or __user

e.g.:

-???????xemaclite_aligned_write(address_ptr, (u32 __force *) addr, ETH_ALEN);
+???????xemaclite_aligned_write(address_ptr, addr, ETH_ALEN);

Is there a simple mechanism to avoid converting those?

$ cat void.cocci
@@
type T;
void *v;
expression e;
@@

-	e = (T *)v;
+	e = v;

@@
identifier f;
type T;
void *v;
@@

	f(...,
-	(T *)v,
+	v,
	...)

$
