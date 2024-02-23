Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F6C48BC4
	for <cocci@archiver.kernel.org>; Fri, 23 Feb 2024 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=viIIYYfD4DmEGDetdRUv8T8KCQpOkc575IJouF1R3bE=;
  b=ltX8gD0ZQyo8v0BWJDe9p8VAur0bc3zmxU22EmADIB0vDv8Gx40m9tyG
   9WVgHrd8BDuhwmvql5oKAKuC2eIJA/uzuitcC96GgVbcRVVfrmXrbuFRV
   dBerWJRpjtcpxlSIMzx3bvy9iNdOZt/0Scys33Y3IzL5V23AkRFEEFhhU
   E=;
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
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153407982"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2024 08:42:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3EBF9E0CD7; Fri, 23 Feb 2024 08:42:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BBF8E008A
	for <cocci@sympa.inria.fr>; Fri, 23 Feb 2024 08:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=viIIYYfD4DmEGDetdRUv8T8KCQpOkc575IJouF1R3bE=;
  b=bqsw6ZlNAmTTaoWe6KEXO/SmEnobJQVUPOxn+D6wDQ55UlD9d8lDNjVN
   sOph143iBgHMNz7qZDT/4MaYnvfGodPK+sHP9hhQDOig7HagVxzmJBsgi
   eLB9odtKAcS4XU+zGP602zDQjzW5UoPRyG4mEur+04aaklnm2Msf1orgy
   g=;
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="80412787"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:41:57 +0100
Date: Fri, 23 Feb 2024 08:41:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <784320f8-7731-47df-be6f-9ddc71c20d61@web.de>
Message-ID: <71f51659-e163-abfd-7f96-fb6f40e0117@inria.fr>
References: <784320f8-7731-47df-be6f-9ddc71c20d61@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-199744356-1708674117=:3400"
Subject: Re: [cocci] Using inherited input data for SmPL script rules?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1599
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/71f51659-e163-abfd-7f96-fb6f40e0117%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-199744356-1708674117=:3400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 23 Feb 2024, Markus Elfring wrote:

> Hello,
>
> I tried another script variant out for the semantic patch language
> also together with the software combination “Coccinelle 1.1.1-00739-g68c580f1”.
>
>
> @first_search@
> identifier id;
> @@
>  my_work(id);
>
> @second_search@
> identifier first_search.id;
> @@
>  my_log(id, ...);
>
> @script:python selection@
> x << second_search.id;
> @@
> if x == "apples":
>    cocci.include_match(False)
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci test-inherited_input_for_script_rule.cocci
> …
> scriptmeta: semantic error: bad rule second_search or bad variable id
>   File "test-inherited_input_for_script_rule.cocci", line 12, column 21, charpos = 161
>   around = ';',
>   whole content = x << second_search.id;

You should have inherited it from where it was defined, ie first_search.

julia

>
>
> Can the application of input data become supported for SmPL script rules
> even if such data would be inherited by longer SmPL rule chains?
>
> See also:
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/68c580f1f1abf9979d591371e5b2e474f97dac90/docs/manual/cocci_syntax.tex#L655
>
> Regards,
> Markus
>
--8323329-199744356-1708674117=:3400--
