Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C4DCD5BD5
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gqeNTRdAtsDi7KeWi9+6mhQRPXP1jadiHbMjvOKNLPE=;
  b=IksQc5cxDlQkVNq/d9egXsMwPukjgjZy9j208bF3AvZCFQnaObGNRGMu
   mZ031JaGUcu3IDEp9BqFy1Yhqs00nWFq2cYW68xr148xb9mSwlUidxhku
   rZaxCdyvtdzjaWw0tu23+ZKXuil6wcaKK67eVXI+vzPUKrip/zeipN1Hb
   g=;
X-CSE-ConnectionGUID: AViAoPtjSFGplc+TBpwiSQ==
X-CSE-MsgGUID: Uwj9naEORbqr3my0OSAqqg==
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
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="278634269"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 10:45:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EC46280662; Thu, 28 May 2026 10:45:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3861180662
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 10:45:41 +0200 (CEST)
X-CSE-ConnectionGUID: jaT6hL2eR8KUMOtpRC2rYw==
X-CSE-MsgGUID: Sql/+6bwSOGncp0sQ3I8OA==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="278634245"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 10:45:41 +0200
Date: Thu, 28 May 2026 10:45:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <057100fc-0073-4d9c-86a7-1bae97714518@web.de>
Message-ID: <c5e8d349-ee3-d265-a5d1-302c59751f52@inria.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr> <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr> <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr> <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de> <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
 <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de> <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr> <ad06211-6441-9568-e643-c39df9bf8494@inria.fr> <186417e3-b2d4-4f1c-9790-8fd1b836e946@irisa.fr> <4221c671-682-68de-9a94-1634364b6685@inria.fr>
 <55aadd6c-42a5-4403-8978-87fb579b0df6@web.de> <e919c230-4996-43af-9a2c-ce025399d35e@irisa.fr> <041a14c-d1ee-7181-a617-82b4b294b6fa@inria.fr> <a60854fd-786b-4e34-9abe-474b56a37d97@web.de> <2960204-d8bc-a52a-42c3-507e9be4d7f2@inria.fr>
 <057100fc-0073-4d9c-86a7-1bae97714518@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-253907947-1779957941=:3598"
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3538
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/9R0vTdrRe0IsXQou1V5lkQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-253907947-1779957941=:3598
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 28 May 2026, Markus Elfring wrote:

> >> Under which circumstances would a function call like make_attribute()
> >> become better supported?
> >> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/1bff7651118fc65c269dd8dba7f7d4a30fbc72c7/docs/Coccilib.3cocci#L154-159
> > Probably when someone is motivated to implement it.  But there is no
> > motivation to implement it here.  The only goal is to put a metavariable
> > in a string.  We can fix the fresh identifier string problem, but since
> > python works well enough, that's also fine.
>
> * How “fresh” would corresponding data become?

If you give code for creating the name, it just creates the name that you
provide.

julia

>
> * Is it more desirable to provide extra source code anyhow
>   even if it would usually not fit to data requirements for identifiers?
>   https://en.cppreference.com/c/language/identifier
>
>
> How will development interests evolve further then?
>
> Regards,
> Markus
>
--8323329-253907947-1779957941=:3598--
