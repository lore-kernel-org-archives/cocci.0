From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Jul 2015 09:09:21 +0200
Subject: [Cocci] Checking signal handler implementations with SmPL
Message-ID: <55A60721.5050209@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am looking for a specific programming mistake with the help
of the semantic patch language once more.


1. A SmPL approach like the following seems to work to some degree.

@find_unsafe@
identifier receiver =~ "^(?x)
(?:
   (?:alarm|parent|sig(?:chld|hup|term))_handler
|
   handle_sigterm
|
   (?:CancelJ|cancel_j)ob
)$";
@@
 void receiver(...)
 {
  ...
(
- exit(...);
|
- fprintf(...);
)
  ...
 }

elfring at Sonne:~/Projekte/CUPS> spatch.opt -sp-file async-unsafe1.cocci -dir lokal > async-unsafe1.diff && cat async-unsafe1.diff
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
?
Skipping:lokal/vcnet/regex/regerror.c
diff -u -p a/backend/ipp.c b/backend/ipp.c
--- a/backend/ipp.c
+++ b/backend/ipp.c
@@ -3271,8 +3271,6 @@ sigterm_handler(int sig)          /* I - Signal
 
   if (tmpfilename[0])
     unlink(tmpfilename);
-
-  exit(1);



2. I have tried another SmPL script variant out.

@show_unsafe@
identifier receiver =~ "^(?x)
(?:
   (?:alarm|parent|sig(?:chld|hup|term))_handler
|
   handle_sigterm
|
   (?:CancelJ|cancel_j)ob
)$";
@@
 void receiver(...)
 {
  ...
(
* exit
|
* fprintf
)
  (...);
  ...
 }

elfring at Sonne:~/Projekte/CUPS> spatch.opt -sp-file async-unsafe2.cocci -dir lokal > async-unsafe2.diff && cat async-unsafe2.diff
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
?
diff -u -p lokal/backend/dnssd.c /tmp/nothing/backend/dnssd.c
--- lokal/backend/dnssd.c
+++ /tmp/nothing/backend/dnssd.c
@@ -1289,7 +1289,6 @@ sigterm_handler(int sig)          /* I - Signal
   (void)sig;
 
   if (job_canceled)
-    exit(CUPS_BACKEND_OK);
   else
     job_canceled = 1;
 }
diff -u -p lokal/backend/usb-darwin.c /tmp/nothing/backend/usb-darwin.c
--- lokal/backend/usb-darwin.c
+++ /tmp/nothing/backend/usb-darwin.c
@@ -2262,9 +2262,7 @@ sigterm_handler(int sig)          /* I - Signal
     while (waitpid(child_pid, &status, 0) < 0 && errno == EINTR);
 
     if (WIFEXITED(status))
-      exit(WEXITSTATUS(status));
     else if (status == SIGTERM || status == SIGKILL)
-      exit(0);
     else
     {
       fprintf(stderr, "DEBUG: Child crashed on signal %d\n", status);
diff -u -p lokal/backend/ipp.c /tmp/nothing/backend/ipp.c
--- lokal/backend/ipp.c
+++ /tmp/nothing/backend/ipp.c
@@ -3272,7 +3272,6 @@ sigterm_handler(int sig)          /* I - Signal
   if (tmpfilename[0])
     unlink(tmpfilename);
 
-  exit(1);
 }


   Why did the first approach find less?


   Should the call of the function "fprintf" in the source file "usb-darwin.c"
   also be marked for further considerations here?
   Are there any more update candidates to consider?



3. If I add the parameter "-jobs 4" to the shown commands for a parallel
   source code analysis, I wonder about a message like the following.

[Pid 5399]: Error creating async-unsafe2 : File exists; proceeding without stdout/stderr redirection

   Should it be avoided usually?

Regards,
Markus
