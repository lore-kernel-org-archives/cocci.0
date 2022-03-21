Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AD7C433F5
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5UnC2wQok581JsqZaauWI22VhajDyKGl4A7DazoXAso=;
  b=r3y6qHkXqVR91TbemJ4xXVAeVKvxfWa+hfr9f71eSfzDyC5n3iWOD1fn
   vAoggRY+R6BaGsNasi5K1VBUXKtiqXsEMmhMWCGJ4z6dJBcGOhHRxe9lD
   qcz1V2ugLKq1Z72jbJ5pF24wj9T9TbLBYJwNJqV6lC/S0I/xpA96lr989
   A=;
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27300256"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 18:44:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D1035E01B9; Mon, 21 Mar 2022 18:44:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 950CFE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 18:44:24 +0100 (CET)
IronPort-SDR: ldlwIUrunvEOcoN4nnNTsvd7EuF1zmhaIevWKfIErMGDVxtvyXZ63+0fUkR6QGgUjYVQz5Npqd
 41S2oxmi4sEiDO/NLKQ1T8MY60PkoufUA+YzVAfdoAKPYw9AB2uQQGzstLNyxeUVIxyq4v7wuZ
 6QClMrgdm7mCM+QxQWIae285BzhoMBJH8AsgE23oI68gcCnn2U+K1a+YSm/aYNfw/Rt6PST3O1
 6SeyGkNBKgRszHbDMn1dGAoxOiLon8PVJpL6rFCUgvXqEcjWyYPdP2vu+H39oF/VTWa4QDzixp
 YxdhzGUPxcbru1TpF71SGote
X-IPAS-Result: =?us-ascii?q?A0BEBQBwuDhi/0Xcza1agQmEAgeBTQEBASkEC5QLgiiEH?=
 =?us-ascii?q?5pACwEDAQ1BBAEBhQcChDwCHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAFWMiwBYwFnAYFOAYF5BgQ9gjUpAYNkAQU6PxALGC5XBoMXgxetW?=
 =?us-ascii?q?4EzgQGJe4E8jkknHECBTYE8DIJ3PopEBJxCohacaIEug1OfXgYULpZJkXWWW?=
 =?us-ascii?q?6FShTCBPzklgVkfFBoIJgqDJU0BAgECAQwBAgIBAgECAQIBCAEBAgGdDCEBA?=
 =?us-ascii?q?QFpAgYLAQEDCZFyAQE?=
IronPort-PHdr: A9a23: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
 V6m
IronPort-Data: A9a23:hyxDBanI2iJeKm3WrSwb61ro5gxLIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaC2uDO66OYGOmfth+bN+1oB8GvcSByN9lTwJtqX9hFVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+ZSHYjdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1HmrP3ez8vJJTW28odWAVaPChAMJZZreqvzXiX6aR/zmXDYz3h3PVjAUU7J8se9/of7WNmr
 KNDbmpVM1bZ3brwnuPTpupE3qzPKOHgO4gUu1lkzCrFFrArXpDOTqHH/5le0StYasVmR6mFP
 5JDNGIHgBLofxpSFHNJBo4HxOKqoUvgSGxR61S6jP9ii4TU5FctjuO8b4q9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmlqoj/DGmSfTSoMXHqexsP9smlyagGIJYCD6TnO+sb+0lU6zVtZSM
 QoS9zZGQbUOGFKDRPbSGC+ApmS9pF0yW9FMEcIz1gy21f+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+/U6SxTXK69Ei3Cq+/Fxd+mEW1Ecj9YPH5soR4tuoG7+OkOYgTzosGP+ZNZY/XwCXf93
 DCHoSwznfMVgNJjO0SHEbLv32vESnvhFFJdCuDrsoSNtF4RiGmNPtPA1LQjxawcRLt1t3HY1
 JXE8uDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AAzQMl5pmr1oST6Iei8BQ2Swm8zYq7onheyP
 SfuVf55vsINVJdURfAfj32N5zQClvS+ToW6Bpg4n/JDfZh8eQuK5iBobgvIhgjQfLsEyskC1
 WOgWZ/0Vx4n5VJPk2LuH4/wENYDmEgD+I8kbcuinkr9jubGOiL9pHVsGALmU93VJZis+G39m
 +uz/ePTo/mGeOGhMCTR76AJKlUGcSoyCZzs8pwFcu+YPhEgFX4hBvLVzKlnfYF5xvwHmuDN9
 3C7e0lZ1Fum3yGcc13XMyw6ZeO9R4t7oFI6ITcoYwSi1U8jVpnzvq0RQJ06IOs8/+t5wP8pE
 fRcI5ecAu5CQyjs8igGacWvt5RrcRmm3FrcPyesbDUlUYRnQgjFpo3tcgf1rXlcCiusqdB4r
 qKg2w7fTIBFQQl+VZ6EZPWqxlK3nH4chOMrBReTeIEOIRm1/dEzeSLrj/IxL8UdEjn5x2OXh
 1SMHBMVhejRuItrotPHsqCzsNv7GeVJGEcHTXLQ6qy7NHSE8zP7k5NASuuBYRvUSHjwpPe5f
 exQwvzxbK8HkVJNv9YuGrpn1/tjtd7/4bJFzglpGHjRKVKmFuo4cHWB2MBOsIxLx6NY4FHqA
 RjXp4AGYLjZatn4FFMxJRY+arrR3/8jmg7NsaY/LnL86XIl57GAS0hTYkeB0XQPMLtvPYo56
 u49o8pKuRengx8nP4rUlCxS7GjQfHUMX79+68MfEMnmlQomx1VPe9raBzOvuMODbNBFM08LJ
 D6IhfOY2+8GnhebLyM+RSrXwO5QpZUSoxQUnlUMEFS+hYaXjPEA2hAMoy88SR5Yz0gZ3rsra
 HRrLUB8OY6H4yxs2JpYR2mpFgxMbPFDFpcdF7fdeKzlo0iUuqjlKX17NPmN8U0d/ngaeDVHl
 F1dJKAJTh6yFPwdHANrMaKmlxAnZdhw7RHZ3s24H8mIG5QgJzzonsdCoIbORwTPWasMaY6um
 QWu1OJxcrHgcyMPo6A2D4SAk7IdVHho4YCEre5JpMs0II0XRN1+NfVi5ax8lgOh6sEmKXOFN
 vE=
