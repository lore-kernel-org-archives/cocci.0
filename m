From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 06 Mar 2014 09:39:59 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402262208050.2221@localhost6.localdomain6>
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
 <530E560C.40706@users.sourceforge.net>
 <alpine.DEB.2.02.1402262208050.2221@localhost6.localdomain6>
Message-ID: <5318345F.6060305@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> - Does the message 'EXN:Invalid_argument("equal: abstractvalue")'
>> indicate that the desired source code analysis is influenced in unwanted
>> ways?
> 
> No, the semantic patch should be enough to reproduce the problem.  If I 
> need more information, I will ask.

I have looked into my log files once more so that I can give you another
feedback for a "regexp problem".


> The problem has no impact on the quality of the answers actually obtained.

Now I make a different observation for the processing of SmPL constraints with a
long function name list in the regular expression.

elfring at Sonne:~/Projekte/Coccinelle/janitor> OCAMLRUNPARAM=b spatch.opt
--sp-file delete_unnecessary_checks3.cocci
/usr/src/linux-stable/fs/proc/proc_sysctl.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/fs/proc/proc_sysctl.c
diff =
--- /usr/src/linux-stable/fs/proc/proc_sysctl.c
+++ /tmp/cocci-output-5200-eacf04-proc_sysctl.c
@@ -470,8 +470,7 @@ static struct dentry *proc_sys_lookup(st
        d_add(dentry, inode);

 out:
-       if (h)
-               sysctl_head_finish(h);
+       sysctl_head_finish(h);
        sysctl_head_finish(head);
        return err;
 }
elfring at Sonne:~/Projekte/Coccinelle/janitor> OCAMLRUNPARAM=b spatch.opt
--sp-file list_functions_with_unnecessary_checks1.cocci
/usr/src/linux-stable/fs/proc/proc_sysctl.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/fs/proc/proc_sysctl.c
Fatal error: exception Invalid_argument("equal: abstract value")
Called from file "list.ml", line 86, characters 24-34
Called from file "list.ml", line 86, characters 24-34
Called from file "list.ml", line 86, characters 24-34
Called from file "list.ml", line 57, characters 20-23


Regards,
Markus
