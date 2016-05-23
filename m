From: ydroneaud@opteya.com (Yann Droneaud)
Date: Mon, 23 May 2016 17:07:18 +0200
Subject: [Cocci] [PATCH v2 0/3] coccinelle: catchup on memory allocation
	functions
Message-ID: <cover.1464013817.git.ydroneaud@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Please find updated patches that remove coccicheck's
blindness regarding the following functions:
- kzfree()
- krealloc()
- __krealloc()
- devm_kmalloc()
- devm_kvasprintf()
- devm_kasprintf()
- devm_kmalloc_array()
- devm_kcalloc()
- devm_kstrdup()
- devm_kmemdup()
- devm_get_free_pages()
- free_pages()
- free_page()

Changes since v1 [1]:
- add kzfree() to ifnullfree.cocci
- added acked-by

 (note: v1 was a single patch update to v0)

Changes since v0 [2]:
- don't use regular expression in kfree.cocci

[1] http://lkml.kernel.org/r/1456150168-24028-1-git-send-email-ydroneaud at opteya.com
[2] http://lkml.kernel.org/r/cover.1455638829.git.ydroneaud at opteya.com

Regards.

Yann Droneaud (3):
  coccinelle: also catch kzfree() issues
  coccinelle: recognize more devm_* memory allocation functions
  coccinelle: catch krealloc() on devm_*() allocated memory

 scripts/coccinelle/free/devm_free.cocci  | 26 ++++++++++++++++++++++++++
 scripts/coccinelle/free/ifnullfree.cocci |  4 +++-
 scripts/coccinelle/free/kfree.cocci      | 18 +++++++++++++++---
 scripts/coccinelle/free/kfreeaddr.cocci  |  6 +++++-
 4 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.7.4
