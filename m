From: strnape1@fel.cvut.cz (strnape1 at fel.cvut.cz)
Date: Wed, 08 May 2013 18:28:14 +0200
Subject: [Cocci] [PATCH] scripts: Coccinelle script for pci_free_consistent()
Message-ID: <20130508182814.Horde.hakqXtmsOi7FNBjwBV1zlw1@wimap.feld.cvut.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Created coccinelle script for reporting missing pci_free_consistent() calls.

Signed-off-by: Petr Strnad <strnape1@fel.cvut.cz>
---
/// Find missing pci_free_consistent for every pci_alloc_consistent.
///
// Confidence: Moderate
// Copyright: (C) 2013 Petr Strnad.  GPLv2.
// URL: http://coccinelle.lip6.fr/
// Keywords: pci_free_consistent, pci_alloc_consistent
// Options: --no-includes --include-headers

virtual report
virtual org

@search@
local idexpression id;
expression x,y,z,e;
position p1,p2;
type T;
@@

id = pci_alloc_consistent at p1(x,y,&z)
... when != e = id
if (id == NULL || ...) { ... return ...; }
... when != pci_free_consistent(x,y,id,z)
     when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
     when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
     when != e = (T)id
     when exists
(
return 0;
|
return 1;
|
return id;
|
return at p2 ...;
)

@script:python depends on report@
p1 << search.p1;
p2 << search.p2;
@@

msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on  
line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
coccilib.report.print_report(p2[0],msg)

@script:python depends on org@
p1 << search.p1;
p2 << search.p2;
@@

msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on  
line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
cocci.print_main(msg,p1)
cocci.print_secs("",p2)
