Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC917C54EE9
	for <cocci@archiver.kernel.org>; Sun, 25 Sep 2022 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wLsEDurwft43/YePZ6k+1eM1wmYwbW60bpM0NlgOgus=;
  b=PVpoSjANJJQIXY42n8YSF3i4iA4hkVCHc/zgegPxIDgWsmQvPmaRQfLa
   sO5RL6Lypd604ObtYeiVW5CdegAHvI9MmCjqDqi249tVWxmdNkF+adVfd
   WWKdXC8wMuaf4Ju/QFDG6VmJAMtF6AGfb9StIzGIafSX9MNCo7ePbv/jc
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,344,1654552800"; 
   d="scan'208";a="54401382"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2022 19:12:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F24C3E0091; Sun, 25 Sep 2022 19:12:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2274BE0090
	for <cocci@sympa.inria.fr>; Sun, 25 Sep 2022 19:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wLsEDurwft43/YePZ6k+1eM1wmYwbW60bpM0NlgOgus=;
  b=U/Liy0Rdqnuu8eHX5kl4qxeqbQYwUhwKDG3cbbrxmIHqgrcvX43Twjrl
   FZhYR1b2IlLW6ejM+3uUCkU2bqNdv1AYxVcYxCsdxVrDli2eFXpQI1ZMc
   0fzAab3WmEZyCuISyd+jmG9y6PK9F6afccPrVs51u1x+ZZxBa056BFi5D
   k=;
X-IronPort-AV: E=Sophos;i="5.93,344,1654552800"; 
   d="scan'208";a="54401377"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 19:12:13 +0200
Date: Sun, 25 Sep 2022 19:12:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
Message-ID: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] usage of locks
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 583
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209251906090.3293%40hadrien>

Here is an alternative semantic patch to the one proposed by Yuan Can.  It
checks across the entire kernel for lock declarations, initializations and
locks, and reports on locks that are declared but seem not to be
initialized, not to be locked, or both.  There may be false positives due
to problems in parsing the functions that initialize or lock the locks.
Another reason for false positives is the use of typedefs that make the
type at the point of declaraion and at the point of initialization or
locking appear to be different.

When a lock has a distinctive name, it is easy to check the results using
grep.  Unfortunately, many locks are called "lock".

Yuan Can (or anyone else), if you find some bugs that are worth fixing,
please go ahead.

julia

#spatch --include-headers --recursive-includes --include-headers-for-types

@initialize:ocaml@
@@

let created = Hashtbl.create 101
let created_array = Hashtbl.create 101
let initialized = Hashtbl.create 101
let locked = Hashtbl.create 101
let possible_init = Hashtbl.create 101
let possible_lock = Hashtbl.create 101
let other = Hashtbl.create 101

@create1@
identifier t,f;
position pl;
typedef spinlock_t;
@@

struct t {
   ...
   spinlock_t f@pl;
   ...
}

@script:ocaml@
t << create1.t;
f << create1.f;
p << create1.pl;
@@

Hashtbl.replace created ("struct "^t,f) p

@create2@
identifier t,f;
position pl;
typedef spinlock_t;
@@

struct t {
   ...
   struct mutex f@pl;
   ...
}

@script:ocaml@
t << create2.t;
f << create2.f;
p << create2.pl;
@@

Hashtbl.replace created ("struct "^t,f) p

@create3@
identifier t,f;
position pa;
typedef spinlock_t;
@@

struct t {
   ...
   spinlock_t f@pa[...];
   ...
}

@script:ocaml@
t << create3.t;
f << create3.f;
p << create3.pa;
@@

Hashtbl.replace created_array ("struct "^t,f) p

@create4@
identifier t,f;
position pa;
typedef spinlock_t;
@@

struct t {
   ...
   struct mutex f@pa[...];
   ...
}

@script:ocaml@
t << create4.t;
f << create4.f;
p << create4.pa;
@@

Hashtbl.replace created_array ("struct "^t,f) p

(* ------------------------------------------------- *)
(* check for standard initializations and locks *)

@init@
type t;
t o;
identifier f;
position p;
@@

\(spin_lock_init\|mutex_init\|__mutex_init\|__mutex_rt_init\)(\(&o.f@p\|&o.f@p[...]\))

@script:ocaml@
t << init.t;
f << init.f;
p << init.p;
@@

Hashtbl.replace initialized (t,f) p

@init1@
identifier t,i,f;
position p;
@@

struct t i = {
	.f@p	= __SPIN_LOCK_UNLOCKED(f),
};

@script:ocaml@
t << init1.t;
f << init1.f;
p << init1.p;
@@

Hashtbl.replace initialized ("struct "^t,f) p

