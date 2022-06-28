Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AA7C43334
	for <cocci@archiver.kernel.org>; Tue, 28 Jun 2022 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=INCjKbE+QrgQar/gHrinmUaILAZ/ICB5BhKx6DJ1DxY=;
  b=PXSW8nJrlDEqJnfjyHv3vKy9Tu89yKIgWwAMIhAVvw5bkVm62r3DKdIO
   lTyjawW7yRUWBsoyurV7fpLodb4NseIo3p6Sskw179ii9Bp0+SR2QQXhf
   +LB8wFaKObqkhvI07betO7zj1tasGwriRi3k9a7y3jsH93kQi7YeAcmhe
   s=;
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
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="43304425"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2022 22:37:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B424E00CA; Tue, 28 Jun 2022 22:37:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9E4EE00BE
	for <cocci@sympa.inria.fr>; Tue, 28 Jun 2022 22:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=INCjKbE+QrgQar/gHrinmUaILAZ/ICB5BhKx6DJ1DxY=;
  b=Bqi7vqB+Oebiemg49Lj4sa+wM5Hz8f7DgE6UqS5HWF5nlavoBn8ik8Jt
   eVOYPxTfRzHsSH3M+YutAgDl84YxpAMi/Q4M8K09j2LaXoYEdQ3eIEQXL
   kVEpwovdaWf29mq1PzR5jvi7o+CeVawgKnaM2dSZ7shTcxSBPYj3jgE5U
   U=;
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="43304424"
Received: from unknown (HELO hadrien) ([65.216.237.4])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 22:36:58 +0200
Date: Tue, 28 Jun 2022 16:36:57 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, 
    Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <AS8PR03MB7603A0EDD52082F08387477993B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206281635110.2121@hadrien>
References: <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com> <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com> <alpine.DEB.2.22.394.2206281246160.2182@hadrien>
 <AS8PR03MB7603A0EDD52082F08387477993B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1066898029-1656448619=:2121"
Subject: Re: [cocci] [PATCH v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 463
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206281635110.2121%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1066898029-1656448619=:2121
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 28 Jun 2022, Jérémy LEFAURE wrote:

> > > This limitation could be avoided with an explicit test to NULL in the
> > > semantic patch:
> > > *\(&x@p || ... \| &x == NULL@p || ... \)
> >
> > No.  Just put the == NULL case.  The &x case will already be covered by an
> > isomorphism.  You can see this with spatch --parse-cocci file.cocci
>
> I'm not sure to understand what you mean. I tried to have only:
> *&x@p == NULL || ...
>
> But it matches only negation of test addresses, something like
> `if (&my_var)` is not matched. The --parse-cocci gives this output:
>
> (
> *&*x@p  *== *NULL *|| *...
> |
> *!*&*x@p  *|| *...
> |
> *NULL *== *&*x@p  *|| *...
> )
>
> I get that the &x allows to match the `!= NULL` case thanks to the
> isomorphism `X => X != NULL` but I don't get how the `== NULL` case only
> could match the test address without negation as the isomorphism is
> `X == NULL => !X`.

I think you should have \(&x == NULL \| &x != NULL\)

If you have if (&x) S1 else S2 then it will consider the possibility of
exchanging the branches and negating the test.  But if you just have a
positive test expression by itself, it won't consider the possibility of
changing it into a negative one.

julia
--8323329-1066898029-1656448619=:2121--
