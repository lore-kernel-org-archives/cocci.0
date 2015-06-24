From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 24 Jun 2015 18:28:37 +0200
Subject: [Cocci] Extra message "case 1" in generated patches
Message-ID: <558ADAB5.8060503@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Julia,

It seems that a few additional debug messages were written
into update suggestions like the following from my source
code analysis approach.

diff -u -p a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1239,8 +1239,7 @@ filter_event(struct event_filter *filter
 	if (filter_type == NULL)
 		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
 
-	if (filter_type->filter)
-		free_arg(filter_type->filter);
+	free_arg(filter_type->filter);
 	filter_type->filter = arg;
 
 	return 0;
case 1
case 1


How do you think about to avoid such information usually?

Regards,
Markus
