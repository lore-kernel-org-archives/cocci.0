From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 13 Jan 2018 15:02:10 -0200
Subject: [Cocci] [PATCH] Coccinelle: kzalloc-simple: Rename
 kzalloc-simple to zalloc-simple
In-Reply-To: <1515859050-31764-1-git-send-email-himanshujha199640@gmail.com>
References: <1515859050-31764-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <CAOMZO5C0JEnvCqNejPbVg3DUGxoH9_Gu5Znc0G2BDBWqmgppLw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jan 13, 2018 at 1:57 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Rename kzalloc-simple to zalloc-simple since now the rule is not
> specific to kzalloc function only, but also to many other zero memory
> allocating functions specified in the rule.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  scripts/coccinelle/api/alloc/kzalloc-simple.cocci | 448 ----------------------
>  scripts/coccinelle/api/alloc/zalloc.cocci         | 448 ++++++++++++++++++++++

You could use 'git mv' and 'git format -1 -M', so that git detects the rename.

Then the patch would look like this:

 scripts/coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc.cocci} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename scripts/coccinelle/api/alloc/{kzalloc-simple.cocci =>
zalloc.cocci} (100%)

diff --git a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
b/scripts/coccinelle/api/alloc/zalloc.cocci
similarity index 100%
rename from scripts/coccinelle/api/alloc/kzalloc-simple.cocci
rename to scripts/coccinelle/api/alloc/zalloc.cocci
