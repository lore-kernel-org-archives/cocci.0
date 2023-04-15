Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042F4C7619A
	for <cocci@archiver.kernel.org>; Sat, 15 Apr 2023 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DItYEpfCo0aw6Z9YZjG5A8rFeueK/RFNuSW7f/RQjJQ=;
  b=NOtpQ6sWCcN8/rpg+Hgb+c/w4tq/tEjosVjd+uuAieu8qT2VhxEaLO6/
   ujf2mlqrTPw9HbIXZVr/JuE5dyvbimZMgoUloDDnma6ActGAGE7TE3TWN
   sYVXzGkQUMtdGhEDvCfs1laC+mLJGdvv2qAGEts38hfqy2eMVLVH5Hc5+
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208";a="103202855"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2023 09:31:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B63C6E033B; Sat, 15 Apr 2023 09:31:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1A253E00A8
	for <cocci@sympa.inria.fr>; Sat, 15 Apr 2023 09:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DItYEpfCo0aw6Z9YZjG5A8rFeueK/RFNuSW7f/RQjJQ=;
  b=YZPpmKXwMyxbqtx8Nk7Ff82Szu+Zwy+El6Rc2VQv8efyHZmkCt1GRQxC
   btinFxnnNWZcv/hlo4HOo0vFHhDDUJiGz6IxiunLfBe9DV72Aozr3wOAl
   S8+6NPN0gb77fb7RCireguaz74eQGlR2Oo7Wy/0VP9FekBK/UUn8xOeh3
   Y=;
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208";a="103202852"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 09:31:06 +0200
Date: Sat, 15 Apr 2023 09:31:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Yudi Yang <jy103@rice.edu>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <da277553-d798-4dd0-a0bb-f641f41a16bf@Spark>
Message-ID: <alpine.DEB.2.22.394.2304150930200.2975@hadrien>
References: <da277553-d798-4dd0-a0bb-f641f41a16bf@Spark>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1699106293-1681543867=:2975"
Subject: Re: [cocci] Match and print size of allocation
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1056
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304150930200.2975%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1699106293-1681543867=:2975
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 15 Apr 2023, Yudi Yang wrote:

> Hello Julia,
>
> Thank you for your answer! I have modified my code:
>
> @@
> expression E, SIZE, N;
> statement S;
> @@
> (
>   E = malloc(SIZE);
> + printf("%d", SIZE);
> |
>   E = calloc(N, SIZE);
> + printf("%d", (N) * (SIZE));
> )
>
> However, it cannot match initializations and if-statements.
> I am not quite understanding your "malloc(SIZE)@S" solution.
> Could you point on how to use the it, or perhaps some related links?

What I proposed didn't work, but the following works fine:

@@
statement S;
expression size;
@@

(
S
+printf("%d\n",size);
&
malloc(size)
)

julia
--8323329-1699106293-1681543867=:2975--
