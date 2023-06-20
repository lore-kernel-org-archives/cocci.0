Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF91EB64D7
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 07:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=EsrlQGQZGtejxiRlP50skqMTe6/ev4An9kqefbnLyVs=;
  b=Po2lemJXPsJpM4akEeEHJJKxEYlBK230CbOHYHZl6vwXJSbjtK0SB3Hr
   SRySRPZCz/xw85EsT9X55wn9IczfKcCR7/NHUgwOsZesTavPmwJ3MOLm1
   YgfgiK5a86L3w80iz7WPsDpPnbZBk8sJsxHCeZWqEfUSVl9/0mKBruOyt
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,256,1681164000"; 
   d="scan'208";a="113683995"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 09:01:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 92C24E0157; Tue, 20 Jun 2023 09:01:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 696F7E03AB
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 09:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EsrlQGQZGtejxiRlP50skqMTe6/ev4An9kqefbnLyVs=;
  b=qD0hXZ+XjLLLYhBncIhwUjTFdzLdhVmEG9Q/zdWBiAMovHnUjHuV5SkO
   5lZgSzPvKNiZlACPdHZm6p6uISF1byjfxhpR8Ub0rkug1B61W5zIkBsdp
   OF2p49a/lsdkkwnOJiu4rXMfUSAs8KeJEyWdgPAx6+bCeZ94hjzmDVa93
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,256,1681164000"; 
   d="scan'208";a="59198242"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:01:28 +0200
Date: Tue, 20 Jun 2023 09:01:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
Message-ID: <b914282b-799c-cbd8-a381-da8d2d3b97b6@inria.fr>
References: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Strange spatch behavior while patching an array of
 structs
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1198
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/b914282b-799c-cbd8-a381-da8d2d3b97b6%40inria.fr>



On Mon, 19 Jun 2023, Eric Wheeler wrote:

> Hello all,
>
> I ran the following .cocci spatch on the code below (which is a minimum
> excerpt from [1] for the project [2]) and was surprised by the results. If
> I understand .cocci (and perhaps this is my misunderstanding) then I would
> expect the patch _not_ to apply here at all.
>
> Here is my spatch version:
> 	spatch version 1.1.1-00106-ge65a6dd compiled with OCaml version 4.05.0
> 	Flags passed to the configure script: --prefix=/usr/local/coccinelle-git/
> 	OCaml scripting support: yes
> 	Python scripting support: yes
> 	Syntax of regular expressions: PCRE
>
> Please see my question at the bottom.  Here are the relevant bits of code:
>
> -- t.c ------------------------------------------------------------------------------
> #include <stdio.h>
>
> struct rotor {
> 	struct motor {
> 		char *name;
> 	} motor;
>
> 	struct cal {
> 		float deg, v;
> 	} cal[90];
>
> } rotors[4] =
> 	{
> 		{ .motor = { .name = "foo1" }, .cal = {{ .deg = 0, .v = 1 }, { .deg = 360, .v = 2 }} },
> 		{ .motor = { .name = "foo2" }, .cal = {{ .deg = 0, .v = 2 }, { .deg = 360, .v = 5 }} },
> 		{ .motor = { .name = "foo3" }, .cal = {{ .deg = 0, .v = 4 }, { .deg = 360, .v = 9 }} },
> 		{ .motor = { .name = "foo4" }, .cal = {{ .deg = 0, .v = 6 }, { .deg = 360, .v = 12 }} },
> 	};
>
> int main()
> {
> 	int i;
> 	for (i = 0; i < 4; i++)
> 	{
> 		printf("%s cal: [%.2f, %.2f] deg = [%.2f, %.2f] volts, %.4f mV/deg\r\n",
> 			rotors[i].motor.name,
> 			rotors[i].cal[0].deg, rotors[i].cal[1].deg,
> 			rotors[i].cal[0].v, rotors[i].cal[1].v,
> 			(rotors[i].cal[1].v - rotors[i].cal[0].v) / (rotors[i].cal[1].deg - rotors[i].cal[0].deg) * 1000
> 			);
> 	}
> }
> -------------------------------------------------------------------------------------
>
> -- cal.spatch -----------------------------------------------------------------------
> @@
> identifier R, X;
> @@
>
> -R->cal[0].X
> +rotor_cal_min(R)->X
> -------------------------------------------------------------------------------------
>
> -- output ---------------------------------------------------------------------------
> ]$ spatch --sp-file cal.spatch t.c
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> HANDLING: t.c
> diff =
> --- t.c
> +++ /tmp/cocci-output-452476-33c7f6-t.c
> @@ -24,9 +24,9 @@ int main()
>  	{
>  		printf("%s cal: [%.2f, %.2f] deg = [%.2f, %.2f] volts, %.4f mV/deg\r\n",
>  			rotors[i].motor.name,
> -			rotors[i].cal[0].deg, rotors[i].cal[1].deg,
> -			rotors[i].cal[0].v, rotors[i].cal[1].v,
> -			(rotors[i].cal[1].v - rotors[i].cal[0].v) / (rotors[i].cal[1].deg - rotors[i].cal[0].deg) * 1000
> +			rotor_cal_min(rotors)->deg, rotors[i].cal[1].deg,
> +			rotor_cal_min(rotors)->v, rotors[i].cal[1].v,
> +			(rotors[i].cal[1].v - rotor_cal_min(rotors)->v) / (rotors[i].cal[1].deg - rotor_cal_min(rotors)->deg) * 1000
>  			);
>  	}
>  }
> -------------------------------------------------------------------------------------
>
>
> Question:
>
> Why did spatch match R in "R->cal[0].X" as "rotors" and drop the array
> index "[i]" all together to replace as follows?
>
> 	-rotors[i].cal[0].deg
> 	+rotor_cal_min(rotors)->deg
>
> Note that the spatch specifies "R->" , not "R." nor even "R[n]." ; it is
> as though spatch interpreted it as follows:
> 	-R[n].cal[0].X
> 	+rotor_cal_min(R)->X
>
> ...so for some reason it picked up "rotors[i]" as "R" and replaced it with
> just "rotors"...which, is indeed a pointer, but looses the meaning as
> being a pointer to the beginning of the array indexed by "[i]".
>
> I am confused as to why it matched "rotors[i].cal" at all. It should not
> have matched "rotors[i]" at all, right?
>
> Is this a bug, or an error in my understanding of SML?

This is due to an isomorphism, that is apparently not as good an idea as
it first seemed.

Put between the initial @@ of your rule:

disable ptr_to_array

julia

>
> References:
>
> [1] https://github.com/KJ7NLL/space-ham/blob/master/main.c
> [2] "Track the Space Station and OreSat Satellites with a LEGO Rotor..."
> 	https://www.youtube.com/watch?v=vrlw4QPKMRY
>
> --
> Eric Wheeler
>
