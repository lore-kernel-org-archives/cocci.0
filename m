Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8C1D462BF
	for <cocci@archiver.kernel.org>; Wed, 13 Nov 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kn/9xQbXVnDcfaeTC0Gj2xctRSnl7spAzK47PWK6WLc=;
  b=IVK+J9QkU7pS9wL4Zi1kPmP6f28fNn0WQPdP/hllp+rrvoNJDlH+oB4D
   O9UUDGz4ZmkJBFYIqnFo2AGXc+SCzXGrwy7gPHsOqXO0lK7QU5KhtDn4H
   PLmwB32ZCp8ceKRC7sMSQeOzuow9d52ILBM9LTZb4mQidpqPWcER3S/8u
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,151,1728943200"; 
   d="scan'208";a="193671868"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2024 16:13:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E813BE0D1C; Wed, 13 Nov 2024 16:13:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 71087E00B7
	for <cocci@sympa.inria.fr>; Wed, 13 Nov 2024 16:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kn/9xQbXVnDcfaeTC0Gj2xctRSnl7spAzK47PWK6WLc=;
  b=hw35D0BDWZ9dj+69ammJe2i8BxWAYak8pLVkkByTAJtELjTj4rTxNy99
   8Is9PP5Zb+3oAzvB3Za6WHfWBcVDVNAUFHECMyiqQtvFhsHL3seCgwduB
   YKblEjlGw95qbgQaKMSl+fbaGS+WN9VLxXtExpTFOQYC5qtg68KJSu3SB
   8=;
X-IronPort-AV: E=Sophos;i="6.12,151,1728943200"; 
   d="scan'208";a="193671853"
Received: from unknown (HELO hadrien) ([50.226.245.43])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:13:47 +0100
Date: Wed, 13 Nov 2024 10:13:45 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <dfdf92b9-24d-5535-f066-1ad816d6c6e@inria.fr>
Message-ID: <31ac8b31-47ee-8d41-aa12-6d37c69790bc@inria.fr>
References: <f59fb941-f9a9-455c-a369-f764e33323e8@gmail.com> <dfdf92b9-24d-5535-f066-1ad816d6c6e@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-826259691-1731510827=:3184"
Subject: Re: [cocci] How to add error handling code before first use
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1999
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/31ac8b31-47ee-8d41-aa12-6d37c69790bc%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-826259691-1731510827=:3184
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 11 Nov 2024, Julia Lawall wrote:

>
>
> On Mon, 11 Nov 2024, Mats Kindahl wrote:
>
> >
> > Hi again,
> >
> > I am trying to match code like the following and add error handling to it:
> >
> >       #include <postgres.h>
> >
> >       void foo(Oid id) {
> >         HeapTuple tuple;
> >         Form_pg_proc fd;
> >
> >         tuple = SearchSysCache1(PROCOID, ObjectIdGetDatum(id));
> >         fd = (Form_pg_proc)GETSTRUCT(tuple);
> >
> >         if (strcmp("magic", NameStr(fd->proname)) != 0)
> >           printf("Bad magic\n");
> >       }
> >
> > The semantic patch I have for this is:
> >
> >       @@
> >       identifier tuple;
> >       expression id, cache;
> >       statement S;
> >       @@
> >         tuple = SearchSysCache1(cache, ObjectIdGetDatum(id));
> >         ... when != tuple
> >       (
> >         if (<+... HeapTupleIsValid(tuple) ...+>) S
> >       |
> >       + if (!HeapTupleIsValid(tuple))
> >       +   elog(ERROR, "cache lookup failed for %u", id);
> >         (<+...tuple...+>);
> >       )

Hello,

The problem is that first Coccinelle uses the isomorphism and drops the
().  Then the code that merges the + code with the context code sees code
added before a <+... ...+>, which it doesn't like.

To solve this you should be able to do something like the following (I
simplified it a bit):

@@
identifier tuple;
expression id, cache;
statement S;
@@
   tuple = SearchSysCache1(cache, ObjectIdGetDatum(id));
   ... when != tuple
(
+ if (!HeapTupleIsValid(tuple))
+     elog(ERROR, "cache lookup failed for %u", id);
   S
&
   (<+...tuple...+>);
)

julia





> >
> > However, when executing spatch, I get the following error:
> >
> >       mats@abzu:~/lang/cocci/postgres$ spatch --all-includes --sp-file heap_tuple.cocci code/heap_tuple.c
> >       init_defs_builtins: /usr/lib/coccinelle/standard.h
> >       before [[Tag29 ("{", 0)]; [Tag22 ((Tag1 ((Tag5 (("if", (11, 2, 0, 0, " "), Tag2 (0), 0), ("(", (11, 5, 0, 0, " "), Tag2 (0), 0), (Tag9 ((Tag3 (((
> >       ((("HeapTupleIsValid", (11, 7, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
> >       ("(", (11, 23, 0, 0, ""), Tag2 (0), 0), ([(((Tag1 ((("rule starting on line 1", "tuple"), (11, 24, 0, 0, ""), Tag2 (0), 0), 1, 0, 0), 11, 0, 0,
> >       0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)], 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (11, 29, 0, 0,
> >       ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (6, (11, 6, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
> >       (")", (11, 30, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (Tag8 ((Tag4 (((Tag3 (((((("elog", (12, 4, 0, 0, "   "), Ta
> >       g2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), ("(", (12, 8, 0, 0, ""), Tag2 (0), 0), ([((
> >       ((("ERROR", (12, 9, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag26 (("
> >       ,", (12, 14, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag1 ((("cache lookup failed for %u", 4), (12, 16, 0, 0, " ")
> >       , Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag26 ((",", (12, 44, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
> >       , 1, 0); (Tag22 ((("rule starting on line 1", "id"), (12, 46, 0, 0, " "), Tag2 (0), 0), 1, 0, 0, 0, 0, 0), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
> >       , 0)], 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (12, 48, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), (";", (1
> >       2, 49, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (0, 0, 0, Tag1 (0, 0)))
> >       , 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0))]]
> >       context tree should not have bad code before
> >
> > First, what is causing the error?
>
> I think the + code in the disjunction, based on the (mostly unreadable)
> complaint.
>
> > Second, is the semantic patch supposed to work or is another method preferred?
>
> It looks ok to me.  Actually, I have never seen this complaint.  I will
> look into it.
>
> julia
--8323329-826259691-1731510827=:3184--
