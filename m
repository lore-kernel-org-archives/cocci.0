Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABD5C61DB9
	for <cocci@archiver.kernel.org>; Tue, 25 Aug 2026 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=juDZJdXK9BJcZmlFu1fI0FcJ4GFAsj5fj+Sz6z8X0pQ=;
  b=l1C8u4L5kdqML258VF6txSDGdDfx6zKEg0ge8ZRsskcH92s/k/HnuCyA
   gwolp8ESx0INhXjRthJojwb40q6i7qyojopesoFrlkFqRE8ARUj5XoqRs
   EzmNDUQ9+s+cwEcoGZ6kaHAnKj2lsnc5v6K/zXpO+9gwUPKK4ClANi0O4
   o=;
X-CSE-ConnectionGUID: D8r2r007S5O8DBaPMsAmzA==
X-CSE-MsgGUID: J0DKZf2iR8qfajQ1LiudCA==
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
X-IronPort-AV: E=Sophos;i="6.25,243,1779141600"; 
   d="scan'208";a="291509355"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2026 18:40:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 760A281A6A; Tue, 25 Aug 2026 18:40:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D396380E5D
	for <cocci@sympa.inria.fr>; Tue, 25 Aug 2026 18:40:41 +0200 (CEST)
X-CSE-ConnectionGUID: qKV2PFzDTuSLv5fyQBlrxQ==
X-CSE-MsgGUID: jmTTtcFUSjSJZ7hRGtNX6g==
X-IronPort-AV: E=Sophos;i="6.25,243,1779141600"; 
   d="scan'208";a="291509342"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 18:40:41 +0200
Date: Tue, 25 Aug 2026 18:40:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5c799ed5-7f3b-4b24-bce6-05a4c5bf7bcc@web.de>
Message-ID: <16cb39e5-999b-aa-3123-3f45cfe44cdb@inria.fr>
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de> <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de> <5c799ed5-7f3b-4b24-bce6-05a4c5bf7bcc@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-197680120-1787676041=:18000"
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3710
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/czlsKUtN4jGps510mC6w6A>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-197680120-1787676041=:18000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 25 Aug 2026, Markus Elfring wrote:

> > Markus_Elfring@Sonne:~> /usr/bin/spatch --parse-cocci --sp '! 2' | sort | uniq -c -d
> > …
> >       3 *0 *== *2
> >       3 *!*2
> >       3 *2 *== *0
>
> Can a command like “`spatch --parse-cocci --sp '! 2' | sort | uniq -c -d`”
> trigger further test considerations according to Coccinelle 1.3.1 and 1.3.2?
>
> Questionable test result:
> …
>       5
>       3 @@
>       8 |

I have no idea what this means.

julia
--8323329-197680120-1787676041=:18000--
