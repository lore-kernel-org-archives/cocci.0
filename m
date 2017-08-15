From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Aug 2017 12:55:37 +0200
Subject: [Cocci] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <1502690386-5605-2-git-send-email-elena.reshetova@intel.com>
References: <1502690386-5605-2-git-send-email-elena.reshetova@intel.com>
Message-ID: <f170ecf7-0c9a-c43f-23c0-0e89f928c50e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Elena,

Would you like to take another look at my development suggestion for your approach?
https://systeme.lip6.fr/pipermail/cocci/2017-August/004300.html

How do you think about to refactor another rule like the following?

@r3 exists@
expression E;
identifier I=~"^atomic(?:64|_long)?_add_return$";
position P;
@@
 E = I at P(-1, ...);


Can the specification of SmPL constraints be occasionally be more succinct
with the use of regular expressions?

Regards,
Markus
