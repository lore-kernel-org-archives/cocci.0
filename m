Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3003D58D5A
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vYMU5EklBEYIkg1A6L+Fp3dI5VDyPVf2hxOiqzqT+fQ=;
  b=XYDSLMXBY1DpTPVAwY3/+wRuu9hdidY8/igh+V2WnYtSXrbS2J5WanBU
   kL+hwJADnS0Hus/St5q3bXRw0mCZqBm8RdFTH9b50hy900CWuOPU3g3Ik
   kYmEwrw0ZcFIGdvUXSOaDQuiXfUnPaMMyOkAc5A8J5PEt+ZWtUdjO1A6a
   0=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195705848"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 16:43:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D0720E00B6; Mon, 25 Nov 2024 16:43:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8668EE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 16:43:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=vYMU5EklBEYIkg1A6L+Fp3dI5VDyPVf2hxOiqzqT+fQ=;
  b=S2+qQiQom6+hfhti6AdmgTT4FD7CsmHjG1aNfnc4ce3PPqncmr857bP9
   nsy24m4JJrgnumdr21r+xt/khLiRaOOgyY0I9k5Tt9Ywua/AVtFNV5iT+
   1qae/vsfLsQqVuesAGO9IEz1Om9soJaX4epWgd9IASeL+NzcNzqOYaYs4
   s=;
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="102583240"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 16:42:59 +0100
Date: Mon, 25 Nov 2024 10:42:58 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
Message-ID: <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-949297622-1732549196=:3314"
Content-ID: <a0c56257-3645-52d4-d2b8-facb5b14728e@lip6.fr>
Subject: Re: [cocci] Reconsidering application of selected SmPL isomorphisms
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2099
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-949297622-1732549196=:3314
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <e7225a2f-f455-977b-6cd-5125dd64cb7e@lip6.fr>



On Mon, 25 Nov 2024, Markus Elfring wrote:

> Hello,
>
> I would like to clarify software development consequences also for
> a simple script variant for the semantic patch language (like the following).

The generated code indeed does not look ideal.  But it won't cause any
wrong matches.  The isomorphisms are applied on the ASTs, not on the soure
code.  So there will be a tree with a ! at the root and a || as the
argument that will not match any possible source code.

Maybe it would be better to add isomorphisms for the de Morgan laws rather
than adding some hacks into the generic isomorphism transformation to take
this issue into account.

julia

>
>
> @show_questionable_checks@
> expression e1, e2;
> statement s1, s2;
> @@
>  if
>  (
> *!(e1 || e2)
>  )
>     s1
>  else
>     s2
>
>
> Questionable test result:
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/janitor> spatch --parse-cocci show_questionable_OR_checks2.cocci
> …
> (
>
> (
>
> (
> if (*!*(*e1 *|| *e2*))
> |
> if (*!*e1 *|| *e2)
> )s1 else s2
> |
> …
>
>
> I would interpret such data display in the way that the isomorphism “paren”
> was applied here.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/04f71e76b0857ca12ec7207b26368df78d2b57d4/standard.iso#L389
>
> I find the shown SmPL code transformation inappropriate at this place.
> Would we like to apply De Morgan's laws instead?
> https://en.wikipedia.org/wiki/De_Morgan%27s_laws
>
> Would we like to reconsider the application of the isomorphism for the switching
> of if/else branches accordingly?
>
> Regards,
> Markus
>
--8323329-949297622-1732549196=:3314--
