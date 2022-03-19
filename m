Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2A8C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lXVGrwtOZfoJ//LQoeMqvJhREqJiTlKcdTPmuxaIZPw=;
  b=Vk4NI/b5pDm2llZxasA1YhkgnKo+K3TyK2wFesgyfpeXcI5CkfNJzyVK
   Tjc/k2gmTY140b0+byi9xlUWiGFBLSV3wPicRSzNMkxFIyHY/FC+Q92wT
   pB/MtzLUXnN4ExuHQ4jybA01CQ/k2nS7Ci9LDptWwu7cYgjZ1UgexVX78
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26994054"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 12:20:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7B5AE020F; Sat, 19 Mar 2022 12:20:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 95696E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 12:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lXVGrwtOZfoJ//LQoeMqvJhREqJiTlKcdTPmuxaIZPw=;
  b=aywLxg3YUwEub6s/c6BwLHWdXngu6UvFtwBqx/EEJQl/bAYwXhVYyG2T
   tOjdLuByPkqsFKcmoCDMgeR3g9fTZDkl1nGxM6ofZPTwFdrth2inxQlkS
   hYkMo8ejqi2LhJ4yRoD1JqToaughH/q4qP1Gx18SPGRI30/M0qpJbahVD
   s=;
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9019964"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:20:14 +0100
Date: Sat, 19 Mar 2022 12:20:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <e7182c14-5551-111d-7c41-16fb747fe505@web.de>
Message-ID: <alpine.DEB.2.22.394.2203191219370.3204@hadrien>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net> <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net> <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net> <e7182c14-5551-111d-7c41-16fb747fe505@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1452173396-1647688814=:3204"
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 240
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203191219370.3204%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1452173396-1647688814=:3204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 19 Mar 2022, Markus Elfring wrote:

>
> > I am continuously amazed by what Coccinelle is capable of.
>
>
> I am curious how your development interests will grow also in this area.
>
>
>
> > 	// Add the compare_T() function call and compare_T function definition for each type:
> > 	@ r2 @
> > 	identifier struct_name.I;
> > 	fresh identifier FN = "compare_"##I;
> > 	@@
> > 	f()
> > 	{
> > 	++  FN();
> > 	}
> > 	++void FN(){}
>
>
> I suggest to reconsider this SmPL change approach a bit more.
>
> I doubt that you would like to add only a single function (or macro) call
> within the implementation of the function “f”.

He has ++, which allows adding as many definitions and calls as there are
values of name.I.

julia

>
> See also:
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f222337e13091115884cf6bb/docs/manual/cocci_syntax.tex#L1318
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L1318
>
>
> Are you sure that the specification of an empty function implementation
> would be appropriate here?
>
> Regards,
> Markus
>
>
--8323329-1452173396-1647688814=:3204--
