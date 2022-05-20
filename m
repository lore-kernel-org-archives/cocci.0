Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145A2C433EF
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aeBft7G1L8E7YAQkkzmhGoJPq2JQDTZBTXMnaOqeiXc=;
  b=SLGSJ+et6ycTv9c+RdqXId+C0A/SKluAhUYsTIZ3e2ka0A6rqEM7OIYJ
   +YOIrf5dnV8VW2KbN879g50K6ABkZcCsEBwqN4XqFxZm7bwKEgtZAPzQf
   E3kApgQ2Xc7bE3eTcPrPeS2HkciZ+7aeJE2frHo2Aijw4Q+rZAci0Sgjz
   0=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37348821"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 15:29:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B84FE2680; Fri, 20 May 2022 15:29:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7A0CCE0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 15:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aeBft7G1L8E7YAQkkzmhGoJPq2JQDTZBTXMnaOqeiXc=;
  b=hTmAOwT2ykKg9QQ4/BcfonJNluYr3MM0HtdvU9N9NmF87CX6asjqNEE0
   +duq5CxbKqqI7oGi/0RFdTsYVsmvL3VfYNi22wgOffH4CyaH0OicyMoXD
   M/9g4o1u6404Y/86+td7Vbnn3VhVqiKiJQ4t8gOO3j3FOpgwqE4Vjtza4
   w=;
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="14665565"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:29:35 +0200
Date: Fri, 20 May 2022 15:29:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <220520.86tu9k1iwq.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205201525400.2929@hadrien>
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com> <220520.86tu9k1iwq.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1828384921-1653053375=:2929"
Subject: Re: [cocci] Matching VAR followed by foo(VAR) with no other use of
 VAR in the function
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 404
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205201525400.2929%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1828384921-1653053375=:2929
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 20 May 2022, Ævar Arnfjörð Bjarmason wrote:

>
> I came up with the below patch today to find code in git where we e.g.:
>
>     struct strbuf sb = STRBUF_INIT;
>     /* code here that doesn't use "sb" at all */
>     strbuf_release(&sb);
>
> I.e. "unused" code that the compiler wouldn't spot. The rule quoted
> below works, briefly:
>
>     - T I = INIT;
>       <+... when != \( I \| &I \)
>     - \( REL1 \| REL2 \)(&I, ...);
>       ...+>
>
> But I noticed that it didn't spot some other cases, so I tried this:
>
> 	diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
> 	index 52c23e15310..25c322fa1ff 100644
> 	--- a/contrib/coccinelle/unused.cocci
> 	+++ b/contrib/coccinelle/unused.cocci
> 	@@ -10,6 +10,5 @@ identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
> 	 @@
>
> 	 - T I = INIT;
> 	-  <+... when != \( I \| &I \)
> 	+  ... when != \( I \| &I \)
> 	 - \( REL1 \| REL2 \)(&I, ...);
> 	-  ...+>

This is what I would have suggested.  What you had before looked at the
whole function, and not just the region between T I = INIT; and \( REL1 \|
REL2 \)(&I, ...);

