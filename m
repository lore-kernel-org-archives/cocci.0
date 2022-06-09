Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF4C43334
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DUnaXOAraryNHyglUUQl6z9+vSHzSGkUCYfcPazH23o=;
  b=k4xTmGubMyBizFe1vFJWyh0QLOM61+z2XEBYSL4N0fpVzgsxQwYcek2k
   3eOFSXw2V8Y8ImuOLzSpknvqaTOxWDRm2H2r6e4/DA3CrfmKAiV8ogkZn
   4EdwK6xFwNYNEXviMJyHAJTAxDG59DBjTwnavP6iibXdXcEq3BZnAPRTh
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="40295099"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 21:39:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9EEAFE02DC; Thu,  9 Jun 2022 21:39:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 099D3E010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 21:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DUnaXOAraryNHyglUUQl6z9+vSHzSGkUCYfcPazH23o=;
  b=iJ0+fqOUGBZj/bMoRIOB0E74T0qn0vF4m3V/imYCXKH+SlzodeYkAUnF
   cJtgy9KPzG54uFx4z6LsAcLIAw48HWW/TLjLu2B24FQ2+xoCEH2tcEMgj
   p5boyL5X9pNkyR101THM6g73q2aaloXEa0s5SgrF//JG9thy5yGBe97uk
   8=;
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="40295098"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 21:39:56 +0200
Date: Thu, 9 Jun 2022 21:39:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>
In-Reply-To: <8f9bbad3-1812-6448-52e6-2570e6368f0d@web.de>
Message-ID: <alpine.DEB.2.22.394.2206092139370.2949@hadrien>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com> <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de> <alpine.DEB.2.22.394.2206072138160.2960@hadrien> <15a253a6-469b-9632-8c7d-983554604451@web.de>
 <alpine.DEB.2.22.394.2206091740520.2380@hadrien> <da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de> <alpine.DEB.2.22.394.2206091824560.2380@hadrien> <8f9bbad3-1812-6448-52e6-2570e6368f0d@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1717427422-1654803596=:2949"
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 431
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206092139370.2949%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1717427422-1654803596=:2949
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 9 Jun 2022, Markus Elfring wrote:

> >>> How about trying an example?
> >> You might interpret the following test result as an expected one according to
> >> your understanding of implementation details.
> >>
> >> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch show_address_determination_in_checks-20220609.cocci initialisation_test2-20220609.c
> >> …
> >> @@ -1,8 +1,6 @@
> >>  void check(void)
> >>  {
> >>  int s = 1;
> >> -bool t = &s ? 0 : 1;
> >>  bool u;
> >> -u = &t ? 1 : 0;
> >>  }
>
>
> Can it be that special transformations (which are not represented as a parsing result
> from the application of named isomorphisms) were applied here?
>
>
>
> >> I observed that no questionable places were marked in the following source code.
> >>
> >>
> >> void check(void)
> >> {
> >> int s = 1;
> >> bool t = (&s);
> >> }
> >>
> >>
> >> Will this test case trigger further development considerations?
> > It seems to be doing what it should.
>
> I would expect that the usage of the address-of operator within extra parentheses
> should also be marked for reconsideration of such source code.

It's not a test expression.  The bool type is not relevant.

julia
--8323329-1717427422-1654803596=:2949--
