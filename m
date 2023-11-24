Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A7AC61DF4
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Fl5RJO8dzwXzuEOFu5xFLqDDo2CVl9mpG4ladpJ1db8=;
  b=bsW436NoJl0XSU0kXY25hzzrSGMrQEZWNtfGAinYd9bUWnowEa02Byq2
   Hbfk8oE9uEwqVCkwHmwTtGFtNrjykQX0njq1p8LD0Qg9DPbX5CLHtuqFd
   b79jOrw5ebMm97rs0f+CzQl/UrMUDfr9ZGaVueyIgy906pI9omPIK4KTw
   A=;
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138275051"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 10:00:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57D83E0CCC; Fri, 24 Nov 2023 10:00:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 07DA6E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 10:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fl5RJO8dzwXzuEOFu5xFLqDDo2CVl9mpG4ladpJ1db8=;
  b=P6MW5B1cacbYrc0ucNkKQLO+cbA81mGSVtWz0YHDZedhlpe89e2TuhFH
   4bTvj9gG7Y6itd9mRvdkUWxkyGTeJIvf9i0niySY3P1Yzjk/t4SIv3jy/
   x0nMT4ZqsVY9vSDMiGpaZE/3tPP4Ljcq9VL+x7955zeSJw9OLPHsys05N
   A=;
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138274973"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 10:00:24 +0100
Date: Fri, 24 Nov 2023 10:00:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
Message-ID: <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de> <alpine.DEB.2.22.394.2311240807170.3349@hadrien> <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de> <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr> <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1330
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024%40inria.fr>

> * Can it actually happen that more position items are passed to a script rule
>   by a local variable?

Sure.  Try

@@
expression E;
@@

a();
...
b@p(E);

and then

int main() {
  a();
  if (x)
    b(1);
  else
    b(2);
  return 0;
}

>
> * Would it be possible to restrict the transferred data amount by a related
>   metavariable type?

I see no point in providing new functionality to do this.  I guess you
could do:

position p : script:python() { p.length == 1 };

Or something like that.

julia
