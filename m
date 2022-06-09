Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38204C433EF
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mtDNTfXynxhBn5BTT4RJf990CKJKzkOQBOlwzwRnowo=;
  b=O4uDxZJmI/oR6Xcng2lZeiycvAQNPbRwKTzL32GShu4t2suwxl2EItui
   xGHH5ToX9RlVjc7sbgKkQ5UqU9GFN+XqgBHhIvCqm2i0YPU5TV2L/T6og
   VNlAVyAFwCCLXUnv2AGFTqD/6F3aNub87LHZnfZjodxK5lpN118auGxvW
   g=;
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
   d="scan'208";a="40277476"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 18:25:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 75B3DE02DE; Thu,  9 Jun 2022 18:25:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B2BCFE010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 18:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mtDNTfXynxhBn5BTT4RJf990CKJKzkOQBOlwzwRnowo=;
  b=MdzDJtTnfbskJeIsfZXf251yerojdhB8IaICOOqFRsHehW8RJPxBzaCo
   O5F18Tg/4G5E86PODQyl3UXJ20LdMoEVUJO5tKi/uyyP1rgMd7XpbW6Ld
   CBMlAU4ih2Vyn/tpv/yBGZzJSEwqiNr984tKhpTDx6QYEakt97ureQuig
   c=;
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="16352371"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:25:13 +0200
Date: Thu, 9 Jun 2022 18:25:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>
In-Reply-To: <da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de>
Message-ID: <alpine.DEB.2.22.394.2206091824560.2380@hadrien>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com> <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de> <alpine.DEB.2.22.394.2206072138160.2960@hadrien> <15a253a6-469b-9632-8c7d-983554604451@web.de>
 <alpine.DEB.2.22.394.2206091740520.2380@hadrien> <da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1579567670-1654791912=:2380"
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 429
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206091824560.2380%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1579567670-1654791912=:2380
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 9 Jun 2022, Markus Elfring wrote:

> >> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch --parse-cocci show_address_determination_in_checks-20220609.cocci
> >> …
> >> @display@
> >> expression x;
> >> @@
> >>
> >>
> >> (
> >> *&*x *|| *...
> >> |
> >> *&*x *!= *NULL *|| *...
> >> |
> >> *&*x *|| *...
> >> |
> >> *NULL *!= *&*x *|| *...
> >> )
> …
> >> Would another transformation be needed for the omission of trailing binary operators
> >> (according to the shown combinations with SmPL ellipses)?
> > I don't know what you mean.
>
>
> The results from the application of some isomorphism are shown by the mentioned command.
>
>
>
> > How about trying an example?
>
>
> You might interpret the following test result as an expected one according to
> your understanding of implementation details.
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch show_address_determination_in_checks-20220609.cocci initialisation_test2-20220609.c
> …
> @@ -1,8 +1,6 @@
>  void check(void)
>  {
>  int s = 1;
> -bool t = &s ? 0 : 1;
>  bool u;
> -u = &t ? 1 : 0;
>  }
>
>
>
> I observed that no questionable places were marked in the following source code.
>
>
> void check(void)
> {
> int s = 1;
> bool t = (&s);
> }
>
>
> Will this test case trigger further development considerations?

It seems to be doing what it should.

julia
--8323329-1579567670-1654791912=:2380--
