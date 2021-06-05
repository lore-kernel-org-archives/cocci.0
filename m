Return-Path: <SRS0=/Ux4=K7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D8C47082
	for <cocci@archiver.kernel.org>; Sat,  5 Jun 2021 19:30:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB4D6138C
	for <cocci@archiver.kernel.org>; Sat,  5 Jun 2021 19:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB4D6138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 155JUIKE005513;
	Sat, 5 Jun 2021 21:30:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2D6CF7501;
	Sat,  5 Jun 2021 21:30:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 738B574E8
 for <cocci@systeme.lip6.fr>; Sat,  5 Jun 2021 21:30:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 155JUF0e026298
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 5 Jun 2021 21:30:15 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0PTowKGvcdlhxhucpLqE78eALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6Oj/PxG8M5w6fawslcssRIb6LW90cu7IU80nKQdibX5f43SPzUO01?=
 =?us-ascii?q?HHEGgN1+ffKnHbak/D398Y5ONbf69yBMaYNzVHpMzxiTPWL+od?=
X-IronPort-AV: E=Sophos;i="5.83,251,1616454000"; d="scan'208";a="511914244"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2021 21:30:06 +0200
Date: Sat, 5 Jun 2021 21:30:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <YLvDVI9TCEVoL16r@zx2c4.com>
Message-ID: <alpine.DEB.2.22.394.2106052129440.32368@hadrien>
References: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2106051335410.25155@hadrien>
 <YLvDVI9TCEVoL16r@zx2c4.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1728434706-1622921406=:32368"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jun 2021 21:30:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jun 2021 21:30:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct type renaming in the absence of certain function
 calls on members
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1728434706-1622921406=:32368
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 5 Jun 2021, Jason A. Donenfeld wrote:

> Hi Julia,
>
> Holy mackerel, that's amazing. Thank you so much! Very fancy embedding
> the ocaml in there, and just using a hash table. Neat idea.
>
> I'm running it (well, a modified version, pasted below) on a codebase
> and finding that it fails to replace the "struct rwlock x" with "struct
> mtx x" in most cases, except one, which is strange. I wonder if it's the
> parser choking on macros it doesn't understand in the code? Or on
> something else?

It seems to be choking on the macros...

julia

>
> Code is here, if you're curious:
>
> $ git clone https://git.zx2c4.com/wireguard-freebsd
> $ cd wireguard-freebsd/src
> $ spatch.opt --sp-file doit.cocci -j 4 --recursive-includes --include-headers-for-types --include-headers --in-place .
>
> I'll keep playing with it to see what's happening...
>
> Jason
>
> == doit.cocci ==
>
> virtual after_start
>
> @initialize:ocaml@
> @@
>
> let has_write_table = Hashtbl.create 101
> let has_read_table = Hashtbl.create 101
>
> let ok i m =
>   let entry = (i,m) in
>   Hashtbl.mem has_write_table entry && not(Hashtbl.mem has_read_table entry)
>
> @hasw depends on !after_start@
> identifier i,m;
> struct i x;
> @@
>
> (
> rw_wlock(&x.m)
> |
> rw_wunlock(&x.m)
> )
>
> @script:ocaml@
> i << hasw.i;
> m << hasw.m;
> @@
> Hashtbl.replace has_write_table (i,m) ()
>
> @hasr depends on !after_start@
> identifier i,m;
> struct i x;
> @@
>
> (
> rw_rlock(&x.m)
> |
> rw_runlock(&x.m)
> )
>
> @script:ocaml@
> i << hasr.i;
> m << hasr.m;
> @@
> Hashtbl.replace has_read_table (i,m) ()
>
> @finalize:ocaml depends on !after_start@
> wt << merge.has_write_table;
> rt << merge.has_read_table;
> @@
>
> let redo ts dst =
>   List.iter (Hashtbl.iter (fun k _ -> Hashtbl.add dst k ())) ts in
> redo wt has_write_table;
> redo rt has_read_table;
>
> let it = new iteration() in
> it#add_virtual_rule After_start;
> it#register()
>
> (* ----------------------------------------------------------- *)
>
> @ty2 depends on after_start@
> identifier i;
> identifier m : script:ocaml(i) { ok i m };
> @@
>
> struct i {
>   ...
> - struct rwlock m;
> + struct mtx m;
>   ...
> }
>
> @depends on after_start disable fld_to_ptr@
> identifier m;
> identifier i : script:ocaml(m) { ok i m };
> struct i x;
> @@
>
> - rw_wlock
> + mtx_lock
>    (&x.m)
>
> @depends on after_start disable fld_to_ptr@
> identifier m;
> identifier i : script:ocaml(m) { ok i m };
> struct i x;
> @@
>
> - rw_wunlock
> + mtx_unlock
>    (&x.m)
>
> @depends on after_start disable fld_to_ptr@
> identifier m;
> expression e;
> identifier i : script:ocaml(m) { ok i m };
> struct i x;
> @@
>
> - rw_init(&x.m, e);
> + mtx_init(&x.m, e, NULL, MTX_DEF);
>
> @depends on after_start disable fld_to_ptr@
> identifier m;
> identifier i : script:ocaml(m) { ok i m };
> struct i x;
> @@
>
> - rw_destroy
> + mtx_destroy
>    (&x.m)
>
> @depends on after_start disable fld_to_ptr, ptr_to_array@
> identifier m;
> identifier i : script:ocaml(m) { ok i m };
> struct i *x;
> @@
>
> - rw_wlock
> + mtx_lock
>    (&x->m)
>
> @depends on after_start disable fld_to_ptr, ptr_to_array@
> identifier m;
> identifier i : script:ocaml(m) { ok i m };
> struct i *x;
> @@
>
> - rw_wunlock
> + mtx_unlock
>    (&x->m)
>
> @depends on after_start disable fld_to_ptr, ptr_to_array@
> identifier m;
> expression e;
> identifier i : script:ocaml(m) { ok i m };
> struct i *x;
> @@
>
> - rw_init(&x->m, e);
> + mtx_init(&x->m, e, NULL, MTX_DEF);
>
> @depends on after_start disable fld_to_ptr, ptr_to_array@
> identifier m;
> identifier i : script:ocaml(m) { ok i m };
> struct i *x;
> @@
>
> - rw_destroy
> + mtx_destroy
>    (&x->m)
>
--8323329-1728434706-1622921406=:32368
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1728434706-1622921406=:32368--
