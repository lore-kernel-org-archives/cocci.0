Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00C8C677F1
	for <cocci@archiver.kernel.org>; Mon, 16 Jan 2023 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=W1QRVJ2hGHY/3TQMy1EOa/d5mRmVAW8YpDOht/jWoqI=;
  b=tYP21HC34nZdqWfV0XCt5UMjfX4MW2KLGBPpAlN2esB6yZCuYCv3eok3
   3CiYyst97a3sUq8oP2IiMJUgqt9zh891GgA63fWib+2aU6sXdA+jCzMFy
   b9LNdhY/pwiii2EdiEpJAtf1me4K7GZyYG4aA6kBgcu7ypgS7bSzck9Hl
   U=;
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
X-IronPort-AV: E=Sophos;i="5.97,221,1669071600"; 
   d="scan'208";a="87902314"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jan 2023 18:33:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6CED8E0386; Mon, 16 Jan 2023 18:33:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DB334E016E
	for <cocci@sympa.inria.fr>; Mon, 16 Jan 2023 18:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W1QRVJ2hGHY/3TQMy1EOa/d5mRmVAW8YpDOht/jWoqI=;
  b=D+nUtkFk07RyYBKcTi7ABcTMA/3X6aW9nblB+fn1YN9ursQo/Vewhry6
   VigdywP1eT1Xi7dii2oBfNWA4bEb8nClGkdY0YQQxO/aoq1C3B3Ke1O9j
   sJAe1yd8p+L8oR9Vl7oHtg8ludkimvtNQRWOMNtgYJvNmimI8pwBKnVtf
   A=;
X-IronPort-AV: E=Sophos;i="5.97,221,1669071600"; 
   d="scan'208";a="45195937"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 18:33:54 +0100
Date: Mon, 16 Jan 2023 18:33:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <cd35c301-c1fc-80d2-c3b4-bf37a5dca522@web.de>
Message-ID: <7bc15f4-154b-bfb5-4ab5-869f32af50ff@inria.fr>
References: <cd35c301-c1fc-80d2-c3b4-bf37a5dca522@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1474852570-1673890433=:3862"
Subject: Re: [cocci] Adding function attributes with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 814
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/7bc15f4-154b-bfb5-4ab5-869f32af50ff%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1474852570-1673890433=:3862
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 16 Jan 2023, Markus Elfring wrote:

> Hello,
>
> I would occasionally like to adjust function attributes.
> https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Common-Function-Attributes.html
>
> Thus I have tried another tiny script variant out for the semantic patch language
> (according to the software combination “Coccinelle 1.1.1”).
>
>
> @addition@
> @@
>  int must_be_checked(...)
> +__attribute__ ((warn_unused_result))
>  ;
>
>
> Unfortunately, I stumbled on the following display.
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci add_warn_unused_result1.cocci
> …
> plus: parse error:
>   File "add_warn_unused_result1.cocci", line 4, column 1, charpos = 41
>   around = '__attribute__',
>   whole content = +__attribute__ ((warn_unused_result))
>
>
> Can the software tool be extended accordingly?

Work on attributes is in progress.

julia
--8323329-1474852570-1673890433=:3862--
