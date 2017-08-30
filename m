From: elena.reshetova@intel.com (Elena Reshetova)
Date: Wed, 30 Aug 2017 09:15:57 +0300
Subject: [Cocci] [PATCH v4] provide rule for finding refcounters
Message-ID: <1504073758-16945-1-git-send-email-elena.reshetova@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

changes in v4:
Removed unnessesary "()" around expression in rule 4.

changes in v3:
Removed unnessesary rule 4 conditions pointed by Julia.

changes in v2:
Following the suggestion from Julia the first rule is split into
2. The output does not differ that much between these two versions,
but rule became more precise.


Elena Reshetova (1):
  Coccinelle: add atomic_as_refcounter script

 scripts/coccinelle/api/atomic_as_refcounter.cocci | 131 ++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci

-- 
2.7.4
