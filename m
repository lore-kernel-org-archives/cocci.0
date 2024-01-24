Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3ACC46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=G6kESTmdvnhgFDNfjdocoB7ZKjyx6piI1kPhWo+JFAo=;
  b=Z5u5e5H1UFEnCPlaNEd3jZkwCmMJPjlKeftv0d104VK+/qdJ5jKVqHR0
   xRK9QW00AKJ1FhTp04in5Gede6BmktT3ISAMYuREMM18e0UIZNktFAPjx
   3t/OjksTExIRfqKZYLQMuc6Bx0PYPt1QoNAhRfebLcFrrlQoJA72lorPJ
   o=;
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
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148476281"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 21:26:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E84FE0CD7; Wed, 24 Jan 2024 21:26:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5C7DE0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 21:26:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G6kESTmdvnhgFDNfjdocoB7ZKjyx6piI1kPhWo+JFAo=;
  b=vq7I1DHFRG5kzq1D3GmCiLjRdAniVGctW9qtfdrLJ1wqwPdeu+Z4so/+
   /6IOi4qQGlGDzsoRRoYDrX7Vgb7JAotLDYypsnEkdgQrXstZ3uy4wbQwh
   Xlz7FHam7ZT+0xessJzKzERwUAwvs3Azcmms8SJATnbr/0seOoUnILBiN
   w=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148476279"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 21:26:24 +0100
Date: Wed, 24 Jan 2024 21:26:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d74c2c33-e64c-4f91-baf2-20a4f31b925b@web.de>
Message-ID: <alpine.DEB.2.22.394.2401242126120.6377@hadrien>
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de> <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr> <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de> <297bf3e1-8262-a599-20ff-dc8086d5b87a@inria.fr> <c41c9f8e-acdd-4e04-8c2a-8f1589e50785@web.de>
 <fcfa187e-5dbd-177d-bcf3-fd42c8b6bd46@inria.fr> <d74c2c33-e64c-4f91-baf2-20a4f31b925b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1484
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401242126120.6377%40hadrien>



On Wed, 24 Jan 2024, Markus Elfring wrote:

> >> Why would such a technical aspect influence the identifier selection
> >> within the name space of a rule for the semantic patch language?
> >
> > Because or is now a keyword, and we don't allow keywords as rule names.
> > You can't have if or while as a rule name either.
> >
> > Perhaps it could be fixed, but that is the explanation.
>
> With which commit was the observed restriction introduced?

Probably e9facdc383d75bc2910762d166810ea6f858e8e5

julia

>
> Regards,
> Markus
>
