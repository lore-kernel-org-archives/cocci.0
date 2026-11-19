Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90837606A331
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=mc9y55c+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EKMky9BmEldC1ZjWvRwiP1TMZLLwKdRq88rm8KzCg5E=;
  b=mc9y55c+Lmq4nLPQ6H8Kj+lk87g+mrox2diRTIKvEUzS7i4pEIHfObS/
   PgNcXfO1pIc2wKqCY6Ub+aCYV3NnM4zmL/rVPIksip34q27m8uL+5u1dU
   lG8LSlutn7GVPtI8sfd1XLgPd/FJ9l2AJ0pd+U/3UvQZaaL5q02wAyP3x
   E=;
X-CSE-ConnectionGUID: iHttrK4PRwu8gQPG4Iecdw==
X-CSE-MsgGUID: CdFs8elgSD6TAXr2mVVWBQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,223,1787004000"; 
   d="scan'208";a="306545924"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2026 14:29:57 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F019D81B89; Fri, 20 Nov 2026 14:29:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 00B84806A9
	for <cocci@sympa.inria.fr>; Thu, 19 Nov 2026 22:31:59 +0100 (CET)
X-CSE-ConnectionGUID: eqZvL8HKTIyRJJIUao+Bzg==
X-CSE-MsgGUID: K0jb+oL5SfK/DiwggVPtCA==
IronPort-SDR: 6aff6acf_XJQudNfQaa5UiGHcOFK05G3jrOM5YbXlG4RCw6o2jh3A/jA
 QNySL7xNRmFv4uqd23MpgetoAme/+QQF2h0osNQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F6AQDNaf9qjxABWcdahRpCAYEpMwcISYRYkXQDn2g/D?=
 =?us-ascii?q?wEDAQ1PAgQBAQECBIFKAYMzAo4hAh8GAQQ0EwECBAMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBAQQBAQECAQECBAMBAQEBAhABAQEBAQE5BQ47hk8NjBoBgSReSAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARQCDV4BHgEBAQECASMEEQgBATcBDwsYAgImAgJWB?=
 =?us-ascii?q?hUBAYJ+giMBAQQlJwO5dHp/M4EBggwBAQbcNYFrCRWBCi6IYgGGFIRiJxuCD?=
 =?us-ascii?q?YE8gwU+hT+CYIJqgiaBDIFyZJYHUngcA1ksAVUTFwsHBWBFQwOBBiNLBS0dg?=
 =?us-ascii?q?SM7FxEeWBsGBRIgKkBDW4ESgQNdgSsoXQECH0YtFYF2AoJRgSMCWwIBSUEOB?=
 =?us-ascii?q?0VTCSVDEkckIggSCQETGiwKgRo1PAkmPxUMWwwIAxoFGiYCHwgCCwIMdCgRE?=
 =?us-ascii?q?BMdHiQvBRomPhsKgQwnHx4bDgIfEAYIbT03CgsZBD2UYIMHEzxRAQpvBoEGR?=
 =?us-ascii?q?UeSfJAegTZri3iSVYJEhCuhYwYTL4QEjRSGSpMQLod9kF2jbTeFIQqBdSOBX?=
 =?us-ascii?q?DMaMEOCZ1ADGQ+OLg0JiHPJSCM1PQIHAgcOAwuFZ4w1gUwBAQ?=
IronPort-PHdr: A9a23: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
 GFGHOenJ1nWHpFUlBB2Ov9DmQ==
