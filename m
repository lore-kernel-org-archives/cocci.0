From: elena.reshetova@intel.com (Elena Reshetova)
Date: Wed, 16 Aug 2017 14:52:21 +0300
Subject: [Cocci] [PATCH v3] provide rule for finding refcounters
Message-ID: <1502884342-10702-1-git-send-email-elena.reshetova@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

changes in v3:
Removed unnessesary rule 4 conditions pointed by Julia.

changes in v2:
Following the suggestion from Julia the first rule is split into
2. The output does not differ that much between these two versions,
but rule became more precise.

Elena Reshetova (1):
  Coccinelle: add atomic_as_refcounter script

 scripts/coccinelle/api/atomic_as_refcounter.cocci | 133 ++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci

-- 
2.7.4
