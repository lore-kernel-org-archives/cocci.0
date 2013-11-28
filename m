From: nm@ti.com (Nishanth Menon)
Date: Wed, 27 Nov 2013 19:48:09 -0600
Subject: [Cocci] v3.13-rc1: parse error with orplus.cocci ?
Message-ID: <5296A0D9.3030003@ti.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

$ spatch --version
spatch version 1.0.0-rc10 with Python support and with PCRE support

$ make coccicheck MODE=report J=4 M=kernel/
COCCI=./scripts/coccinelle/misc/orplus.cocci

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

532 533
Fatal error: exception Failure("minus: parse error:
 = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
charpos = 532
    around = '@', whole content = e | c at i
")
532 533
Fatal error: exception Failure("minus: parse error:
 = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
charpos = 532
    around = '@', whole content = e | c at i
")
532 533
532 533
Fatal error: exception Failure("minus: parse error:
 = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
charpos = 532
    around = '@', whole content = e | c at i
")
Fatal error: exception Failure("minus: parse error:
 = File "./scripts/coccinelle/misc/orplus.cocci", line 23, column 5,
charpos = 532
    around = '@', whole content = e | c at i
")

-- 
Regards,
Nishanth Menon
