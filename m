From: elena.reshetova@intel.com (Elena Reshetova)
Date: Mon, 14 Aug 2017 08:59:45 +0300
Subject: [Cocci] [PATCH v2] coccinelle: provide rule for finding refcounters
Message-ID: <1502690386-5605-1-git-send-email-elena.reshetova@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

changes in v2:
Following the suggestion from Julia the first rule is split into
2. The output does not differ that much between these two versions,
but rule became more precise.


Elena Reshetova (1):
  Coccinelle: add atomic_as_refcounter script

 scripts/coccinelle/api/atomic_as_refcounter.cocci | 148 ++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci

-- 
2.7.4
