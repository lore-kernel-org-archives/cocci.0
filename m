From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Tue, 20 Jan 2015 01:02:59 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to use byte order API Functions
Message-ID: <20150119193259.GA3717@vaishali-Ideapad-Z570>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This makes an effort to find cases where a byte order conversion and memcpy
communicate via a temporary variable and replaces it with a suitable byte
order API function which does a copy of a fixed size based on the type.
Also shows an error if memcpy uses another size as, the API function can
give a wrong result or overwrite other data in this case.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/misc/byte_order.cocci | 748 +++++++++++++++++++++++++++++++
 1 file changed, 748 insertions(+)
 create mode 100644 scripts/coccinelle/misc/byte_order.cocci

diff --git a/scripts/coccinelle/misc/byte_order.cocci b/scripts/coccinelle/misc/byte_order.cocci
new file mode 100644
index 0000000..1de3587
--- /dev/null
+++ b/scripts/coccinelle/misc/byte_order.cocci
@@ -0,0 +1,748 @@
+/// Use byte order API functions
+//# This makes an effort to find cases where a byte order conversion and memcpy
+//# communicate via a temporary variable and replaces it with a suitable byte
+//# order API function which does a copy of a fixed size based on the type.
+//# Also shows an error if memcpy uses another size as, the API function can
+//# give a wrong result or overwrite other data in this case.
+///
+// Confidence: Moderate
+// Copyright: (C) 2015 Vaishali Thakkar. GPLv2.
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+/*Byte order semantic patch for little endian 16 byte case*/
+
+ at vcheck@
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position ok;
+@@
+
+tmp = cpu_to_le16(y);
+
+  <+... when != tmp
+ memcpy@ok(ptr, (T)&tmp, ...);
+  ...+>
+? tmp = e
+
+ at sizel16@
+typedef u16, __le16, uint16_t;
+{u16,__le16,uint16_t} e16;
+position p,p16,vcheck.ok;
+expression len,e;
+@@
+
+len at p = \(2\|sizeof(u16)\|sizeof(__le16)\|sizeof(uint16_t)\|sizeof(e16)\)
+... when != len = e
+memcpy at ok@p16(...,len)
+
+ at othersizel16 exists@
+position p != sizel16.p,pbad,vcheck.ok;
+expression len,e,e1;
+@@
+
+len at p = e1
+... when != len = e
+memcpy at ok@pbad(...,len)
+
+ at v depends on patch && !context && !org && !report@
+{u16,__le16,uint16_t} e16;
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position sizel16.p16,p1 != othersizel16.pbad,vcheck.ok;
+@@
+
+- tmp = cpu_to_le16(y);
+
+  <+... when != tmp
+(
+- memcpy at ok(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__le16)\|sizeof(uint16_t)\|sizeof(e16)\));
++ put_unaligned_le16(y,ptr);
+|
+- memcpy at ok@p16@p1(ptr, (T)&tmp, ...);
++ put_unaligned_le16(y,ptr);
+)
+  ...+>
+? tmp = e
+
+ at depends_on_v depends on patch && !context && !org && !report@
+ type T; identifier v.tmp; @@
+
+- T tmp;
+...when != tmp
+
+/*Byte order semantic patch for little endian 32 byte case*/
+
+ at bcheck@
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position ok;
+@@
+
+tmp = cpu_to_le32(y);
+
+  <+... when != tmp
+ memcpy@ok(ptr, (T)&tmp, ...);
+  ...+>
+? tmp = e
+
+ at sizel32@
+typedef u32, __le32, uint32_t;
+{u32,__le32,uint32_t} e32;
+position p,p32,bcheck.ok;
+expression len,e;
+@@
+
+len at p = \(4\|sizeof(u32)\|sizeof(__le32)\|sizeof(uint32_t)\|sizeof(e32)\)
+... when != len = e
+memcpy at ok@p32(...,len)
+
+ at othersizel32 exists@
+position p != sizel32.p,pbad,bcheck.ok;
+expression len,e,e1;
+@@
+
+len at p = e1
+... when != len = e
+memcpy at ok@pbad(...,len)
+
+ at b depends on patch && !context && !org && !report@
+identifier tmp; 
+expression ptr;
+expression y,e;
+{u32,__le32,uint32_t} e32; 
+type T;
+position sizel32.p32,p1 != othersizel32.pbad,bcheck.ok;
+@@
+
+- tmp = cpu_to_le32(y);
+
+  <+... when != tmp
+(
+- memcpy at ok(ptr, (T)&tmp, \(4\|sizeof(u32)\|sizeof(__le32)\|sizeof(uint32_t)\|sizeof(e32)\));
++ put_unaligned_le32(y,ptr);
+|
+- memcpy at ok@p32@p1(ptr, (T)&tmp, ...);
++ put_unaligned_le32(y,ptr);
+)
+  ...+>
+? tmp = e
+
+ at depends_on_b depends on patch && !context && !org && !report@
+ type T; identifier b.tmp; @@
+
+- T tmp;
+...when != tmp
+
+/*Byte order semantic patch for little endian 64 byte case*/
+
+ at wcheck@
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position ok;
+@@
+
+tmp = cpu_to_le64(y);
+
+  <+... when != tmp
+ memcpy@ok(ptr, (T)&tmp, ...);
+  ...+>
+? tmp = e
+
+ at sizel64@
+typedef u64, __le64, uint64_t;
+{u64,__le64,uint64_t} e64;
+position p,p64,wcheck.ok;
+expression len,e;
+@@
+
+len at p = \(8\|sizeof(u64)\|sizeof(__le64)\|sizeof(uint64_t)\|sizeof(e64)\)
+... when != len = e
+memcpy at ok@p64(...,len)
+
+ at othersizel64 exists@
+position p != sizel64.p,pbad,wcheck.ok;
+expression len,e,e1;
+@@
+
+len at p = e1
+... when != len = e
+memcpy at ok@pbad(...,len)
+
+ at w depends on patch && !context && !org && !report@
+identifier tmp; 
+expression ptr;
+expression y,e;
+{u64,__le64,uint64_t} e64; 
+type T;
+position sizel64.p64,p1 != othersizel64.pbad,wcheck.ok;
+@@
+
+- tmp = cpu_to_le64(y);
+
+  <+... when != tmp
+(
+- memcpy at ok(ptr, (T)&tmp, \(8\|sizeof(u64)\|sizeof(__le64)\|sizeof(uint64_t)\|sizeof(e64)\));
++ put_unaligned_le64(y,ptr);
+|
+- memcpy at ok@p64@p1(ptr, (T)&tmp, ...);
++ put_unaligned_le64(y,ptr);
+)
+  ...+>
+? tmp = e
+
+ at depends_on_w depends on patch && !context && !org && !report@
+ type T; identifier w.tmp; @@
+
+- T tmp;
+...when != tmp
+
+
+/*Byte order semantic patch for big endian 16 byte case*/
+
+ at zcheck@
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position ok;
+@@
+
+tmp = cpu_to_be16(y);
+
+  <+... when != tmp
+ memcpy@ok(ptr, (T)&tmp, ...);
+  ...+>
+? tmp = e
+
+ at sizeb16@
+typedef __be16;
+{u16,__be16,uint16_t} e16;
+position p,p16,zcheck.ok;
+expression len,e;
+@@
+
+len at p = \(2\|sizeof(u16)\|sizeof(__be16)\|sizeof(uint16_t)\|sizeof(e16)\)
+... when != len = e
+memcpy at ok@p16(...,len)
+
+ at othersizeb16 exists@
+position p != sizeb16.p,pbad,zcheck.ok;
+expression len,e,e1;
+@@
+
+len at p = e1
+... when != len = e
+memcpy at ok@pbad(...,len)
+
+ at z depends on patch && !context && !org && !report@
+identifier tmp; 
+expression ptr;
+expression y,e;
+{u16,__be16,uint16_t} e16; 
+type T;
+position sizeb16.p16,p1 != othersizeb16.pbad,zcheck.ok;
+@@
+
+- tmp = cpu_to_be16(y);
+
+  <+... when != tmp
+(
+- memcpy at ok(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__be16)\|sizeof(uint16_t)\|sizeof(e16)\));
++ put_unaligned_be16(y,ptr);
+|
+- memcpy at ok@p16@p1(ptr, (T)&tmp, ...);
++ put_unaligned_be16(y,ptr);
+)
+  ...+>
+? tmp = e
+
+
+ at depends_on_z depends on patch && !context && !org && !report@
+ type T; identifier z.tmp; @@
+
+- T tmp;
+...when != tmp
+
+/*Byte order semantic patch for big endian 32 byte case*/
+
+ at ncheck@
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position ok;
+@@
+
+tmp = cpu_to_be32(y);
+
+  <+... when != tmp
+ memcpy@ok(ptr, (T)&tmp, ...);
+  ...+>
+? tmp = e
+
+ at sizeb32@
+typedef __be32;
+{u32,__be32,uint32_t} e32;
+position p,p32,ncheck.ok;
+expression len,e;
+@@
+
+len at p = \(4\|sizeof(u32)\|sizeof(__be32)\|sizeof(uint32_t)\|sizeof(e32)\)
+... when != len = e
+memcpy at ok@p32(...,len)
+
+ at othersizeb32 exists@
+position p != sizeb32.p,pbad,ncheck.ok;
+expression len,e,e1;
+@@
+
+len at p = e1
+... when != len = e
+memcpy at ok@pbad(...,len)
+
+ at n depends on patch && !context && !org && !report@
+identifier tmp; 
+expression ptr;
+expression y,e;
+{u32,__be32,uint32_t} e32; 
+type T;
+position sizeb32.p32,p1 != othersizeb32.pbad,ncheck.ok;
+@@
+
+- tmp = cpu_to_be32(y);
+
+  <+... when != tmp
+(
+- memcpy at ok(ptr, (T)&tmp, \(4\|sizeof(u32)\|sizeof(__be32)\|sizeof(uint32_t)\|sizeof(e32)\));
++ put_unaligned_be32(y,ptr);
+|
+- memcpy at ok@p32@p1(ptr, (T)&tmp, ...);
++ put_unaligned_be32(y,ptr);
+)
+  ...+>
+? tmp = e
+
+ at depends_on_n depends on patch && !context && !org && !report@
+ type T; identifier n.tmp; @@
+
+- T tmp;
+...when != tmp
+
+/*Byte order semnatic patch for big endian 64 byte case*/
+
+ at xcheck@
+identifier tmp; 
+expression ptr;
+expression y,e;
+type T;
+position ok;
+@@
+
+tmp = cpu_to_be64(y);
+
+  <+... when != tmp
+ memcpy@ok(ptr, (T)&tmp, ...);
+  ...+>
+? tmp = e
+
+ at sizeb64@
+typedef __be64;
+{u64,__be64,uint64_t} e64;
+position p,p64,xcheck.ok;
+expression len,e;
+@@
+
+len at p = \(8\|sizeof(u64)\|sizeof(__be64)\|sizeof(uint64_t)\|sizeof(e64)\)
+... when != len = e
+memcpy at ok@p64(...,len)
+
+ at othersizeb64 exists@
+position p != sizeb64.p,pbad,xcheck.ok;
+expression len,e,e1;
+@@
+
+len at p = e1
+... when != len = e
+memcpy at ok@pbad(...,len)
+
+ at x depends on patch && !context && !org && !report@
+identifier tmp; 
+expression ptr;
+expression y,e;
+{u64,__be64,uint64_t} e64; 
+type T;
+position sizeb64.p64,p1 != othersizeb64.pbad,xcheck.ok;
+@@
+
+- tmp = cpu_to_be64(y);
+
+  <+... when != tmp
+(
+- memcpy at ok(ptr, (T)&tmp, \(8\|sizeof(u64)\|sizeof(__be64)\|sizeof(uint64_t)\|sizeof(e64)\));
++ put_unaligned_be64(y,ptr);
+|
+- memcpy at ok@p64@p1(ptr, (T)&tmp, ...);
++ put_unaligned_be64(y,ptr);
+)
+  ...+>
+? tmp = e
+
+ at depends_on_x depends on patch && !context && !org && !report@
+ type T; identifier x.tmp; @@
+
+- T tmp;
+...when != tmp
+
+
+
+
+
+
+// ----------------------------------------------------------------------------
+
+ at v_context depends on !patch && (context || org || report)@
+type T;
+identifier tmp;
+expression e, ptr, y;
+{u16 ,__le16 ,uint16_t } e16;
+position vcheck.ok, p1 != othersizel16.pbad, sizel16.p16;
+position j0,j1,p;
+@@
+
+*  tmp at j0 = cpu_to_le16(y);
+  <+... when != tmp
+(
+*  memcpy at ok@j1(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__le16)\|sizeof(uint16_t)\|sizeof(e16)\));
+|
+*  memcpy at ok@j1 at p1@p16(ptr, (T)&tmp, ...);
+|
+*  memcpy@ok@p(ptr, (T)&tmp, ...);
+)
+  ...+>
+? tmp = e
+
+ at b_context depends on !patch && (context || org || report)@
+type T;
+identifier tmp;
+expression e, ptr, y;
+{u32 ,__le32 ,uint32_t } e32;
+position p1 != othersizel32.pbad, sizel32.p32, bcheck.ok;
+position j0,j1,p;
+@@
+
+*  tmp at j0 = cpu_to_le32(y);
+  <+... when != tmp
+(
+*  memcpy at ok@j1(ptr, (T)&tmp, \(4\|sizeof(u32)\|sizeof(__le32)\|sizeof(uint32_t)\|sizeof(e32)\));
+|
+*  memcpy at ok@j1 at p1@p32(ptr, (T)&tmp, ...);
+|
+*  memcpy@ok@p(ptr, (T)&tmp, ...);
+)
+  ...+>
+? tmp = e
+
+ at w_context depends on !patch && (context || org || report)@
+type T;
+identifier tmp;
+expression e, ptr, y;
+{u64 ,__le64 ,uint64_t } e64;
+position p1 != othersizel64.pbad, sizel64.p64, wcheck.ok;
+position j0,j1,p;
+@@
+
+*  tmp at j0 = cpu_to_le64(y);
+  <+... when != tmp
+(
+*  memcpy at ok@j1(ptr, (T)&tmp, \(8\|sizeof(u64)\|sizeof(__le64)\|sizeof(uint64_t)\|sizeof(e64)\));
+|
+*  memcpy at ok@j1 at p1@p64(ptr, (T)&tmp, ...);
+|
+*  memcpy@ok@p(ptr, (T)&tmp, ...);
+)
+  ...+>
+? tmp = e
+
+ at z_context depends on !patch && (context || org || report)@
+type T;
+identifier tmp;
+expression e, ptr, y;
+{u16 ,__be16 ,uint16_t } e16;
+position p1 != othersizeb16.pbad, sizeb16.p16, zcheck.ok;
+position j0,j1,p;
+@@
+
+*  tmp at j0 = cpu_to_be16(y);
+  <+... when != tmp
+(
+*  memcpy at ok@j1(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__be16)\|sizeof(uint16_t)\|sizeof(e16)\));
+|
+*  memcpy at ok@j1 at p1@p16(ptr, (T)&tmp, ...);
+|
+*  memcpy@ok@p(ptr, (T)&tmp, ...);
+)
+  ...+>
+? tmp = e
+
+ at n_context depends on !patch && (context || org || report)@
+type T;
+identifier tmp;
+expression e, ptr, y;
+{u32 ,__be32 ,uint32_t } e32;
+position p1 != othersizeb32.pbad, sizeb32.p32, ncheck.ok;
+position j0,j1,p;
+@@
+
+*  tmp at j0 = cpu_to_be32(y);
+  <+... when != tmp
+(
+*  memcpy at ok@j1(ptr, (T)&tmp, \(4\|sizeof(u32)\|sizeof(__be32)\|sizeof(uint32_t)\|sizeof(e32)\));
+|
+*  memcpy at ok@j1 at p1@p32(ptr, (T)&tmp, ...);
+|
+*  memcpy@ok@p(ptr, (T)&tmp, ...);
+)
+  ...+>
+? tmp = e
+
+ at x_context depends on !patch && (context || org || report)@
+type T;
+identifier tmp;
+expression e, ptr, y;
+{u64 ,__be64 ,uint64_t } e64;
+position p1 != othersizeb64.pbad, sizeb64.p64, xcheck.ok;
+position j0,j1,p;
+@@
+
+*  tmp at j0 = cpu_to_be64(y);
+  <+... when != tmp
+(
+*  memcpy at ok@j1(ptr, (T)&tmp, \(8\|sizeof(u64)\|sizeof(__be64)\|sizeof(uint64_t)\|sizeof(e64)\));
+|
+*  memcpy at ok@j1 at p1@p64(ptr, (T)&tmp, ...);
+|
+*  memcpy@ok@p(ptr, (T)&tmp, ...);
+)
+  ...+>
+? tmp = e
+
+// ----------------------------------------------------------------------------
+
+ at script:python v_org depends on org@
+j0 << v_context.j0;
+j1 << v_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_le16."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+ at script:python v_org_another depends on org@
+j0 << v_context.j0;
+p  << v_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_le16 if copied size is 2."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(p[0], msg)
+
+ at script:python b_org depends on org@
+j0 << b_context.j0;
+j1 << b_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_le32."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+ at script:python b_org_another depends on org@
+j0 << b_context.j0;
+p  << b_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_le32 if copied size is 4."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(p[0], msg)
+
+ at script:python w_org depends on org@
+j0 << w_context.j0;
+j1 << w_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_le64."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+ at script:python w_org_another depends on org@
+j0 << w_context.j0;
+p  << w_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_le64 if copied size is 8."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(p[0], msg)
+
+ at script:python z_org depends on org@
+j0 << z_context.j0;
+j1 << z_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_be16."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+ at script:python z_org_another depends on org@
+j0 << z_context.j0;
+p  << z_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_be16 if copied size is 2."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(p[0], msg)
+
+ at script:python n_org depends on org@
+j0 << n_context.j0;
+j1 << n_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_be32."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+ at script:python n_org_another depends on org@
+j0 << n_context.j0;
+p  << n_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_be32 if copied size is 4."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(p[0], msg)
+
+ at script:python x_org depends on org@
+j0 << x_context.j0;
+j1 << x_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_be64."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+ at script:python x_org_another depends on org@
+j0 << x_context.j0;
+p  << x_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_be64 if copied size is 8."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(p[0], msg)
+
+// ----------------------------------------------------------------------------
+
+ at script:python v_report depends on report@
+j0 << v_context.j0;
+j1 << v_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_le16 on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python v_report_another depends on report@
+j0 << v_context.j0;
+p  << v_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_le16 if copied size is 2 on line %s." % (p[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python b_report depends on report@
+j0 << b_context.j0;
+j1 << b_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_le32 on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python b_report_another depends on report@
+j0 << b_context.j0;
+p  << b_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_le32 if copied size is 4 on line %s." % (p[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python w_report depends on report@
+j0 << w_context.j0;
+j1 << w_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_le64 on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python w_report_another depends on report@
+j0 << w_context.j0;
+p  << w_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_le64 if copied size is 8 on line %s." % (p[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python z_report depends on report@
+j0 << z_context.j0;
+j1 << z_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_be16 on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python z_report_another depends on report@
+j0 << z_context.j0;
+p  << z_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_be16 if copied size is 2 on line %s." % (p[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python n_report depends on report@
+j0 << n_context.j0;
+j1 << n_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_be32 on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python n_report_another depends on report@
+j0 << n_context.j0;
+p  << n_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_be32 if copied size is 4 on line %s." % (p[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python x_report depends on report@
+j0 << x_context.j0;
+j1 << x_context.j1;
+@@
+
+msg = "WARNING: Use put_unaligned_be64 on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python x_report_another depends on report@
+j0 << x_context.j0;
+p  << x_context.p;
+@@
+
+msg = "WARNING: Use put_unaligned_be64 if copied size is 8 on line %s." % (p[0].line)
+coccilib.report.print_report(j0[0], msg)
-- 
1.9.1