IronPort-Data: A9a23:nxLEH65OsC7ZqYF87DNyXAxRtNHDchMFZxGqfqrLsTDasY5as4F+v
 jZNXmzVaP2DYTD1ctp1PY20ph5Uv8DRz9UwHFFtqnpgEysa+MHILOrFEkqhZCn6wu/rHBs2t
 Z1GAjXjBJlpFSGE/k/F3pzJ9yQUOXSgH+KkYAL8EnkvA1ciFGF60UgLd9cR2uZAmcK+Dx6Gp
 eT8qsjePE7N8zNvOwr40YrawP9UlKq04mxwUmAWP6gR4gaHzihMVPrzGInoR5fGatkMdgKFb
 72bpF2J1jux1wsgDNqjjoH6fiUiKpbOPRKDg2ZhQKOrhB5PvEQais7X49JBAav/o2zhc+FZk
 L2hh7TpIesaFvSkdNAmbvVtO30W0ZtuqOaWeyDn2SCk5xaun3PEm52CBaytVGES0r4f7Wpmr
 JT0JN2RB/wqai3fLL+TE4FRasofwMbDMZotpFUw7RLlLOccY7LifqzNpvVK02Jl7ixONa62i
 8sxMWM0KhDJc1tKM1YTEpUjgOrugHTjG9FagAvE9Oxnsi6KilUvuFTuGIK9ltiiT9tcmE+Dv
 WnG8kzwCRRcM8aQodaA2ivy3bSVwHKhA+r+EpWbrvxgw1q3m1cdK1o6VES0rseBlmWXDoc3x
 0s8oXd08/NjrCRHVOLVWxSnqXqAlgwdXtBKGqs77huMw+za+W6xDW8PRT9pc80jrMZwRDow1
 1bPkcmBONB0mOXMEjSZ/6fSqDqzPTISMHMPIykJUWPp/uUPvqk+lyDRaoZDM5KUn+fXOxDNy
 jfJhjox0uB7YdEw60mtwbzQb9uRSnXhFlduoAHeTiSg5wJ9fom4e4Hu71XHhRqhEGp7ZgnY1
 JTns5LHhAzrMX1rvHDQKAnqNO31j8tpyBWG3TZS82AJrlxBAUJPgry8EBkleR03aZdcEdMYS
 FPTvgZY/9daejOoaq9xeIW3Q8swyrX4XdXjXba8U+eilqNZLVfdlAk3PBb49zm0zCAEz/plU
 b/FKpnEMJrvIfg8pNZAb7tGiedzrs3/rEuPLa3GI+OPi+rONSDME+tbbTNjrIkRtcu5nekcy
 P4HX+Pi9vmVeLeWjvD/qNZIdQI5PjIgCIroqsdaUOeGL0A0UCsiEvLdi/dpMYBsg60fxK+C8
 2CfS31o7gP1pUTGDgGWNVFlSrfkBqhkoVwBYCcDAFeP2loYW7iJ0psxTZUNQOQYxLRR9sIsF
 /ghUOecM8tLUQXCqmg8b4GijYlMdyaLpAOpPgikbD0RYq9QYR74oN/gRyTB9iM1UzS8sMA/h
 5aC1QrrZ4UJaCo/LcTRadOpl0iQu1pEks1MfkL4GPthU2Syz5pbcAnKke4RH8EADT7h1wmq/
 V+aLjlArNacvrJv1sfCgJ61iruAEsx8LxJ8JHba57PnDhvq1DOv7qEYWdnZYA2Hcn3//ZijQ
 uBnz/vcFvkjt3QSuqpeF4db944P1+HNlZR7kDs9RG7qam61AIxOOnOFhMlDlpNcz49j5DeZZ
 Bi9xcl4C56oZuXeD18jFCg0ZL+i1NYVuAXow9YbHUHY3BJzrZ27CRh8Hh/UkyFMDqpHAKV8y
 8cbhcMmwQieiB0rD9W4sh5p51m8dnwub4h3t7UxIpPatQ4w+1QTPb3eEnDX5b+MWfVtM24rA
 yCxuI/fjZtymm7HKno6Kmjc17Fj3aY15Q14/GYDA3+rmdP1oOA98zMM0DYwTyVTlg5m1cAqM
 EdVFkRFH4e81BY2u9pmQEaXBBBnOCCC307Ml2syi2zSSne3Wlz3LGESPfiH+GYb+Tl+egd30
 a65ymG/dxrXZ+D0gzUPXHB6p8zZTdBe8hPInOalFZ+nG7g4eT/Uvb+8V1EXqhfIAdIDu2Ofn
 LNEpN1PUKzcMTIch4YZCIPAjLQZd02iFVx4GPpk+PsEIHHYdDSMwgOxEkGWeP5WBvn04ES9W
 t1PJMVOakyE7xywjAsnXIwCH7wlu8QSxosmWqjqLms4obegvmJXkJbPxBPf2k4vYftTyPgYF
 K2AVgisMGKqgVlsp1Tst+hBY2qxXskFblbz3cez6+Q4KKgAu+BNL2A38OGFgCiVO1BB/Ru7g
 iryWInK6+kz2LZ9vpDNF59bDF6eMuLDV+Wv8SKYguRsNfLhA8fEtik/oQLBPQ15ALofYMt2n
 rKzq+zK3FvJkbI1cmLBkb+DHLltyeTre8QPKePxDn1RvRXaaf/W+xFZplyJc81You1S9uyMZ
 lWeavLpUfU3Rt0E5nleSxYGIiYnE66tM5vR/3Ksnc+tVCoY/xfMdu681HnTampeSC8EFrv+B
 iLwuNes/tpol5tNNjBVG8BZB4JEH3G7VZsEb9HRsRyqPlusiH6GuZrgkkMEwhPPAX+mDs37w
 MzkQj7TSReMg5zLnepp69FKgh4qDXhD2Lh6OgpX/tNtkDm1AVIXNelXY91MFphQlTe0z53iI
 i3EaGw5EyjmQDBYalPG7c/+WhuETPk7UjsjyufFI2vPA8t3OG+BPFel3n85uDFycyulyeimL
 csZ52H9eB683vmFgM4Ns+ejj74PKuzynxo1FYLVyqQewCryxZ0D33knGxBCPcACO9+Yj13Ff
 ADZWkgdKHxWiifN/QJIcnVQXhYDs1sDCtnugTinmL7ihmlQ8AGMJDAT9Q0+Pn3vofnm/IIze
 E4=
