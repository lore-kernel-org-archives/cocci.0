From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 4 Jan 2018 21:53:09 +0100
Subject: [Cocci] [v3] runchecks: Generalize make C={1,
 2} to support multiple checkers
In-Reply-To: <1515092125.31439.597.camel@oracle.com>
References: <5f292b7effba0efcf4855bff83b7b9313ac45895.1515072782.git-series.knut.omang@oracle.com>
 <e585c25f-3488-2177-241b-a0a7815544f4@users.sourceforge.net>
 <1515092125.31439.597.camel@oracle.com>
Message-ID: <59753d8e-2fd1-be2a-646d-4553b1f6d715@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> As I commented to you, some of it is a bit more in the class of good enhancements 
> so whatever I haven't changed now that resonated with me,

I find that some information could be better integrated already now.


> I'll pick up later if the general idea is accepted.

I am curious on how the waiting queue for remaining improvement possibilities
will be managed for this evolving software tool.


> Sorry if this was confusing.

I would appreciate a corresponding issue ordering somehow.


> Thanks for all the careful comments and suggestions!

Now I would like to add another development concern.

I find source code places like the following suspicious in the script ?scripts/runchecks?
because the passed variable contents might need extra care.

?
+    def RegexFilter(self, line, verbose):
?
+            r = "^(.*:\d+:)\s(\w+:)\s(%s.*)$" % regex[0]
?
+    def Postprocess(self):
?
+                self.cmdvec.append("-Wno-%s" % self.sparse_name(e))
?

Regards,
Markus
