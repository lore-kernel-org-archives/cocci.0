From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 17 Jan 2017 18:24:44 +0100
Subject: [Cocci] Moving setting of error codes into if branches with SmPL?
Message-ID: <76131053-62fe-73be-2afa-1b99b0c58551@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried the following small script out for the semantic patch language.


@show_assignments@
expression target;
identifier code =~ "^E[A-Z]+$";
statement is, es;
@@
*target = -(code);
 if (...)
    is
 else
    es


elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt -timeout 23 -j 4 --chunksize 1 -sp-file ~/Projekte/Coccinelle/janitor/show_misplaced_error_code_assignments1.cocci -dir security/selinux 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/show_misplaced_error_code_assignments1-errors.txt


Some update candidates were displayed.

Is such a simple source code search pattern worth to be integrated into
the Coccinelle script collection?


I see further development challenges for the specification of a corresponding
source code transformation.
How hard can it become to move the found variable assignments before condition
checks to the place before the last goto statement within an if branch automatically?

Regards,
Markus
