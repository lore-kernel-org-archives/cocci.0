Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD96BC433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MVFna6OSXfUHeEERTymu8y2DZsou8yCteBoBpqdiOZE=;
  b=oPv1ghuLZymvM+D38hmfOzAfBhJED4RZq1ZauaMLTzhW3mzj+2iQn/za
   BAWKqQzK7H8a0KlIh82Se0RxCHjGYumKyiqkcOHFRHpKE0vfb3yP1DRdk
   bkeJs+1H9L4yGuCVuUv1GFajbkO/GlcWFKXEbYD2k+TgQGz8zEgB2pMLH
   4=;
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
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680760"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:15:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1499FE02D5; Sun,  9 Oct 2022 17:15:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7842DE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MVFna6OSXfUHeEERTymu8y2DZsou8yCteBoBpqdiOZE=;
  b=Thb7BmIVPQFm7mYgH5NIHlqYnkycJ8esHuRKLzsMCAJss6kesA2XNdP1
   2msxDqiU0/ZGJuwY9FbqD39lub6HRkRXkbI89Hdjd46h3XNoq0unJ722w
   /9VrtICC5MT74tU2TKMwb/SEwy5Kz2cuCCqb6G8BWKNbDRUFuElXwBWgt
   0=;
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="25889990"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:15:19 +0200
Date: Sun, 9 Oct 2022 17:15:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: cocci@inria.fr, keescook@chromium.org
In-Reply-To: <Y0LiyBxZ0pU+NOPR@zx2c4.com>
Message-ID: <alpine.DEB.2.22.394.2210091713270.3091@hadrien>
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 627
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210091713270.3091%40hadrien>



On Sun, 9 Oct 2022, Jason A. Donenfeld wrote:

> Hi,
>
> I've got a fairly simple rule that works on easy contrived examples:
>
> @@
> identifier get_random_u32 =~ "get_random_int|prandom_u32|get_random_u32";
> typedef u16;
> identifier v;
> @@
>    u16 v;
>    ... when exists
> -  v = get_random_u32();
> +  v = get_random_u16();
>
> However, when I try to apply it to a real function, afixed below, I get
> the error:
>
>     rule starting on line 1: node 172: off = ... ;[1,2,67,68,70] in nf_nat_l4proto_unique_tuple reachable by inconsistent control-flow paths
>
> I tried using the option "--allow-inconsistent-paths", and it works, but
> that also seems potentially scary. I figure if it's not on by default,
> it must be for a good reason. Any idea what's up here?

The meaning of the message is that Coccinelle thinks that it is possible
to get to the call that you have changed without going through the u16 v
declaration.

I'll check on your function and try to figure out why the message is
getting triggered.  It is indeed often not a good idea to use the
--allow-inconsistent-paths flag when making changes.

julia

>
> Thanks,
> Jason
>
> ---------------------------------------------------------------------
>
> static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
> 					const struct nf_nat_range2 *range,
> 					enum nf_nat_manip_type maniptype,
> 					const struct nf_conn *ct)
> {
> 	unsigned int range_size, min, max, i, attempts;
> 	__be16 *keyptr;
> 	u16 off;
> 	static const unsigned int max_attempts = 128;
>
> 	switch (tuple->dst.protonum) {
> 	case IPPROTO_ICMP:
> 	case IPPROTO_ICMPV6:
> 		/* id is same for either direction... */
> 		keyptr = &tuple->src.u.icmp.id;
> 		if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
> 			min = 0;
> 			range_size = 65536;
> 		} else {
> 			min = ntohs(range->min_proto.icmp.id);
> 			range_size = ntohs(range->max_proto.icmp.id) -
> 				     ntohs(range->min_proto.icmp.id) + 1;
> 		}
> 		goto find_free_id;
> #if IS_ENABLED(CONFIG_NF_CT_PROTO_GRE)
> 	case IPPROTO_GRE:
> 		/* If there is no master conntrack we are not PPTP,
> 		   do not change tuples */
> 		if (!ct->master)
> 			return;
>
> 		if (maniptype == NF_NAT_MANIP_SRC)
> 			keyptr = &tuple->src.u.gre.key;
> 		else
> 			keyptr = &tuple->dst.u.gre.key;
>
> 		if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
> 			min = 1;
> 			range_size = 65535;
> 		} else {
> 			min = ntohs(range->min_proto.gre.key);
> 			range_size = ntohs(range->max_proto.gre.key) - min + 1;
> 		}
> 		goto find_free_id;
> #endif
> 	case IPPROTO_UDP:
> 	case IPPROTO_UDPLITE:
> 	case IPPROTO_TCP:
> 	case IPPROTO_SCTP:
> 	case IPPROTO_DCCP:
> 		if (maniptype == NF_NAT_MANIP_SRC)
> 			keyptr = &tuple->src.u.all;
> 		else
> 			keyptr = &tuple->dst.u.all;
>
> 		break;
> 	default:
> 		return;
> 	}
>
> 	/* If no range specified... */
> 	if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
> 		/* If it's dst rewrite, can't change port */
> 		if (maniptype == NF_NAT_MANIP_DST)
> 			return;
>
> 		if (ntohs(*keyptr) < 1024) {
> 			/* Loose convention: >> 512 is credential passing */
> 			if (ntohs(*keyptr) < 512) {
> 				min = 1;
> 				range_size = 511 - min + 1;
> 			} else {
> 				min = 600;
> 				range_size = 1023 - min + 1;
> 			}
> 		} else {
> 			min = 1024;
> 			range_size = 65535 - 1024 + 1;
> 		}
> 	} else {
> 		min = ntohs(range->min_proto.all);
> 		max = ntohs(range->max_proto.all);
> 		if (unlikely(max < min))
> 			swap(max, min);
> 		range_size = max - min + 1;
> 	}
>
> find_free_id:
> 	if (range->flags & NF_NAT_RANGE_PROTO_OFFSET)
> 		off = (ntohs(*keyptr) - ntohs(range->base_proto.all));
> 	else
> 		off = prandom_u32();
>
> 	attempts = range_size;
> 	if (attempts > max_attempts)
> 		attempts = max_attempts;
>
> 	/* We are in softirq; doing a search of the entire range risks
> 	 * soft lockup when all tuples are already used.
> 	 *
> 	 * If we can't find any free port from first offset, pick a new
> 	 * one and try again, with ever smaller search window.
> 	 */
> another_round:
> 	for (i = 0; i < attempts; i++, off++) {
> 		*keyptr = htons(min + off % range_size);
> 		if (!nf_nat_used_tuple(tuple, ct))
> 			return;
> 	}
>
> 	if (attempts >= range_size || attempts < 16)
> 		return;
> 	attempts /= 2;
> 	off = prandom_u32();
> 	goto another_round;
> }
>
