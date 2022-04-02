Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23650C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=K3rP3A6GzN5diqqOFmp2TYqn7KTtJ7OmF9HYCBlD6zg=;
  b=JWgFnNvo8H9nFzWkpXtLLicf1x5qPR8UstGd5MKxDYpw4pxQxGgU9RSF
   Rl8zxasBHizRQBPOf8tVDQflFIfA5GJlbPmEx6YeaNwDJyztGXupD6t4x
   7gGFx5naCDmxi/qcByzem67u0Y1tGnKYPYSGzJrK5OJrGM33Ut3Klnspo
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29704817"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 00:52:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38174E033C; Sun,  3 Apr 2022 00:52:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 82D38E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 00:52:11 +0200 (CEST)
IronPort-SDR: wxLz6blw1AKOxvb3K29JVIitKUecgYew0XeLtxIgDNRc5MOQ87/4DB77rxlec2PrqBCLWHqml8
 ZJDrFi+hxonAU1oXWvD/8F0RnOQNAi6hWnR8w2G8s2AubDDtYUoKrnnqbknBUrL422dW2S33h7
 NxBfAcc6lJK9DJJs5QuMeHqVNglLRW6k3dj1BBU0wW0iDLprWqy3NzysYOed4nCwEuoYjyeTfD
 Hw8MmFEvmt33RRhkpLDTDsa+1CHeZo2fhE4EunhiDDP/Wd3LkuTz69n0Z4o6nGb+nMTeyfDaEm
 FZbmKMfig8D29xuIGVxORY60
X-IPAS-Result: =?us-ascii?q?A0AVBQBY00hi/0Xcza1aHgEBCxIMQIQCB4FNAQEBKQQLl?=
 =?us-ascii?q?jADnmMLAQMBDUMEAQGFBwKEWgIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEAVYyLAFjAWcBgU4BgXkGBD2CNSkBg2QBBTo/EAsYLlcGgxeDF?=
 =?us-ascii?q?68rgTOBAYl8gTyOTiccQIFNgTyCUzA+ikQEmU18E4E9BzVwolmccYEvg1Ofa?=
 =?us-ascii?q?AYULodOjwOLHYZhll6nDIE/OSWBWR8UGggmCoMlTQECAQIBDAECAgECAQIBA?=
 =?us-ascii?q?gEIAQECAZ0MIQEBAWkCBgsBAQMJjyldAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:6D1G5qJYpGjkffGZFE+RG5MlxSXFcZb7ZxGr2PjKsXjdYENS3zZVx
 2IdUTuHOfyOZWOgfNlxbIS09B4E6JbXytdjQQUd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhX1vX4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhrctR1
 9NTroSMWCgnAL3NluY8fBh4DHQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9G5o3ZAVQq2GD
 yYfQQo3Ry3AfQwRAGxJGM4Sss2QvFbScBQN/Tp5ooJsvzaInVMhuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrS3zTOa+3aorv3OmCnhUcQTEqe5/7hkmjWuKnc7DQ1QWES7rPS9h1T4Xd9DQ
 6AJxsYwhZop1FOtUMLlYwyXrkCUvxAeevVRM/JvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQW6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFb7zg8L1FDz0z
 irMqiUi71nysSLp//njlbwkq2jwznQscuLTzl+JNo5CxlkjDLNJn6TytTDmAQ9ode50jjCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/bbG2N2wIwR8B8rmrFF5ufkWZ4u2gWyKBBaZ1sRNMUS
 BWO52u9GrcNVJdVUUOHS9ntVZ97kviI+SXNW+/UY9dKb4JwcgTCpHgGWKJj9zuFraTYqolmY
 c3zTCpaJSlCUfwPIfvfb7l17ILHMQhlnjyDHcmrlkv/uVdcDVbMIYo43JK1RrhRxMu5TM/9q
 r6z7uOGlEdSVvPQeC7S/dJBJFwGNyFrV5T3sNBMMOOcIgdrHGw7Tfnc3ep5KYBimq1UkMbO/
 228AxUEkwCn2CSbcAjaOGp+bL7PXIpkqSxpNyIbPWG3hyopb7Gp4fpNbJAwZ7QmqbJulKYmU
 /kfdsycKf1TUTCbqS8FZJzwodU6JhSmjA6DJQS/Zz07c8IyTgDF4Ia0LA/u7zUVSCeotcYzp
 7C6kAXWXcNbFQhlCc/XbtOpzk+w5CJBw7gqAhKUe9QKIRfi6olnLSD1n8QbGcBUJEWR3Cae2
 iaXHQwc+7vHrbg1x8aV16qKmIGkTrllFU1AEmiGs7vvbXvG/nCuyJNrWfqTeWyPT3v9/aiva
 LkHz/z4N/Fbzl9Gv5AlTuRu3eQz+NviqrtX1EJiEWmSNwanDbZpI3+n28hTt/QXmuQD4VbvB
 huCqotAJLGEGML5C1pPdgArWeS0yq1GkDfl6/locl7x4zV6/efZXBwKbQWMkiFUMJB8LJghn
 bU6oMcT5gHj2AAmNM2K0nJd+2iWdyFSVrVhu44aDYLvhxBtzFxeOMSOBijz6ZCJStNNLkhze
 GPP3vKf3ugFyxqQaWc3GFjMwfFZ28YEtidK+0BedV6HrdzI260s1xpL/DVqEAkMlkdb0/h+M
 3RAPlFuIfnc5C9hgcVOUghAwe2a6MF1LqAw97cIqIEdZ0y4EGHSLGAwPeuXukYU7wqwu9SdE
 K6wkA7YvfTCJakdHRfenWZhquf/Vpp86Q3PlcSqBYKDEoVSjf8JREOxTTJglvYkaP/dQGXDp
 PJ256B9dq32OCodues9BpXyOXH8jvybDDQqfMyNN5/l0Y0RlP9eFNROx42MlhtxGsH3
