From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 20 Dec 2015 13:59:54 +0100 (CET)
Subject: [Cocci] [PATCH] staging/rdma/hfi1: Fix a possible null pointer
 dereference
In-Reply-To: <20151218142025.GA32208@osadl.at>
References: <20151210161338.3341.95259.stgit@phlsvslse11.ph.intel.com>
 <20151214132849.GA22053@osadl.at>
 <alpine.DEB.2.02.1512180727310.2052@localhost6.localdomain6>
 <20151218142025.GA32208@osadl.at>
Message-ID: <alpine.DEB.2.02.1512201358040.2067@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Here is my proposition for finding missing NULL tests.  I tried to limit 
it to generic kmalloc like functions.  There are of course many other NULL 
returning functions, but maybe they could be in an other rule,

julia

---

/// Look for kmalloc etc that are not followed by a NULL check.
//# May give a false positive when the dereference is an argument of sizeof, or
//# when the value is passed to another function that returns an error code.
///
// Confidence: Moderate
// Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
// URL: http://coccinelle.lip6.fr/
// Options: --no-includes --include-headers

virtual context
virtual org
virtual report


@ok forall@
expression x;
position p;
statement S1,S2;
@@

(
x =@p \(vmalloc\|kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|krealloc\|
        kmemdup\|kstrdup\|devm_kzalloc\|devm_kmalloc\|devm_kcalloc\|
	devm_kasprintf\|devm_kstrdup\|kmalloc_array\)
	(...,<+... __GFP_NOFAIL ...+>,...);
|
x =@p \(vmalloc\|kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|krealloc\|
        kmemdup\|kstrdup\|devm_kzalloc\|devm_kmalloc\|devm_kcalloc\|
	devm_kasprintf\|devm_kstrdup\|kmalloc_array\)(...)
... when != x
(
 if (x || ...) S1 else S2
|
 (x) == NULL
|
 (x) != NULL
|
 (x) == 0
|
 (x) != 0
)
)

// ----------------------------------------------------------------------------

@err depends on context || org || report exists@
identifier fld;
position p != ok.p;
expression x, y;
position j0, j1, j2;
@@

*  x at j0 =@p \(vmalloc at j1\|kmalloc at j1\|kzalloc at j1\|kcalloc at j1\|
              kmem_cache_alloc at j1\|krealloc at j1\|kmemdup at j1\|kstrdup at j1\|
              devm_kzalloc at j1\|devm_kmalloc at j1\|devm_kcalloc at j1\|
              devm_kasprintf at j1\|devm_kstrdup at j1\|kmalloc_array at j1\)(...);
  ... when != (x) == NULL
      when != (x) != NULL
      when != (x) == 0
      when != (x) != 0
      when != x = y
(
  x at j2->fld
|
  *x at j2
|
  x at j2[...]
)

// ----------------------------------------------------------------------------

@script:python err_org depends on org@
j0 << err.j0;
j1 << err.j1;
j2 << err.j2;
@@

msg = "NULL test needed."
coccilib.org.print_todo(j0[0], msg)
coccilib.org.print_link(j1[0], "")
coccilib.org.print_link(j2[0], "")

// ----------------------------------------------------------------------------

@script:python err_report depends on report@
j0 << err.j0;
j1 << err.j1;
j2 << err.j2;
@@

msg = "NULL test needed, around lines %s,%s." % (j1[0].line,j2[0].line)
coccilib.report.print_report(j0[0], msg)
