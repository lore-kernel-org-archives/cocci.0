Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5194CD58D5E
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=l2lEtnBPGSzjvI0OH5NXXf/M4Nb412WP+3MmC8S9ONI=;
  b=XB5vShz0+JKo8WVpyPPP90/7s7UNqS/WIv5xxYIqoZ6rSQIHTXMQNMlD
   o2BD8ZswWukZ6k2tO1HXp7h71+PaC/ZN9D6AkGaqr9h04wiGCDIXxfZBO
   UHDVaEoYSQPMJu2ZbR8Bph8K671OdEtDbgaSzDv9E+EqWjs7QfC0ZsRmd
   Y=;
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
   d="scan'208";a="195704564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 16:37:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6981E0D1E; Mon, 25 Nov 2024 16:37:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 30E2DE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 16:37:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l2lEtnBPGSzjvI0OH5NXXf/M4Nb412WP+3MmC8S9ONI=;
  b=DwO7MBZG0Oe0YB1z1CFxC13EsAnJplv02wayMb9QOUelafouoy6CSMP0
   72z7L818YUxRi4XExnlMsL0pMs2eRus4f5K/gdxqK8x85Zg/BbZiJN8C9
   RdYTZja2B9fVJxRwDqULj2fcbT/sr6AjpMi3m+OtCqcb8oBtxI7HtU30m
   o=;
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195704560"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 16:37:44 +0100
Date: Mon, 25 Nov 2024 10:37:43 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
Message-ID: <efec9984-4eee-4c75-76ce-e6bd27442daa@inria.fr>
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1204425276-1732549065=:3314"
Subject: Re: [cocci] Reconsidering application of selected SmPL isomorphisms
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2098
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/efec9984-4eee-4c75-76ce-e6bd27442daa%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1204425276-1732549065=:3314
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 25 Nov 2024, Markus Elfring wrote:

> Hello,
>
> I would like to clarify software development consequences also for
> a simple script variant for the semantic patch language (like the following).
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

Indeed, it looks wrong.

Thanks for the report.

julia
--8323329-1204425276-1732549065=:3314--
