Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7556DCD5BC8
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ClULMcFOYOUC7qJwwXP8L7/mLpm8rnCdJ2w+acPVKN0=;
  b=J6SAICIRCUvv68/p2rf4EZCE3zw683whZFno7Mkju6uwfi9R0n6cAMis
   c/OCbdw3ibSdTeZxH59/bmbp8kb2YRwmXsSnqDslqrbCIczLAzsrVK3+p
   /tH1cPrm/gEgB6hTojLQhCB2qxVBrsytW7KwMuWyd8IdtBZ6gNsf/GuJ9
   I=;
X-CSE-ConnectionGUID: 21/E21ZPSB2KE+Jx1Hi0Ow==
X-CSE-MsgGUID: f96zvi9TQCuqWCEx0dkgiA==
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
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278219130"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 12:08:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4F3D886331; Tue, 26 May 2026 12:08:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 07D9680E9E
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 12:08:32 +0200 (CEST)
X-CSE-ConnectionGUID: /nma096nSW63gP7IQZiQ/Q==
X-CSE-MsgGUID: EzUs8pE9THeJenb6O3gRaw==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="147576593"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 12:08:32 +0200
Date: Tue, 26 May 2026 12:08:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Pierrick Philippe <pierrick.philippe@irisa.fr>
cc: cocci@inria.fr
In-Reply-To: <53174e21-5014-40b5-a271-b2d43cb5bc50@irisa.fr>
Message-ID: <eaecc52f-96ea-6cd4-e321-e19eae497f16@inria.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr> <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr> <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr> <3d3ef8b5-cbb-8d68-e167-21bfab4fcc65@inria.fr> <53174e21-5014-40b5-a271-b2d43cb5bc50@irisa.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Question regarding Coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3523
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/OXB4RirZ53xbHkNkcvc16g>



On Tue, 26 May 2026, Pierrick Philippe wrote:

> On 5/26/26 11:00, Julia Lawall wrote:
>
> On Tue, 26 May 2026, Pierrick Philippe wrote:
>
> I think I understand, also I do have a question regarding the `declaration` keyword of the grammar.
> Is there any way to access inner information of the declaration? Such as the type or the presence of an initializer or not?
> For example in a python or a ocaml script?
>
>
> Not sure what you mean.  There is a metavariable of type declaration taht
> will take the whole declaration at once.  If you also want the pieces you
> can write:
>
> (
> d
> &
> T x = ...; // matches the case with and without an initializer
> )
>
> This is exactly what I meant, thank you.
> Though it confuses me why the `...` operator works here but not in the `memcmp` call statement.

Here it matches a complete expression.  You hoped it would map "x =" (I
don't remember the exact code) which is not a non terminal in the
language.

julia
