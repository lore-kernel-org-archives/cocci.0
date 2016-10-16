From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Sun, 16 Oct 2016 22:36:54 +0530
Subject: [Cocci] [PATCH v2 0/3] Coccinelle: misc: Improve the script for
	more accurate results
Message-ID: <cover.1476635073.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Few changes to improve the results given by the irqf_oneshot.cocci:

- Change in the matching rules to eliminate false postives in the
  patch mode
- Change in the context mode to eliminate false postives in the
  context mode
- Support for the missing devm_request_threaded_irq in context, report
  and org mode


Vaishali Thakkar (3):
  Coccinelle: misc: Improve the matching of rules
  Coccinelle: misc: Improve the result given by context mode
  Coccinelle: misc: Add support for devm variant in all modes

 scripts/coccinelle/misc/irqf_oneshot.cocci | 42 ++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.1.4