>
> Which helpfully catches other cases, e.g. now we spot this, which looks
> like an artifact of me using <+... (one or more lines?):
>
> 	diff --git a/graph.c b/graph.c
> 	index 568b6e7cd41..ba57f56fcb1 100644
> 	--- a/graph.c
> 	+++ b/graph.c
> 	@@ -350,8 +350,6 @@ struct git_graph *graph_init(struct rev_info *opt)
> 	                        graph_set_column_colors(column_colors_ansi,
> 	                                                column_colors_ansi_max);
> 	                } else {
> 	-                       static struct strvec custom_colors = STRVEC_INIT;
> 	-                       strvec_clear(&custom_colors);
> 	                        parse_graph_colors_config(&custom_colors, string);
> 	                        free(string);
> 	                        /* graph_set_column_colors takes a max-index, not a count */
>
> But that modification also produces some broken patches, e.g.:
>
> 	diff --git a/builtin/rm.c b/builtin/rm.c
> 	index 84a935a16e8..7e2b4355713 100644
> 	--- a/builtin/rm.c
> 	+++ b/builtin/rm.c
> 	@@ -395,13 +395,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
> 	         * any file at all, we'll go ahead and commit to it all:
> 	         * by then we've already committed ourselves and can't fail
> 	         * in the middle)
> 	         */
> 	        if (!index_only) {
> 	                int removed = 0, gitmodules_modified = 0;
> 	-               struct strbuf buf = STRBUF_INIT;
> 	                int flag = force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
> 	                for (i = 0; i < list.nr; i++) {
> 	                        const char *path = list.entry[i].name;
> 	                        if (list.entry[i].is_submodule) {
> 	                                strbuf_reset(&buf);
> 	                                strbuf_addstr(&buf, path);
> 	@@ -417,13 +416,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
> 	                                removed = 1;
> 	                                continue;
> 	                        }
> 	                        if (!removed)
> 	                                die_errno("git rm: '%s'", path);
> 	                }
> 	-               strbuf_release(&buf);
> 	                if (gitmodules_modified)
> 	                        stage_updated_gitmodules(&the_index);
> 	        }
>
> 	        if (write_locked_index(&the_index, &lock_file,
> 	                               COMMIT_LOCK | SKIP_IF_UNCHANGED))
>
> I.e. here &buf is used between the two lines, so this wouldn't compile.
>
> I suspect this is all because that "WHEN != &I" isn't doing what I
> expect it to do, but I can't find what I'm missing.

I think that the problem is due to the continue.  Try adding when strict,
which should force it to check all of the execution paths, including the
ones that look like error handling code.

julia

