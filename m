Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC49EC3DA49
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XEx0RallWLhNW9/h/NUbC4EEBtwyty/OfJOFWVfVgEM=;
  b=NbJog3SIh8AdEG8+DUp/0K7wG/6+AcxDiBvwGpDjkjmnP75QZFlVVYFz
   LD++458W8Vd2UavLlQvVQJdinnmuO2Tod7HMp35k+UrYAPU3b+8KK9dwk
   zV2hWX5AQR9dBvAOQoMOxbEBgduw8Q9mWbZO93rBu0R5PiyKK20ecquP2
   8=;
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177107302"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 15:19:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC29CE0133; Fri, 26 Jul 2024 15:19:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C44F8E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 15:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XEx0RallWLhNW9/h/NUbC4EEBtwyty/OfJOFWVfVgEM=;
  b=ZRJhlE6Oa/b74jpEzNObUq9ZL0qyTOE4ejAnXFlWcxqW3KzrCKwAaXYH
   rMkR5kCNYelXLPJKl3G3fCH44NLQ3ULJNtEvcQ341efZuzDxvMiMIQMFv
   mNeSeTzyqvGDqO78JynlFRmWjsQXg7AIJDI+VgWfmQu2cLd4z/eaUXMiB
   M=;
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="93027788"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:19:14 +0200
Date: Fri, 26 Jul 2024 15:19:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
Message-ID: <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-731414342-1721999953=:3356"
Subject: Re: [cocci] How to fix a parse error for another SmPL script?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1815
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/1584412e-94b-4c10-6f96-9da68f4ed1d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-731414342-1721999953=:3356
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 26 Jul 2024, Markus Elfring wrote:

> Hello,
>
> A simple source code transformation was demonstrated.
> https://lore.kernel.org/all/?q=convert%20comma%20to%20semicolon
>
> Concrete patch example:
> https://lore.kernel.org/linux-kernel/20240724020721.2389738-1-nichen@iscas.ac.cn/
>
> Thus I constructed another tiny script variant for the semantic patch language.
>
>
> @adjustment@
> assignment operator ao;
> expression e, ex, te, tex;
> @@
>  <+...
>  te ao e
> -,
> +;
>  ...+>
>  tex ao ex;

The above semantic patch does not parse because te ao e, is not a valid C
term.  There is no term in the C language that ends with a comma.

julia

>
>
> I stumbled on undesirable behaviour once more also with the software
> combination “Coccinelle 1.2-00038-g2297fc0f”.
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci convert_comma_to_semicolon.cocci
> …
> minus: parse error:
>   File "convert_comma_to_semicolon.cocci", line 9, column 1, charpos = 90
>   around = '...+>',
>   whole content =  ...+>
>
>
> See also:
> Get the non-optional nest construct completely working for SmPL
> 2017-08-18
> https://github.com/coccinelle/coccinelle/issues/114
>
> How can corresponding software components be improved?
>
> Regards,
> Markus
>
--8323329-731414342-1721999953=:3356--
