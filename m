From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  8 Oct 2017 21:18:41 +0200
Subject: [Cocci] [PATCH 2/2] scripts: coccinelle: api: detect identical chip
	data arrays
In-Reply-To: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
within a single structure.  It is currently specific to the file
drivers/power/supply/bq27xxx_battery.c.  Nevertheless, having the script in
the kernel will allow others to check their code if the data structures
change in the future.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/check_bq27xxx_data.cocci |  161 ++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/scripts/coccinelle/api/check_bq27xxx_data.cocci b/scripts/coccinelle/api/check_bq27xxx_data.cocci
new file mode 100644
index 0000000..9212b85
--- /dev/null
+++ b/scripts/coccinelle/api/check_bq27xxx_data.cocci
@@ -0,0 +1,161 @@
+/// Detect BQ27XXX_DATA structures with identical registers, dm registers or
+/// properties.
+//# Doesn't unfold macros used in register or property fields.
+//# Requires OCaml scripting
+///
+// Confidence: High
+// Copyright: (C) 2017 Julia Lawall, Inria/LIP6, GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Requires: 1.0.7
+// Keywords: BQ27XXX_DATA
+
+virtual report
+
+ at initialize:ocaml@
+@@
+
+let print_report p msg =
+  let p = List.hd p in
+  Printf.printf "%s:%d:%d-%d: %s" p.file p.line p.col p.col_end msg
+
+ at str depends on report@
+type t;
+identifier i,i1,i2;
+expression e1,e2;
+@@
+
+t i[] = {
+  ...,
+  [e1] = BQ27XXX_DATA(i1,...),
+  ...,
+  [e2] = BQ27XXX_DATA(i2,...),
+  ...,
+};
+
+ at script:ocaml tocheck@
+i1 << str.i1;
+i2 << str.i2;
+i1regs; i2regs;
+i1dmregs; i2dmregs;
+i1props; i2props;
+@@
+
+if not(i1 = i2)
+then
+  begin
+    i1regs := make_ident (i1 ^ "_regs");
+    i2regs := make_ident (i2 ^ "_regs");
+    i1dmregs := make_ident (i1 ^ "_dm_regs");
+    i2dmregs := make_ident (i2 ^ "_dm_regs");
+    i1props := make_ident (i1 ^ "_props");
+    i2props := make_ident (i2 ^ "_props")
+  end
+
+(* ---------------------------------------------------------------- *)
+
+ at getregs1@
+typedef u8;
+identifier tocheck.i1regs;
+initializer list i1regs_vals;
+position p1;
+@@
+
+u8 i1regs at p1[...] = { i1regs_vals, };
+
+ at getregs2@
+identifier tocheck.i2regs;
+initializer list i2regs_vals;
+position p2;
+@@
+
+u8 i2regs at p2[...] = { i2regs_vals, };
+
+ at script:ocaml@
+(_,i1regs_vals) << getregs1.i1regs_vals;
+(_,i2regs_vals) << getregs2.i2regs_vals;
+i1regs << tocheck.i1regs;
+i2regs << tocheck.i2regs;
+p1 << getregs1.p1;
+p2 << getregs2.p2;
+@@
+
+if i1regs < i2regs &&
+   List.sort compare i1regs_vals = List.sort compare i2regs_vals
+then
+  let msg =
+    Printf.sprintf
+      "WARNING %s and %s (line %d) are identical\n"
+      i1regs i2regs (List.hd p2).line in
+  print_report p1 msg
+
+(* ---------------------------------------------------------------- *)
+
+ at getdmregs1@
+identifier tocheck.i1dmregs;
+initializer list i1dmregs_vals;
+position p1;
+@@
+
+struct bq27xxx_dm_reg i1dmregs at p1[] = { i1dmregs_vals, };
+
+ at getdmregs2@
+identifier tocheck.i2dmregs;
+initializer list i2dmregs_vals;
+position p2;
+@@
+
+struct bq27xxx_dm_reg i2dmregs at p2[] = { i2dmregs_vals, };
+
+ at script:ocaml@
+(_,i1dmregs_vals) << getdmregs1.i1dmregs_vals;
+(_,i2dmregs_vals) << getdmregs2.i2dmregs_vals;
+i1dmregs << tocheck.i1dmregs;
+i2dmregs << tocheck.i2dmregs;
+p1 << getdmregs1.p1;
+p2 << getdmregs2.p2;
+@@
+
+if i1dmregs < i2dmregs &&
+   List.sort compare i1dmregs_vals = List.sort compare i2dmregs_vals
+then
+  let msg =
+    Printf.sprintf
+      "WARNING %s and %s (line %d) are identical\n"
+      i1dmregs i2dmregs (List.hd p2).line in
+  print_report p1 msg
+
+(* ---------------------------------------------------------------- *)
+
+ at getprops1@
+identifier tocheck.i1props;
+initializer list[n1] i1props_vals;
+position p1;
+@@
+
+enum power_supply_property i1props at p1[] = { i1props_vals, };
+
+ at getprops2@
+identifier tocheck.i2props;
+initializer list[n2] i2props_vals;
+position p2;
+@@
+
+enum power_supply_property i2props at p2[] = { i2props_vals, };
+
+@script:ocaml@
+(_,i1props_vals) << getprops1.i1props_vals;
+(_,i2props_vals) << getprops2.i2props_vals;
+i1props << tocheck.i1props;
+i2props << tocheck.i2props;
+p1 << getprops1.p1;
+p2 << getprops2.p2;
+@@
+
+if i1props < i2props &&
+   List.sort compare i1props_vals = List.sort compare i2props_vals
+then
+  let msg =
+    Printf.sprintf
+      "WARNING %s and %s (line %d) are identical\n"
+      i1props i2props (List.hd p2).line in
+  print_report p1 msg