IronPort-HdrOrdr: A9a23:cjNxWK3dg3suF99P7/QO3QqjBLYkLtp133Aq2lEZdPU1SL3gqy
 jN9M516faaslgssR0b+OxofZPwJE80lqQFh7X5X43SODUO0VHAROoOgbcKgQeQfBEWndQtt5
 uIHZIfNDQuNzJHpMzxiTPIcOod/A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27300250"
X-MGA-submission: =?us-ascii?q?MDHfPsV7soTzABBzNoaQ07n9kc8ltiwBXonKwY?=
 =?us-ascii?q?f1Gkpb43iW13+pVl4MmzmhA2rT14UWB9gyabftTT6LW7Fjtw/j1IIjVI?=
 =?us-ascii?q?EdkgyqUs/wMkTnjkzwLzQVOkgGHjTeKmcrQp1dZ/smR8YKulRnMFCrmx?=
 =?us-ascii?q?20npnHCc6gIJrMtTvZOsu8Uw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:44:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id BA9C347;
	Mon, 21 Mar 2022 10:44:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rcRVo1WkJKA2; Mon, 21 Mar 2022 10:44:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id EA5AD41;
	Mon, 21 Mar 2022 10:44:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net EA5AD41
Date: Mon, 21 Mar 2022 10:44:18 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203210703261.3210@hadrien>
Message-ID: <73f778c8-c23a-6374-76d6-b74976e59156@ewheeler.net>
References: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net> <alpine.DEB.2.22.394.2203210703261.3210@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Is there a stringify operator?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 273
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/73f778c8-c23a-6374-76d6-b74976e59156%40ewheeler.net>

On Mon, 21 Mar 2022, Julia Lawall wrote:
> On Sun, 20 Mar 2022, Eric Wheeler wrote:
> > I keep running into situations where it would be nice to stringify an
> > arbitrary metavariable.
> >
> > For example:
> >
> > 	@ r1 @
> > 	type T;
> > 	identifier I;
> > 	@@
> > 	T I;
> >
> > 	@ r2 @
> > 	type r1.T;
> > 	identifier r1.I;
> > 	@@
> > 	++printf(#I " has a datatype of " #T "\n");
> >
> > I used '#' as the stringify operator provided by macros.  This alternative
> > format would work if I define a stringify macro (I think this works):
> > 	#define STRINGIFY(a) #a
> >
> > and then:
> > 	++printf("%s has a datatype of %s\n", STRINGIFY(I), STRINGIFY(T));
> >
> > Not sure of others would find a '#' operator or some other stringify
> > functionality in Coccinelle useful...
> 
> You can do this with python.  See demos/pythontococci.cocci forthe general
> idea.

Ok, I just really like the concise Coccinelle syntax!  For now the 
STRINGIFY macro works.

--
Eric Wheeler


