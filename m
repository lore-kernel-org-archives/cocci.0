From: elena.reshetova@intel.com (Elena Reshetova)
Date: Tue, 18 Jul 2017 10:48:30 +0300
Subject: [Cocci] [PATCH] Coccinelle report script for refcounters
Message-ID: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The below script can be used to detect potential misusage
of atomic_t type and API for reference counting purposes.
Now when we have a dedicated refcount_t type and API with
security protection implemented, people should be using it
instead.

Currently it still reports many occurences since we are
nowhere near the end of our kernel-wide conversion execrise,
but hopefully after couple of cycles more, the amount of
output would be much more limited.

Each script result must be analysed manually before any
conversion, since refcount_t might not suit for certain
purposes (for example if an object is not always destroyed
upon refcounter reaching zero, if increments from zero are
allowed in the code etc.)

As we go further and get less results in output, we will
improve the pattern to detect conversion cases more precisely.

Elena Reshetova (1):
  Coccinelle: add atomic_as_refcounter script

 scripts/coccinelle/api/atomic_as_refcounter.cocci | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci

-- 
2.7.4