@lock@
type t;
t o;
identifier f;
identifier lock = {spin_lock,spin_lock_bh,spin_lock_irqsave,spin_lock_irq,spin_lock_nested,
  spin_trylock,spin_trylock_bh,spin_trylock_irqsave,spin_trylock_irq,
  mutex_lock,mutex_trylock,mutex_lock_nested,mutex_lock_interruptible,mutex_lock_killable,mutex_lock_io};
position p;
@@

lock(\(&o.f@p\|&o.f@p[...]\),...)

@script:ocaml@
t << lock.t;
f << lock.f;
p << lock.p;
@@

Hashtbl.replace locked (t,f) p

(* ------------------------------------------------- *)
(* check for aliases or non-standard uses *)

@alias1@
type t;
t o;
identifier f;
position p;
expression x;
{spinlock_t,struct mutex} *e;
@@

(
x = e
&
x = \(&o.f@p\|&o.f@p[...]\)
)

@script:ocaml@
t << alias1.t;
f << alias1.f;
p << alias1.p;
@@

Hashtbl.replace initialized (t,f) p;
Hashtbl.replace locked (t,f) p

@alias2@
type t;
t o;
identifier f;
position p;
{spinlock_t,struct mutex} *e;
@@

(
return e;
&
return \(&o.f@p\|&o.f@p[...]\);
)

@script:ocaml@
t << alias2.t;
f << alias2.f;
p << alias2.p;
@@

Hashtbl.replace initialized (t,f) p;
Hashtbl.replace locked (t,f) p

@alias3@
type t;
t o;
identifier f;
expression ifn =~ "init";
expression lfn =~ "lock";
expression ofn != mutex_destroy;
position p;
{spinlock_t,struct mutex} *e;
@@

\(ifn\|lfn\|ofn\)(...,
(
e
&
\(&o.f@p\|&o.f@p[...]\)
)
,...)

@script:ocaml@
t << alias3.t;
f << alias3.f;
p << alias3.p;
ifn << alias3.ifn;
@@

Hashtbl.replace possible_init (t,f) (p,ifn)

@script:ocaml@
t << alias3.t;
f << alias3.f;
p << alias3.p;
lfn << alias3.lfn;
@@

Hashtbl.replace possible_lock (t,f) (p,lfn)

@script:ocaml@
t << alias3.t;
f << alias3.f;
p << alias3.p;
ofn << alias3.ofn;
@@

Hashtbl.replace other (t,f) (p,ofn)

(* ------------------------------------------------- *)

@finalize:ocaml@
cs << merge.created;
ss << merge.created_array;
is << merge.initialized;
ls << merge.locked;
pi << merge.possible_init;
pl << merge.possible_lock;
ot << merge.other;
@@

let redo l tbl =
  List.iter (Hashtbl.iter (Hashtbl.replace tbl)) l in
redo cs created;
redo ss created_array;
redo is initialized;
redo ls locked;
redo pi possible_init;
redo pl possible_lock;
redo ot other;

let clean s =
  match Str.split (Str.regexp (!Flag.dir^"/")) s with
    [x] -> x
  | _ -> s in

let check_possible s k possible other =
  try
    let (p,fn) = Hashtbl.find possible k in
    Printf.sprintf " (possible %s via call to %s in %s:%d)"
      s fn (clean((List.hd p).file)) (List.hd p).line
  with Not_found ->
    try
      let (p,fn) = Hashtbl.find other k in
      Printf.sprintf " (possible %s via call to %s in %s:%d)"
	s fn (clean((List.hd p).file)) (List.hd p).line
    with Not_found -> "" in

let collect s created =
  Hashtbl.fold
    (fun ((t,f) as k) p r ->
      let file = clean ((List.hd p).file) in
      let line = (List.hd p).line in
      let isinit = Hashtbl.mem initialized k in
      let islocked = Hashtbl.mem locked k in
      match (isinit,islocked) with
	(true,true) -> r
      | (true,false) ->
	  let p = Hashtbl.find initialized k in
	  (1,Printf.sprintf
	     "%slock %s.%s declared in %s on line %d is initialized in %s on line %d, but is never locked%s"
	     s t f file line (clean((List.hd p).file)) (List.hd p).line
	     (check_possible "lock" k possible_lock other)) :: r
      | (false,true) ->
	  let p = Hashtbl.find locked k in
	  (2,Printf.sprintf "%slock %s.%s declared in %s on line %d is locked in %s on line %d, but is never initialized%s"
	     s t f file line (clean((List.hd p).file)) (List.hd p).line
	     (check_possible "init" k possible_init other)) :: r
      | (false,false) ->
	  (3,Printf.sprintf "%slock %s.%s declared in %s on line %d is never locked or initialized%s%s"
	     s t f file line
	     (check_possible "init" k possible_init other)
	     (check_possible "lock" k possible_lock other)) :: r)
    created [] in

let r1 = collect "" created in
let r2 = collect "array " created_array in
let res = List.sort compare (List.append r1 r2) in
List.iter (fun x -> Printf.printf "%s\n" (snd x)) res
