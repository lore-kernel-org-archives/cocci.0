From: ydroneaud@opteya.com (Yann Droneaud)
Date: Tue, 16 Feb 2016 18:01:31 +0100
Subject: [Cocci] [PATCH 0/3] coccinelle: catchup on memory allocation
	functions
Message-ID: <cover.1455638829.git.ydroneaud@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Please find few patches that remove coccicheck's blindness
regarding the following functions:
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

I've ran coccicheck on drivers/staging and found no new issue,
which is great, but that questions those patches' usefulness,
YMMV.

Regards.

Yann Droneaud (3):
  coccinelle: also catch kzfree() issues
  coccinelle: recognize more devm_* memory allocation functions
  coccinelle: catch krealloc() on devm_*() allocated memory

 scripts/coccinelle/free/devm_free.cocci | 26 ++++++++++++++++++++++++++
 scripts/coccinelle/free/kfree.cocci     |  3 +++
 scripts/coccinelle/free/kfreeaddr.cocci |  6 +++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.5.0
