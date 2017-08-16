From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Aug 2017 19:00:11 +0200
Subject: [Cocci] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
References: <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
Message-ID: <ae535db6-f568-9424-466d-596844c1ab9f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Elena,

Why do you insist to use the variables ?fname2? till ?fname6? in
this evolving SmPL script (instead of merging them into a single one
with a special constraint)?

How do you think about to omit the cover letter for the addition
of such a script (when the change log can be integrated into
the same message for your update suggestion)?

Regards,
Markus
