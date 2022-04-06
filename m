Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70609C433EF
	for <cocci@archiver.kernel.org>; Wed,  6 Apr 2022 01:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xMZ2wWVZBn9F4pR4XNGhdZE/IVguQPwQ4viPEB4Ypmc=;
  b=GLR7Ui3dxiS5fY69MzcGQ/Nt0V+k5vqyHQ5HsmGdVB9tq44qcsenztaU
   mhwb8TuarEwgzQELCvWZFec9r/LmYYQtEhVUk3Q74syPRgXU8F+nzYN+D
   mXkW+QMuNg6ncdHeNi09rRPH2I+aKUyNlqqq0pM23CMvQeXw2b3HaPNBn
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,238,1643670000"; 
   d="scan'208";a="30248009"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2022 03:28:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79CABE0115; Wed,  6 Apr 2022 03:28:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EBAFAE002D
	for <cocci@sympa.inria.fr>; Wed,  6 Apr 2022 03:28:48 +0200 (CEST)
IronPort-SDR: JvHdibrHCNbriUbnjUq4Ae+6vIhBddWWorLp2l49iQziz4Wg1+fPoVOs0OZFVb11fT+q3DVqPX
 NedngYfIYtBk6x4k3FBhQREPLIezZydynUOS3vQNtZVAiZU0eydFq9DprmZgrIn9lVziJaoWCh
 btnxABq31nS5h9YUvsW3WOFwf2HbnU+2KTHXdB/xC979NlfbcXXCDiK9DYQ2jEAAqlxeIV4O5Z
 +8QDOzarvQHSIfUoj3rdL7Boa0s3GXUUJIH0idvlyc1Zs9asrQtC8cC88XlG06UniEuHzGV2Yy
 VzrQ0sGc4qtVOlBg6vAgp+vR
X-IPAS-Result: =?us-ascii?q?A0BCBAAn7Exi/0Xcza1agQmBWoIoB4FNAQEBKQQLljSca?=
 =?us-ascii?q?IF8CwEDAQ1DBAEBghKCdQKEYQIdBgYyBw4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBAFWMiwBYwFnAYFOAYF5BgQ9gjUpAYNjAQEBAQIBOj8QCxguV?=
 =?us-ascii?q?waDF4J2Ia0MeIEzgQGJfIE8jk4nHECBTYE8DIJ3PooiIgSZMoICG4FhapI4k?=
 =?us-ascii?q?CSeIINTn2gaLoNiknGRfpZepw2BPygBNYFZHxQaCCYKgyVNAQIBAgEMAQICA?=
 =?us-ascii?q?QIBAgECAQgBAQIBnQwhAQEBaQIGCwEBAwmOJgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:1YAreaiBFgcbCbBsyNC+GYnpX161VBYKZh0ujC45NGQN5FlHY01je
 htvCmrXaKmLMDHxKYp1YNi0oRtVsJWGndMxSFdtqXw2Q3xjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq/5WCYATNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplq56sVVcZA/P2uuUfQRpRPwsjJPEZ9+qSSZS/mZT7I0zudmuqzupuAUwyMJde/OtraY1M3
 aVHc3ZXNk3F3bjuhuzqIgVvrpxLwM3DN4QUsXBIyTDCEe1gTI/DTqjO6MUe2jos7ixLNa+GO
 ZpANmY+BPjGSxhXNxAGLJw1pvWhmCfzUxljq2qnrpNitgA/yyQqjOa2YYWFEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmDO9VZ0SGbC8++QshlCProAONPEIfUW5veXpunPgYfBeK
 V4X8wYE8LFuq0P+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8Lo3uqJOoQXZmUeN4F+5afaURRvh
 wDZxYq4bdB6mOTNESr1y1uCkd+l1cEowYIqYD9CQBQF7tTnrZt1iB/TJjqCLEJXpoakcd0T6
 2rWxMTbu1n0pZRRv5hXBXid31qRSmHhF2bYJmz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 Cldy5TFvLleXc7leMmxrAMlR+rBCxGta2e0vLKSN8N8qVxBBVb9FWyv3N2ODBw1bJ1VJm+Bj
 L77tBxR6ZJXMWGra6QyO9vZNijZ5fOIKDgRbdiNNoAmX3SHXFDfpHkGiI/59z6FrXXAZolkY
 M3BLJn1UShBYUmlpRLvL9ogPXYQ7nhW7QvuqVrTlnxLCJKSOyyYT6krKlyLYrxr5a+IulyFo
 dJeLNeRjRhAUODzZiTNt4geMQlSf3Q8AJn3re1Rd/KCe1A6Qzt5VqaNmL5xKZZ4m6l1l/vT+
 i/vUEFvyG3g2S/NJzKMZy0xc7joR5t+8Cw2ZHR+IVay1nE/So+z96NDJYAvdLwq+bU7n/55R
 vUIYeuaBfFLRmiV8jgRd8Ct/ohjbwiwww+RPyeoZDUlOZhtW1WRqNPjewLu8ggIDza27JFi+
 Of4i1qHGJdaHlZsFsfbbv6r3midh3lFlbIgRVbML/lSZF7ortpgJRvxueBrccsCHhPOm2mB3
 AGMDBZF++SU+90p8MPEjLyvppuyF7csBVJTGmTW4OrkNSTe+Wb/k4ZMXPzRIGLYRCX556Wva
 OFY1bf6PeFexARGtI91ErBKy6Mi5oK1++QAllk9QCzGPwaxF7dtAniaxs0R5KdD8b9uplfkU
 Ey4/NQHa66CP9noEQNPKVN9PPiDz/wdhhLb8e8xfBfh/CZy8bfbA19eOQKA1H5UILdvad53x
 PdntdEW5gG7hwBsNNua13gG+2OJJ30GcqMmqpBDWtOw0FJ2kw0bbMyOEDLy7bGOd85IbBsgL
 AiUs7We1b5S8UzPLigoHn/X0OsA25lX4EJWzEUPLkiik8begqNlxwVY9Dk6Q2y5FPmcPz6f7
 oSqC6F0GUlK1zJ4wsVcX22hHwxbQhuU5iQdDrfPeHLxFyGVuq7ldQXR+tphOGgd8nlAZX5W4
 7GVxWLoS3Dscd2ZMu7en6J6g6SLcDGynzEuXOijHt+ZBN83fjroj6ujfywOpgeP7QbdQqHYj
 bECwducopEX+cLdT2PXxmVaOXktpMi4GVF/
