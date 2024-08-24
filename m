Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD34CC52D6F
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2024 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=l8d8pAQOJk467oEkYEpob7uxkhYqwGJLOgQG59qS1F8=;
  b=TxGGHr37anZVpqQ+6z0L1wF2GryjqxZFO3NSUXupPgja8Xk8IcTuvQkh
   SL7L5hAO8X9dB7l2Az32HxTdvDQiEgP4BArr8JKhCFFPNfdfqcqekTpAe
   CtK4uU0JkuftSlSebWXLxLliSnz/RaxI++AaEaTdbXKBxssdLN+ds1UXJ
   k=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208";a="179942923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2024 20:09:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 144B8E013D; Sat, 24 Aug 2024 20:09:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5C1B5E00B7
	for <cocci@sympa.inria.fr>; Sat, 24 Aug 2024 20:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l8d8pAQOJk467oEkYEpob7uxkhYqwGJLOgQG59qS1F8=;
  b=e+BHAPJ+bG5AanbFo76SLSIF1Kkb9duYxXFsRDAYlyoGbGd2duYthUcV
   YdoC3vF8nUcO5rxByW32I9rLlc2q0y3m5tnsOs1qaGDX2lOAhfChbxBNc
   +pHq5q1NEKT0WE9UAjQPFS2TAQQQNoLi6WVCmn4Httt6KalUHi0NFCHFB
   g=;
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208";a="94623467"
Received: from 109-192-142-46.pool.kielnet.net (HELO hadrien) ([46.142.192.109])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 20:09:06 +0200
Date: Sat, 24 Aug 2024 20:09:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <5dea7b1b-3e0c-40ec-af12-b15e2a66502a@gmail.com>
Message-ID: <d6e69dbf-799f-e0a-ee55-2cac9a3555e2@inria.fr>
References: <983f5490-ee27-4558-832f-6d5af7344b79@gmail.com> <25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr> <5dea7b1b-3e0c-40ec-af12-b15e2a66502a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-806896177-1724522945=:3257"
Subject: Re: [cocci] Symbolic names in iso-files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1862
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/d6e69dbf-799f-e0a-ee55-2cac9a3555e2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-806896177-1724522945=:3257
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 24 Aug 2024, Mats Kindahl wrote:

> On 2024-08-24 14:56, Julia Lawall wrote:
>       Can you just add semicolons in your isomorphism?
>       Sent from my iPhone
>
>
> Hi Julia,
>
> I assume you mean to write something like this:
>
>       Statement
>       @ pg_return @
>       @@
>         PG_RETURN_VOID(); => return;
>
> But that fails with the same error message:
>
>       mats@abzu:~/lang/cocci/hacks$ spatch --sp-file lwlock.cocci
>       code/lwlock.c
>       init_defs_builtins: /usr/lib/coccinelle/standard.h
>       iso main: parse error:  
>        File "./postgres.iso", line 4, column 2, charpos = 29
>        around = 'PG_RETURN_VOID',
>        whole content =   PG_RETURN_VOID(); => return;

Thanks for the report.  I will check on it.

Even without the isomorphism, you should be able to write a disjunction in
your semantic patch?

julia

>
> Best wishes,
> Mats Kindahl
>
>
>
>             On 24 Aug 2024, at 14:23, Mats Kindahl
>             <mats.kindahl@gmail.com> wrote:
>
>
>       ﻿Hi all,
>
>       In some code, there are macros used for different
>       purposes. One typical case is having a "foreach" macro,
>       but this is covered using "iterator" so that you can deal
>       with code like this:
>
>             static Jsonb *BuildJsonObject(List *items) {
>               ListCell *cell;
>               JsonbParseState *state = NULL;
>               JsonbValue *value;
>
>               pushJsonbValue(&state, WJB_BEGIN_OBJECT,
>             NULL);
>               foreach (cell, items) {
>                 KVItem *item = (KVItem *)lfirst(cell);
>                 AddJsonField(&state, item->key,
>             item->value);
>               }
>               value = pushJsonbValue(&state,
>             WJB_END_OBJECT, NULL);
>
>               return JsonbValueToJsonb(value);
>             }
>
>       However, if you want to make sure to deal with resource
>       allocation and make sure that you release a short-lived
>       lock, for example (grossly simplified, just to demonstrate
>       the problem):
>
>             @@
>             expression lock, mode;
>             @@
>               LWLockAcquire(lock, mode);
>               ... when exists
>             (
>               LWLockRelease(lock);
>             |
>             + LWLockRelease(lock);
>               return;
>             )
>
>       If fails miserably with this code:
>
>             Datum start_worker(PG_FUNCTION_ARGS) {
>               pid_t pid;
>
>               if (!autoprewarm)
>                 ereport(ERROR,
>             (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>                                 errmsg("autoprewarm is
>             disabled")));
>
>               apw_init_shmem();
>               LWLockAcquire(&apw_state->lock,
>             LW_EXCLUSIVE);
>               pid = apw_state->bgworker_pid;
>
>               if (pid != InvalidPid)
>                 ereport(ERROR,
>             (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>                                 errmsg("autoprewarm worker
>             is already running under PID %d",
>                                        (int)pid)));
>
>               apw_start_leader_worker();
>
>               PG_RETURN_VOID();
>             }
>
>       Giving the patch, where the call to LWLockRelease should
>       be before the PG_RETURN_VOID:
>
>             --- code/lwlock.c
>             +++ /tmp/cocci-output-12611-ff946d-lwlock.c
>             @@ -18,6 +18,7 @@ Datum
>             start_worker(PG_FUNCTION_ARGS) {
>               apw_start_leader_worker();
>              
>               PG_RETURN_VOID();
>             +  LWLockRelease(&apw_state->lock);
>             }
>
>       Since this is such a common construct, and you do not want
>       to deal with this for every potential case, this seems
>       like an obvious case for using an iso-file, so I created
>       one that looks like this, with the idea that we support
>       replacing "PG_RETURN_VOID()" with just a "return".
>
>             Statement
>             @ pg_return @
>             @@
>               PG_RETURN_VOID() => return
>
>       However, this fails with the following error message:
>
>             mats@abzu:~/lang/cocci/hacks$ spatch --sp-file
>             lwlock.cocci code/lwlock.c
>             init_defs_builtins:
>             /usr/lib/coccinelle/standard.h
>             iso main: parse error:  
>              File "./postgres.iso", line 4, column 19,
>             charpos = 46
>              around = '=>',
>              whole content =   PG_RETURN_VOID() => return
>
>       Which I suppose mean that there is no support for handling
>       anything but standard tokens in an .iso file.
>
>       Have I misunderstood the situation and this is already
>       supported in some way?
>
>       Are there any plans that add such support to the ISO
>       grammar?
>
>       Best wishes,
>       Mats Kindahl, Timescale
>
>
>
--8323329-806896177-1724522945=:3257--