IronPort-HdrOrdr: A9a23:PeMMJqCr1R+RwgTlHemf55DYdb4zR+YMi2TDGXoBLSC9Afbo8f
 xG+85rryMc6QxhI03I/OrrBEDuexLhHPJOkPAs1PKZLXHbUQiTTL2Kj7GN/9SIIUSXnYIz6U
 4jSdkYNDSaNykZsS+V2njcLz9t+qjlzEl2v4rj80s=
X-Talos-CUID: 9a23:1+a2CGxLQ5phtpyVGrtoBgUZA/I7Vi3970vxMnWaK0dUQbrWY02frfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AXaT8ZgzZ+ezb4HqxHZEQkKIYFoiaqIf2CkpOlrF?=
 =?us-ascii?q?bgMencgBxJDiSsgyraaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,221,1787004000"; 
   d="scan'208";a="163325923"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGQoFD/sePdwy8IVH6fyi1NBMtG9jQE1GP6Ga?=
 =?us-ascii?q?uiRMexOOV2MA1jIsMzlajOBrvkk8DdR9djnDe4evw/LsMLQUnKN1qyus?=
 =?us-ascii?q?HjjhUntTf0fi924wDMBq/wCNzDNiSkbFGpLKUUlWhl32m15rq0wlvDUV?=
 =?us-ascii?q?4PPGkPWAkBSRkR0aetLAgacw=3D=3D?=
