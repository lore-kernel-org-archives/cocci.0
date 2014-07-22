From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 22 Jul 2014 10:19:09 +0200
Subject: [Cocci] [PATCH] kfree followed by a TRACE_RET before ref should be
	ok
Message-ID: <20140722081909.GA7723@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


kfree.cocci currently triggers on constructs like

drivers/staging/rts5208/spi.c:
596    if (retval < 0) {
597            kfree(buf);
598            rtsx_clear_spi_error(chip);
599            spi_set_err_code(chip, SPI_HW_ERR);
600            TRACE_RET(chip, STATUS_FAIL);
601    }
602
603    rtsx_stor_access_xfer_buf(buf, pagelen, srb, &index, &offset,
                            TO_XFER_BUF);

with:

./drivers/staging/rts5208/spi.c:603:28-31: ERROR: reference preceded 
by free on line 597

but this should be fine - so TRACE_RET is added to the list of calls 
"protecting" access to freed objects see drivers/staging/rts5208/trace.h


Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 scripts/coccinelle/free/kfree.cocci |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/coccinelle/free/kfree.cocci b/scripts/coccinelle/free/kfree.cocci
index 577b780..04d3f4f 100644
--- a/scripts/coccinelle/free/kfree.cocci
+++ b/scripts/coccinelle/free/kfree.cocci
@@ -101,6 +101,8 @@ kfree at p1(E,...)
 |
  return_ACPI_STATUS(...)
 |
+ TRACE_RET(...)
+|
  E at p2 // bad use
 )
 
-- 
1.7.10.4
