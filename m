Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E2DCE8E91
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XpzomdvtzFwd1GPBBH+8b4oH6sHjDhDsbCiKotMqtXA=;
  b=OQS+a8gzZpifNtqg2XMBvZrVmF+RbMyu8RjnLEZSTPWb3rsWwXIGew61
   ljeUzDtB8UdYVo9h27BpXhHLLRut0TkMz9X3YrPzUXMpOnCaBCtJAfsUx
   AU9ReYhYlUN+7ElYvPrYxiQPO1Deq9h95V1GJkGKNqt/NirXx6LKwT7z0
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190604073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 18:14:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 23C31E0D1D; Thu, 24 Oct 2024 18:14:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A4EA2E0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 18:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XpzomdvtzFwd1GPBBH+8b4oH6sHjDhDsbCiKotMqtXA=;
  b=avyr0TDdTtIQDM5jygYyZ/X+IJA1JVVTVG+yXYgVzDEgbSGhvZX0kpZ2
   jam/se4AxGNPxN/sYW0go6r7um9JRJ0sXDjNYglyCe51OHkB7TOLNU49E
   0wCJxtlJiWfpD8mmurZJFRWTCBO29j6fwI9o8hy2JAv0nAxk6YOCw48t7
   o=;
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190604058"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:14:50 +0200
Date: Thu, 24 Oct 2024 18:14:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
In-Reply-To: <95d1401a-bc19-4ed8-b6aa-389e2f6f4d04@web.de>
Message-ID: <alpine.DEB.2.22.394.2410241813390.3352@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien> <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien> <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk> <95d1401a-bc19-4ed8-b6aa-389e2f6f4d04@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1576221538-1729786490=:3352"
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1929
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410241813390.3352%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1576221538-1729786490=:3352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Oct 2024, Markus Elfring wrote:

> >> ... when exists
> >>      when any>
> >> might be faster than what you have now.  But it will still b slower than necessary.
> >
> > Just tried
> > ... when exists
> > on a couple of files that timed out after 600s.
> > The reported time was 0.209s, so it's a lot faster!
>
> Such an effect on the software run time characteristics is nice.
>
> Will a program parameter like “--no-loops” be also helpful another bit?

With the use of current_element_line, --no-loops is irrelevant.  The body
of the function is no matched at all when the position variable is at the
top of the function somewhere.

julia
--8323329-1576221538-1729786490=:3352--