IronPort-HdrOrdr: A9a23:rlsOJa5eelFBfCGhBAPXwMzXdLJyesId70hD6qkRc20tTiT7//
 rAoB1173HJYVoqOU3I3OrwXZVoIkmsk6Kdg7NhWYtKNTOO0ADEQL2Kr7GSpAEIcBeOlNK1u5
 0BT0GgMrfNJFJx5PyKgzWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10383730"
X-MGA-submission: =?us-ascii?q?MDHMxXR0pPejwuFe9TmE3rfbAm2lPXFzv6pZba?=
 =?us-ascii?q?8E5HH345APmcLOeEKRe9uuPSSWeBwAQgTd5/NIs4MUYz4+WVzQ5pfJI0?=
 =?us-ascii?q?8Jbvu9Wbf4Bs3KlElOk2ds3eKKL5iTkAyZtQsePn+FW6CjTpLjxh+1pC?=
 =?us-ascii?q?YIAckKd/vnyjXYjLEsHRdzbQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 00:52:08 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 083EB4A;
	Sat,  2 Apr 2022 15:52:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iyJ_jEXDAd8F; Sat,  2 Apr 2022 15:52:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 8E23539;
	Sat,  2 Apr 2022 15:52:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 8E23539
Date: Sat, 2 Apr 2022 15:51:54 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
Message-ID: <794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net>
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net> <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you concatinate string constants in SmPL with
 python?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 341
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/794e98d4-931f-d19f-c821-274dec65dbf4%40ewheeler.net>

On Sat, 2 Apr 2022, Julia Lawall wrote:
> On Sat, 2 Apr 2022, Eric Wheeler wrote:
> > I would like to do something like this:
> >
> > @ r @
> > constant C;
> > @@
> > -perror(C);
> > +pr_err(C ": %s\n", strerror(errno));
> >
> > Thus in python I need something like C = C + C ": %s\n".
> 
> I don't understand this.

For example:

-perror("unable to open file");
+pr_err("unable to open file: %s\n", strerror(errno));

I'm trying to append ": %s\n" to the original string (C) so we can process 
the error using pr_err() instead of perror().  Since SmPL does not support 
string concatination (so far as I am aware), I would need to use python.

But I'm not sure how to structure the python bits so they interact with 
cocci.  I've looked at some examples but I don't see how to change the 
value of C to something else, such as C = C + ": %s\n" where + is the 
append operator in python.

--
Eric Wheeler


> 
> >
> > I've tried a few things, but I don't think I'm anywhere close to getting
> > it right.  Can someone help with how this should be setup?
> >
> > Also is there a reference for the `coccinelle.` and `cocci.` python calls
> > that seem to be available in a script:python section?
> 
> There is Coccilib.3cocci, but that is for ocaml.
> 
> My understanding is that there are reflective features in python that let
> you find out what functions are available.  python/python_documentation.md
> in the source tree also has some information.  Or look at the code in
> python/coccilib.
> 
> julia
> 
