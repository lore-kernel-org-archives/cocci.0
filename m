From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 17 Nov 2014 18:11:56 +0100
Subject: [Cocci] [PATCH 1/1] perf tools: Deletion of unnecessary checks
 before two function calls
In-Reply-To: <5317A59D.4@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Message-ID: <546A2C5C.8080800@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Nov 2014 18:05:57 +0100

The functions free_event_desc() and strfilter__delete() test whether their
argument is NULL and then return immediately. Thus the test around the call
is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 tools/perf/builtin-probe.c | 6 ++----
 tools/perf/util/header.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c63fa29..1b72bf2 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -254,8 +254,7 @@ static int opt_set_filter(const struct option *opt __maybe_unused,
 
 	if (str) {
 		pr_debug2("Set filter: %s\n", str);
-		if (params.filter)
-			strfilter__delete(params.filter);
+		strfilter__delete(params.filter);
 		params.filter = strfilter__new(str, &err);
 		if (!params.filter) {
 			pr_err("Filter parse error at %td.\n", err - str + 1);
@@ -283,8 +282,7 @@ static void cleanup_params(void)
 		strlist__delete(params.dellist);
 	line_range__clear(&params.line_range);
 	free(params.target);
-	if (params.filter)
-		strfilter__delete(params.filter);
+	strfilter__delete(params.filter);
 	memset(&params, 0, sizeof(params));
 }
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 158c787..a62fbc6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1367,8 +1367,7 @@ out:
 	free(buf);
 	return events;
 error:
-	if (events)
-		free_event_desc(events);
+	free_event_desc(events);
 	events = NULL;
 	goto out;
 }
-- 
2.1.3
