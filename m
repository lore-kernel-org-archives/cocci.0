Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33033CA5FDD
	for <cocci@archiver.kernel.org>; Sat,  3 Oct 2026 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9SeOqRZ0SurN4c+gGJYTh2cCS5z0Y4722IUCMZBJAvU=;
  b=ne7UMyqLa1GHpq/bpnkNHMZP2zC7YDD1cR8vuLKSOBSqjMGXP6xRB/rC
   6Vs+aEe3jZZbafJ1NS1HChJ8BYrLZS5mja8BXT5+N5r4MWwTQ9JyM6C7I
   ijP2ROm0UF5Xcf2WKtLMiahZH8eOYuHdVcgKDhxHs9j8DTSksHizml56K
   Q=;
X-CSE-ConnectionGUID: /ZlFtkAJT8iKkamX5vomVA==
X-CSE-MsgGUID: FX3mm13pS+6+SCXbureP/g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,138,1787004000"; 
   d="scan'208";a="298319354"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2026 15:02:55 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DA6B3802AE; Sat,  3 Oct 2026 15:02:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6D0FC80257
	for <cocci@sympa.inria.fr>; Sat,  3 Oct 2026 15:02:48 +0200 (CEST)
X-CSE-ConnectionGUID: WCXedG9kQ029bdePvR3/bA==
X-CSE-MsgGUID: HIWZ1+kvShizImcl4qSoXA==
X-IronPort-AV: E=Sophos;i="6.27,138,1787004000"; 
   d="scan'208";a="298319339"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 15:02:48 +0200
Date: Sat, 3 Oct 2026 15:02:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <4f1e88cb-0332-4a29-85e9-373f9565752b@web.de>
Message-ID: <8435614-20eb-55dc-871e-fc51985977c9@inria.fr>
References: <82ac5de1-a9d0-497e-88c2-c10793819ea2@web.de> <4f1e88cb-0332-4a29-85e9-373f9565752b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1815302009-1791032568=:103150"
Subject: Re: [cocci] Reconsidering handling of generated metavariables for
 SmPL isomorphisms
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3747
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/L_4j39czCnsQ1jq5KmV32Q>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1815302009-1791032568=:103150
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 3 Oct 2026, Markus Elfring wrote:

> …
> > Transformed SmPL code may refer to additional metavariables which do not occur
> > in the input code.
> > It seems that the Coccinelle software generates metavariables then with
> > special identifiers.
> > The isomorphism rule “ptr_to_array” can be a special test case.
> > https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2759351ca12bbf39dc72c6756282294aa85d06f6/standard.iso#L557-566
> >
> > How can further technical details be determined for involved algorithms?
>
> Can further users (of the Coccinelle software) become interested in clarifications
> of involved technical details?
>
> I assume that known clarification attempts need to be repeated occasionally.
> https://github.com/coccinelle/coccinelle/issues/426#issuecomment-5700821358
>
> Corresponding SmPL script example:
> // See also:
> // cec_is_switch()
> // https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/cec.h#L1189-L1199
> @reduced_display2@
> identifier las;
> @@
> *! ( las -> flags & CEC_LOG_ADDRS_FL_CDC_ONLY )
>
>
> Questionable test result (also according to the software combination “Coccinelle 1.3.3”):
> Markus_Elfring@Sonne:~> spatch --parse-cocci /home/altes_Heim2/elfring/Projekte/Linux/show_cec_is_switch-reduced2.cocci | grep 'expression _' | wc -l
> …
> 236

How about just looking at the output of pase-cocci, looking at
standard.iso, figureout out what isomorphims are being applied that are
undesirable in your case, and disabling them?  Instead of asking the same
question over and over.

The isomorphism language is a bit simple and has the goal of being
readable.  It is not perfect in all cases.

julia


>
>
> Would you ever like to avoid duplicate data any more?
> avoid duplicates in disjunctions
> 2025-11-23
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/5bf4aac3af21712638005c0f4e225fb37c2fd70f
> https://github.com/coccinelle/coccinelle/commit/5bf4aac3af21712638005c0f4e225fb37c2fd70f
>
> Regards,
> Markus
>
--8323329-1815302009-1791032568=:103150--
