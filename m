Return-Path: <SRS0=/Ux4=K7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23CEC47082
	for <cocci@archiver.kernel.org>; Sat,  5 Jun 2021 11:41:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9F46139A
	for <cocci@archiver.kernel.org>; Sat,  5 Jun 2021 11:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9F46139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 155BffcG020724;
	Sat, 5 Jun 2021 13:41:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D04737501;
	Sat,  5 Jun 2021 13:41:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 785D674E8
 for <cocci@systeme.lip6.fr>; Sat,  5 Jun 2021 13:41:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 155BfcCU006182
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 5 Jun 2021 13:41:38 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApsIR0q0CowvJWhyfhdnqNgqjBD0kLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSK2lfqeV7ZAmPH7P+VMssRQb8+xoV5PsfZqxz/JICWd4B8bZYOCkgh?=
 =?us-ascii?q?rSEGlahbGSvgEIYheOitK1t50BT0EOMqyTMbEgt7ec3ODQKb9Jq+VvlprGuQ60?=
 =?us-ascii?q?9QYPcegFUc9dBi5Ce3mmO3wzaglaJIYzUKGR7tBAoFObCAwqR/X+KHkZfvTJ4+?=
 =?us-ascii?q?bGnpL+YRIAGnccmXCzpALtxr7mMgSSmiwTWTNXwbsk7CzsngHj6r+42svLtCP0?=
 =?us-ascii?q?5iv874l2hNCk8NdFCcCW4/JlTAnRtg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.83,250,1616454000"; d="scan'208";a="511889035"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2021 13:41:38 +0200
Date: Sat, 5 Jun 2021 13:41:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2106051335410.25155@hadrien>
References: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jun 2021 13:41:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jun 2021 13:41:38 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sat, 5 Jun 2021, Jason A. Donenfeld wrote:

> Hi,
>
> I'm trying to write a spatch rule that has some inversion logic for a
> given struct member, but I'm struggling to express this in SmPL. I'm
> also a bit of a coccinelle novice, however. Specifically, I'm trying
> to express:
>
> For all structs, for each member `M` of type `struct rwlock`, if there
> are calls to `rwlock_wlock(&M)` and `rwlock_wunlock(&M)`, but there
> are no calls to `rwlock_rlock(&M)` or `rwlock_runlock(&M)`, then
> change `M`'s type from `struct rwlock` to `struct lock` and change
> calls to `rwlock_wlock(&M)` and `rwlock_wunlock(&M)` to
> `lock_lock(&M)` and `lock_unlock(&M)`, respectively.
>
> In other words, "if I'm not using the reader part of an rwlock, make
> it into a normal boring lock."
>
> I realize that tracking whether, in a call to f(&something->M),
> something is actually of the type in which rwlock was replaced is kind
> of hard (I think?). But I'd be willing to compromise on just assuming
> that something->M is always correct, because M always has
> unique-enough names. Or maybe that compromise isn't needed due to some
> sort of amazing coccinelle type inference, but anyway, I'm willing to
> compromise.
>
> The trickiest part seems to be, however, only doing this in the case
> where there aren't calls to `rwlock_rlock(&M)` and
> `rwlock_runlock(&M)`. I tried using a virtual rule and a depends
> clause, but those dependencies don't seem to work over a given
> instance of an identifier.
>
> I could probably hack my way toward that with a ridiculous sed
> expression, or do it procedurally after parsing the AST. But it seems
> like this would be a good case for where Coccinelle makes things
> easier, so I thought I'd commit to getting it done with spatch. Any
> pointers would be appreciated.

A possible semantic patch is below.  Note that the first line with the
#spatch gives some implicit command line options.  You may want to change
the number of cores.  Note that the semantic patch will directly modify
your code, so don't run it on anything you dont' want to destroy...

There are two parts.  The first part finds relevant structures and locking
functions, and stores which operations are used on which structures in
some hash tables.  That part is run over the entire code base.

After the completion of the first part, the second part looks for
structure definitions and calls that can be changed.

Hopefully the code based doesn't have multiple definitions of the same
structure with different properties.  If that is a concern, it could be
possible to collect the names of the relevant structure definitions in the
first phase as well, and complain about or ignore structure names that are
defined twice.

julia

#spatch -j 4 --recursive-includes --include-headers-for-types --include-headers --in-place

virtual after_start

@initialize:ocaml@
@@

let has_write_table = Hashtbl.create 101
let has_read_table = Hashtbl.create 101

let ok i m =
  let entry = (i,m) in
  Hashtbl.mem has_write_table entry && not(Hashtbl.mem has_read_table entry)

@hasw depends on !after_start@
identifier i,m;
struct i x;
@@

(
rwlock_wlock(&x.m)
|
rwlock_wunlock(&x.m)
)

@script:ocaml@
i << hasw.i;
m << hasw.m;
@@
Hashtbl.replace has_write_table (i,m) ()

@hasr depends on !after_start@
identifier i,m;
struct i x;
@@

(
rwlock_rlock(&x.m)
|
rwlock_runlock(&x.m)
)

@script:ocaml@
i << hasr.i;
m << hasr.m;
@@
Hashtbl.replace has_read_table (i,m) ()

@finalize:ocaml depends on !after_start@
wt << merge.has_write_table;
rt << merge.has_read_table;
@@

let redo ts dst =
  List.iter (Hashtbl.iter (fun k _ -> Hashtbl.add dst k ())) ts in
redo wt has_write_table;
redo rt has_read_table;

let it = new iteration() in
it#add_virtual_rule After_start;
it#register()

(* ----------------------------------------------------------- *)

@ty2 depends on after_start@
identifier i;
identifier m : script:ocaml(i) { ok i m };
@@

struct i {
  ...
- struct rwlock m;
+ struct lock m;
  ...
}

@depends on after_start disable fld_to_ptr@
identifier m;
identifier i : script:ocaml(m) { ok i m };
struct i x;
@@

- rwlock_wlock
+ lock_lock
   (&x.m)

@depends on after_start disable fld_to_ptr@
identifier m;
identifier i : script:ocaml(m) { ok i m };
struct i x;
@@

- rwlock_wunlock
+ lock_unlock
   (&x.m)

@depends on after_start disable fld_to_ptr, ptr_to_array@
identifier m;
identifier i : script:ocaml(m) { ok i m };
struct i *x;
@@

- rwlock_wlock
+ lock_lock
   (&x->m)

@depends on after_start disable fld_to_ptr, ptr_to_array@
identifier m;
identifier i : script:ocaml(m) { ok i m };
struct i *x;
@@

- rwlock_wunlock
+ lock_unlock
   (&x->m)
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