> I also tried to come up with a rule for matching a similar pattern where
> code like this does nothing useful:
>
> 	static void foo(void)
> 	{
> 	        struct strbuf sb;
> 	        strbuf_init(&sb, 0);
> 	        // fprintf(stderr, "%s", sb.buf); // not if this is here
> 	        strbuf_release(&sb);
> 	        // strbuf_reset(&sb); // nor this
> 	}
>
> And came up with:
>
> 	@@
> 	identifier I;
> 	@@
>
> 	- struct strbuf I;
> 	  ... when != \( I \| &I \)
> 	- strbuf_init(&I, ...);
> 	  ... when != \( I \| &I \)
> 	- strbuf_release(&I);
> 	  ... when != \( I \| &I \)
>
> Which seems to do the right thing, but given how the rm.c case behaved
> above I don't understand why it won't fire if I uncomment that code
> (which is good!) but the strbuf_reset(&buf) case above isn't caught.
>
> Full diff quoted below, and also at
> https://lore.kernel.org/git/patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com/
>
> On Fri, May 20 2022, Ævar Arnfjörð Bjarmason wrote:
>
> > Add a coccinelle rule to remove variable initialization followed by
> > calling a "release" function. This rule automatically finds the sort
> > of issue patched in[1], and more.
> >
> > We happened to only have occurrences of strbuf_release() matching this
> > rule, but manual testing reveals that it'll find e.g. the same pattern
> > if "string_list_clear()" were used instead.
> >
> > 1. https://lore.kernel.org/git/042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com/
> >
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > ---
> >
> > This overlaps but cleanly merges with the small series that [1] is in,
> > but just adding a coccinelle rule to catch this seemed like a good
> > thing to have. We even have another such case in builtin/merge.c, near
> > the change made in [1]!
> >
> > FWIW I wrote this working rule too, but there were no in-tree hits for
> > it, so I didn't include it:
> >
> > 	// Unused declaration + malloc + free()
> > 	@@
> > 	identifier I;
> > 	type T;
> > 	// malloc(), xmalloc(), calloc() etc.
> > 	identifier MALLOC =~ "^x?[mc]alloc$";
> > 	@@
> >
> > 	(
> > 	- T *I;
> > 	  ... when != I
> > 	- I = MALLOC(...);
> > 	|
> > 	- T *I = MALLOC(...);
> > 	)
> > 	  ... when != I
> > 	- free(I);
> >
> >  builtin/fetch.c                 |  3 +--
> >  builtin/merge.c                 |  4 ----
> >  builtin/repack.c                |  2 --
> >  contrib/coccinelle/unused.cocci | 15 +++++++++++++++
> >  diff.c                          |  2 --
> >  5 files changed, 16 insertions(+), 10 deletions(-)
> >  create mode 100644 contrib/coccinelle/unused.cocci
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index e3791f09ed5..600c28fdb75 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1113,7 +1113,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
> >  			      struct fetch_head *fetch_head, struct worktree **worktrees)
> >  {
> >  	int url_len, i, rc = 0;
> > -	struct strbuf note = STRBUF_INIT, err = STRBUF_INIT;
> > +	struct strbuf note = STRBUF_INIT;
> >  	const char *what, *kind;
> >  	struct ref *rm;
> >  	char *url;
> > @@ -1281,7 +1281,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
> >
> >   abort:
> >  	strbuf_release(&note);
> > -	strbuf_release(&err);
> >  	free(url);
> >  	return rc;
> >  }
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index f178f5a3ee1..bb6b0580659 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
> >  static void restore_state(const struct object_id *head,
> >  			  const struct object_id *stash)
> >  {
> > -	struct strbuf sb = STRBUF_INIT;
> >  	const char *args[] = { "stash", "apply", NULL, NULL };
> >
> >  	if (is_null_oid(stash))
> > @@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
> >  	 */
> >  	run_command_v_opt(args, RUN_GIT_CMD);
> >
> > -	strbuf_release(&sb);
> >  	refresh_cache(REFRESH_QUIET);
> >  }
> >
> > @@ -501,7 +499,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
> >  {
> >  	struct commit *remote_head;
> >  	struct object_id branch_head;
> > -	struct strbuf buf = STRBUF_INIT;
> >  	struct strbuf bname = STRBUF_INIT;
> >  	struct merge_remote_desc *desc;
> >  	const char *ptr;
> > @@ -589,7 +586,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
> >  		oid_to_hex(&remote_head->object.oid), remote);
> >  cleanup:
> >  	free(found_ref);
> > -	strbuf_release(&buf);
> >  	strbuf_release(&bname);
> >  }
> >
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index d1a563d5b65..52f8450f1be 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -609,7 +609,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  	struct child_process cmd = CHILD_PROCESS_INIT;
> >  	struct string_list_item *item;
> >  	struct string_list names = STRING_LIST_INIT_DUP;
> > -	struct string_list rollback = STRING_LIST_INIT_NODUP;
> >  	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
> >  	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
> >  	struct pack_geometry *geometry = NULL;
> > @@ -955,7 +954,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  	}
> >
> >  	string_list_clear(&names, 0);
> > -	string_list_clear(&rollback, 0);
> >  	string_list_clear(&existing_nonkept_packs, 0);
> >  	string_list_clear(&existing_kept_packs, 0);
> >  	clear_pack_geometry(geometry);
> > diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
> > new file mode 100644
> > index 00000000000..52c23e15310
> > --- /dev/null
> > +++ b/contrib/coccinelle/unused.cocci
> > @@ -0,0 +1,15 @@
> > +// Unused init assignment + release()
> > +@@
> > +identifier I;
> > +type T;
> > +constant INIT =~ "_INIT";
> > +// stbuf_release(), string_list_clear() etc.
> > +identifier REL1 =~ "^[a-z_]*_(release|clear|free)$";
> > +// release_patch(), clear_pathspec() etc.
> > +identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
> > +@@
> > +
> > +- T I = INIT;
> > +  <+... when != \( I \| &I \)
> > +- \( REL1 \| REL2 \)(&I, ...);
> > +  ...+>
> > diff --git a/diff.c b/diff.c
> > index ef7159968b6..57997937071 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -1289,7 +1289,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
> >  {
> >  	static const char *nneof = " No newline at end of file\n";
> >  	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
> > -	struct strbuf sb = STRBUF_INIT;
> >
> >  	enum diff_symbol s = eds->s;
> >  	const char *line = eds->line;
> > @@ -1521,7 +1520,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
> >  	default:
> >  		BUG("unknown diff symbol");
> >  	}
> > -	strbuf_release(&sb);
> >  }
> >
> >  static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>
>
--8323329-1828384921-1653053375=:2929--
