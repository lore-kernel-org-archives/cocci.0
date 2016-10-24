From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Mon, 24 Oct 2016 17:54:42 +0530
Subject: [Cocci] [PATCH v3 0/3] Coccinelle: misc: Improve the script for
	more accurate results
Message-ID: <cover.1477293469.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Few changes to improve the results given by the irqf_oneshot.cocci:

- Change in the matching rules to eliminate false postives in the
  patch mode
- Change in the context mode to eliminate false postives in the
  context mode
- Support for the missing devm_request_threaded_irq in context, report
  and org mode

Changes since v2:
	- Add missing initialization of metavariables
Changes since v1:
	- Split patch in to the patchset

Vaishali Thakkar (3):
  Coccinelle: misc: Improve the matching of rules
  Coccinelle: misc: Improve the result given by context mode
  Coccinelle: misc: Add support for devm variant in all modes

 scripts/coccinelle/misc/irqf_oneshot.cocci | 45 ++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

-- 
2.1.4
