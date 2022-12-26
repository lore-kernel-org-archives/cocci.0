Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7979C3DA79
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xSS+tv7TFJ5qkY2uub6cFPRWskCUQkOl6n2G2IsTaPE=;
  b=ME59pFJ5BC045XkmTTg5qBX6q1+l9PPQVoXNBkoM+9gKdDBQsYRX7yBr
   /wUTJYKPj5gw+0NuU9ZnEVy1pjrjdjBk1yONg+cqF3OqK5ZoZ0/Ipq6IU
   9482zwJcEoV9N62sOuO+/2Y2R1C3pvmMM2xvqLiDclkEtpk/isTlxKnUU
   s=;
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
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85077541"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 12:20:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CCD10E0138; Mon, 26 Dec 2022 12:20:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B1143E0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 12:19:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xSS+tv7TFJ5qkY2uub6cFPRWskCUQkOl6n2G2IsTaPE=;
  b=uJWZFhlbYNwfFXBirW2pttBMpXF30iARR1xxttWBl8rlUzsYcorcsGuq
   s+Wrk6j+rdsfsj3jFUleNrCjRbg2D6VLwJ0tjARh6EqcwSVkQibIe57yH
   80Ou5szGgcNgMI+YvVegvcsK9XS7BQwOgWpaRGhxHsjzYIyq/3f4Ekt4U
   c=;
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85077514"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 12:19:58 +0100
Date: Mon, 26 Dec 2022 12:19:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
Message-ID: <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de> <alpine.DEB.2.22.394.2212260740380.2980@hadrien> <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1119086421-1672053597=:3850"
Subject: Re: [cocci] Transforming source code according to the usage of a
 predicate
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 790
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/9fcc50af-da1a-6d71-934-b87d383ed38c%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1119086421-1672053597=:3850
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> > Don't you want something like
> >
> > expression list e1,e2;
> >
> > and then call(e1,active,e2)
>
>
> Does the specification of this metavariable type indicate the expectation
> that the applied metavariables will receive contents?

No, it should not.  Lists can be empty.

julia

> The boolean value can occasionally occur also between other parameters.
>
>
> Branch (or compound) isomorphisms are supported to some degree.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/standard.iso#L492
>
> It seems that I am looking also for further software evolution according to
> the comment “maybe a cocci patch should require something that looks like
> what is on the left above to occur in a if or while”.
>
> Regards,
> Markus
>
>
--8323329-1119086421-1672053597=:3850--