IronPort-HdrOrdr: A9a23:FmVcKqigj4QPUbCuWD76VKq25XBQXt4ji2hC6mlwRA09TyX4rb
 HWoBx4vSWatN9/Yh8dcLy7WZVoBEmskKKdgrNhW4tKPjOW3FdARbsKheCOrwEIWReOkdK1vp
 0QEZSWZueRMbGkt6zHyQOzeuxQo+W6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,238,1643670000"; 
   d="scan'208";a="10681749"
X-MGA-submission: =?us-ascii?q?MDHq0OYfWyeVpojxSUVb2M/R7NlXNogIxrsqxt?=
 =?us-ascii?q?6mopd7ISr7QGrVlxO9JV3BI45pJ/x+hwY0mqz0UR6Ob//RzS0gCzWQpR?=
 =?us-ascii?q?rmbtRhKbyfA628OuWEo/UF8LgAe3am+3kqe0JpTriaPf4HiwvEW6AJn4?=
 =?us-ascii?q?RUiJT7LyjK7XrAxCHTzOSlyg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:28:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 566504A;
	Tue,  5 Apr 2022 18:28:45 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Y0zGikM008SH; Tue,  5 Apr 2022 18:28:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6C6ED39;
	Tue,  5 Apr 2022 18:28:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6C6ED39
Date: Tue, 5 Apr 2022 18:28:42 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ec394f75-0210-a741-1c85-a1a8e18a715e@web.de>
Message-ID: <722a0e8-6471-eff0-de2e-a0a7e9adc6fb@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
 <alpine.DEB.2.22.394.2204012224060.3048@hadrien> <5f832bd0-37e2-3417-df60-4cdbc5cf5fb8@ewheeler.net> <alpine.DEB.2.22.394.2204021940530.3208@hadrien> <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net> <ec394f75-0210-a741-1c85-a1a8e18a715e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 358
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/722a0e8-6471-eff0-de2e-a0a7e9adc6fb%40ewheeler.net>

On Sun, 3 Apr 2022, Markus Elfring wrote:
> > Ok, then maybe I'm trying to optimize something that doesn't need optimized.
> 
> Your understanding is still evolving also for the supported functionality of
> the Coccinelle software (and corresponding program parameters).
> 
> The run time characteristics might be good enough for your source code transformations.
> 
> Additional development ideas can be shared for possible adjustments of implementation details,
> can't they?

Indeed!  Thanks for the encouragement.

--
Eric Wheeler



> 
> 
> Regards,
> Markus
> 
> 