Received: from 013.lax.mailroute.net ([199.89.1.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:31:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jVs9h3R1WzlpJ4g;
	Thu, 19 Nov 2026 21:31:52 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oWxSVa8pN1fs; Thu, 19 Nov 2026 21:31:48 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:3bd4:4c06:4b28:5d89] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jVs9b6wHbzlfcVC;
	Thu, 19 Nov 2026 21:31:47 +0000 (UTC)
Message-ID: <591a87fb-042e-417c-b9bd-32e3b9cb645f@acm.org>
Date: Thu, 19 Nov 2026 13:31:47 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marco Elver <elver@google.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 cocci@inria.fr, kasan-dev@googlegroups.com
References: <20261119210807.211041-1-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261119210807.211041-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: locks: Add must_hold.cocci
Reply-To: Bart Van Assche <bvanassche@acm.org>
X-Loop: cocci@inria.fr
X-Sequence: 3816
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/FiyRrYdXuOuvwiercvQzrw>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 1:07 PM, Marco Elver wrote:
> Clang's context analysis treats lockdep_assert_held*() as an assumption
> that the lock is held. A function that asserts instead of being
> annotated with __must_hold() therefore passes the analysis, but its
> callers are never checked.
Hi Marco,

The LLM I asked for help with reviewing this patch provided the
following feedback (not sure all of this is correct):

 >   drivers/nvme/host/fabrics.c:650:1-20: nvmf_lookup_transport() 
asserts &nvmf_transports_rwsem is held but lacks 
__must_hold(&nvmf_transports_rwsem)

This suggestion is wrong. The only caller of nvmf_lookup_transport()
holds nvmf_transports_rwsem as a reader:

	down_read(&nvmf_transports_rwsem);
	ops = nvmf_lookup_transport(opts);

Hence, the correct annotation is __must_hold_shared() and adding
__must_hold() would trigger a new context analysis warning in the
caller. lockdep_assert_held() succeeds if a lock is held in any mode, so
for that macro the script cannot know which of the two annotations is
appropriate. How about reporting "lacks __must_hold() or
__must_hold_shared()" for lockdep_assert_held() and keeping the specific
suggestion for the _write() and _read() variants only?

 > +	# Attributes on a prototype in the same file.
 > +	for d in re.finditer(r'\b%s\s*\([^;{}]*\)([^;{}]*);' % re.escape(f),
 > +			     ''.join(lines)):
 > +		if '__must_hold' in d.group(1):
 > +			return None

It seems to me that this test never succeeds. '[^;{}]*\)' is greedy and
hence matches up to the last ')' before the semicolon. That is the
closing parenthesis of the attribute itself, so group 1 is empty:

 >>> import re
 >>> s = 'static int foo(struct x *x) __must_hold(&x->lock);'
 >>> re.search(r'\bfoo\s*\([^;{}]*\)([^;{}]*);', s).group(1)
''

The result is the same if the attribute occurs on the next line. I think
that this will cause functions that are only annotated on a forward
declaration to be reported. Testing d.group(0) instead of d.group(1)
would fix this. Additionally, should this test use the same attribute
list as the test above it (__releases*(), __context_unsafe(),
__no_context_analysis)?

 > +@r@
 > +identifier f;
 > +parameter list ps;
 > +expression E;
 > +position pf, p;
 > +@@
 > +
 > +f@pf(ps)
 > +{
 > +	...
 > +(
 > +	lockdep_assert_held@p(E);
 > +|
 > +	lockdep_assert_held_write@p(E);
 > +|
 > +	lockdep_assert_held_read@p(E);
 > +)
 > +	...
 > +}

Is my understanding correct that the default for a rule without
'-', '+' or '*' annotations is "exists" instead of "forall"? If so, this
rule also matches conditional assertions, e.g. this code from
fs/btrfs/backref.c:

	if (!current->journal_info)
		lockdep_assert_held(&fs_info->commit_root_sem);

__must_hold() would be wrong for such functions, and the above does not
match "assert on all paths" from the patch description nor
"unconditionally assert" from the comment at the top of the script.
Please consider specifying "forall" or "exists" explicitly.

Additionally, this rule matches functions that acquire E themselves
before asserting that it is held. Can these be excluded, e.g. with a
"when" constraint on the first "..."?

 > +	m = re.match(r'[&(]*(\w+)', e)
 > +	if not m:
 > +		return None
 > +	params = re.findall(r'(\w+)\s*(?:\[[^\]]*\]\s*)*(?:,|$)', str(ps))
 > +	if m.group(1) not in params and not re.fullmatch(r'&\w+', e):
 > +		return None	# Local alias: cannot be named in an attribute.

Only the first identifier of E is checked. Expressions like
&tbl->locks[idx] with 'tbl' a parameter and 'idx' a local variable are
reported although these cannot be used as an attribute argument. Would
it be possible to verify that all identifiers that occur in E are either
parameters or struct member names?

The 'params' regular expression does not extract the correct name for
all parameter declarations:

'void (*cb)(struct foo *), int n'    -> ['n']
'int (*fn)(void *data, int x)'       -> ['data']
'struct task_struct *p __maybe_unused' -> ['__maybe_unused']

Is there a way to let Coccinelle provide the parameter names instead of
extracting these with a regular expression?

 > +	static = 'static' in ''.join(lines[max(first - 3, 0):first])

This is a substring search across three lines, so e.g. a
"static int counter;" declaration two lines above a non-static function
suppresses the "check prototype" hint. Can 'static' be matched in the
SmPL rule instead?

Some further remarks:
- lockdep_assert_held_once() and assert_spin_locked() are not handled
   (71 respectively 256 occurrences in .c files in my tree), nor are
   wrappers like lockdep_assert_wiphy(). Please either add these or
   mention this in the "Limitations" section.
- Global locks are only recognized if E has the form "&name".
   Expressions like &init_mm.mmap_lock are skipped silently. That's fine
   with me but it is not mentioned in the comment at the top.
- The patch description mentions that functions with a __must_hold*()
   or __releases*() annotation are skipped. The script also skips
   functions annotated with __context_unsafe() or __no_context_analysis.

Thanks,

Bart.

