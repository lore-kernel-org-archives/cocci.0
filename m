Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE0AC77B7C
	for <cocci@archiver.kernel.org>; Thu,  3 Jul 2025 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0vpyMMvfNpKkHLYeiDJ3tdzTTt2wZcrs1+VGqR4ajAo=;
  b=dnwi7XzTjMejDzucBOJW+9p82KOM2z7ouVS2qmzK1SEBw5N4Y77rZ2qu
   PF426iBFfcBVy3loNKGLhKak2NAnK+gSpWbk0rBvUenV9vF0gWgxddQJD
   qqfEBkCFdQpyDMQMJgH7IfeVcwt0caugnw+PJpuUIaK8bchQ+095jiAsY
   4=;
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
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230149859"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2025 12:23:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 777D9E0AF1; Thu,  3 Jul 2025 12:23:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 885EFE0131
	for <cocci@sympa.inria.fr>; Thu,  3 Jul 2025 12:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0vpyMMvfNpKkHLYeiDJ3tdzTTt2wZcrs1+VGqR4ajAo=;
  b=aAZldkrm7TzVBvJ4KEw5FFjsOFz038v9iXiDt9gw6cpFqlkzyAJo/Rg8
   a/u2sC0OCETwI0dXooZbsIIFxO0jqFOG95xz0o6tBIA49ABPtJRiUw/3S
   clAFH078id01jayTrS33i451uWsiSe0PahiaTRq6XBNASMkJ0cDkfYy1X
   s=;
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230149857"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:23:29 +0200
Date: Thu, 3 Jul 2025 12:23:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <ab0209a9-fbf7-4bd8-ae78-d6fb337ee294@web.de>
Message-ID: <44735e62-2ed6-730-6ab3-b2251d8b6723@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de> <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr> <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de> <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de> <8a69338-c049-cce1-2d66-a9607c175270@inria.fr> <ab0209a9-fbf7-4bd8-ae78-d6fb337ee294@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using statement list combinations?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2849
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/44735e62-2ed6-730-6ab3-b2251d8b6723%40inria.fr>



On Thu, 3 Jul 2025, Markus Elfring wrote:

> > I see nothing unclear.  You can write { sl }.  You can't write S1 sl S2.
> Would you find an SmPL code variant (like the following) more reasonable?
>
> @display@
> statement header, footer;
> statement list sl;
> @@
> *header { sl } footer

I don't know what you expect it to match.

julia

>
>
> Regards,
> Markus
>
