From: joe@perches.com (Joe Perches)
Date: Tue, 01 Apr 2014 10:42:54 -0700
Subject: [Cocci] coccinelle: trivial linux code style reformatting
Message-ID: <1396374174.21529.93.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello.

I tried this little cocci script to remove unnecessary
uses of return in void functions.

I tried with 2 different versions of spatch and get
different output content, neither of which is the
preferred kernel style.

The output is apparently correct and compilable.
It is just not kernel style.  I'm not sure there
is a defect really, just wanted to bring it up.

Maybe the first transform could be better written.

$ cat void_return.cocci
@@
identifier func;
expression S;
@@
void func(...) {
...
	if (...)
-		return S;
+		{ S; return; }
...
}

@@
identifier func;
expression S;
@@
void func(...) {
...
	if (...) {
...
-		return S;
+		S;
	}
...
}

@@
identifier func;
expression S;
@@
void func(...) {
...
-	return S;
+	S;
}
$

$ ~/coccinelle/spatch --version
spatch version 1.0.0-rc20 without Python support and with PCRE support

$ ~/coccinelle/spatch -sp-file void_return.cocci drivers/gpu/drm/i915/i915_irq.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: drivers/gpu/drm/i915/i915_irq.c
diff = 
--- drivers/gpu/drm/i915/i915_irq.c
+++ /tmp/cocci-output-13176-0a96c4-i915_irq.c
@@ -2818,7 +2818,10 @@ static void i915_hangcheck_elapsed(unsig
 	}
 
 	if (rings_hung)
-		return i915_handle_error(dev, true, "Ring hung");
+	{
+		i915_handle_error(dev, true, "Ring hung");
+		return;
+	}
 
 	if (busy_count)
 		/* Reset timer case chip hangs without another request


and with an older spatch version

$ spatch --version
spatch version 1.0.0-rc14 without Python support and with PCRE support

$ spatch -sp-file void_return.cocci drivers/gpu/drm/i915/i915_irq.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: drivers/gpu/drm/i915/i915_irq.c
diff = 
--- drivers/gpu/drm/i915/i915_irq.c
+++ /tmp/cocci-output-13258-bc64a5-i915_irq.c
@@ -2817,8 +2817,11 @@ static void i915_hangcheck_elapsed(unsig
 		}
 	}
 
-	if (rings_hung)
-		return i915_handle_error(dev, true, "Ring hung");
+	if (rings_hung) {
+		
+			i915_handle_error(dev, true, "Ring hung");
+			return;		
+		}
 
 	if (busy_count)
 		/* Reset timer case chip hangs without another request
