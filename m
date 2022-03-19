Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7CDC433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RSv5StPGLNUvq6tSFFXoojEQ07JFCV559ERaF21pFJI=;
  b=Alz02q8HHqGIOo6aSZjnYob2lGgivADd/yC5Yz8+cx7gNVigT5mXQQuo
   cXk2FCimPBHtOTe49kpkVL3ma5KFHf2npfu8h9rIV9ZqYYx/VwIX3SvCr
   NLSmw5NI8OnwGQx6PNP5aP9Of7xl0Wq4CD53ft8JUc5ze/IauzD9dftHC
   w=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27009665"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 16:06:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 567B9E01B9; Sat, 19 Mar 2022 16:06:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E41CBE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 16:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RSv5StPGLNUvq6tSFFXoojEQ07JFCV559ERaF21pFJI=;
  b=H9VoP8ULsDagAyX5B9NntlRfCAJHcPUby55dzW5O6A/LQbh5UviA697t
   oPnf23x9fqFZaRRK/egZRLAIdLo24A2GCdHPi3a+t4U7AFzngKI3Lg5Ms
   GhLX87mLfowuNJMERwoeVSkFTwjE/ccauXs5JjdwXfyEnoh3l09j7oS/l
   0=;
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27009664"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 16:06:09 +0100
Date: Sat, 19 Mar 2022 16:06:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Luis Chamberlain <mcgrof@kernel.org>
In-Reply-To: <458b35d6-7ca5-e98c-60fb-196c3ea3dc08@web.de>
Message-ID: <alpine.DEB.2.22.394.2203191604480.3204@hadrien>
References: <458b35d6-7ca5-e98c-60fb-196c3ea3dc08@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1093197209-1647702368=:3204"
Subject: Re: [cocci] Adding another metavariable type for the construction
 of =?UTF-8?Q?=E2=80=9Cfresh=E2=80=9D?= source code?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 244
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203191604480.3204%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1093197209-1647702368=:3204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 19 Mar 2022, Markus Elfring wrote:

> Hello,
>
> The software documentation contains the following information at the moment.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f222337e13091115884cf6bb/docs/manual/cocci_syntax.tex#L292
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L292
>
> “…
>   \item if a script is given, then it must return a string and the result will be
>     used as is
> …”
>
>
> I imagine that this description would fit better to a metavariable type like
> “fresh source code” (than the type “fresh identifier”).
>
> Do you care if such metavariables can be applied in a type-safe way
> according to syntax of supported programming languages?
>
> How are the chances to extend the Coccinelle software accordingly?

The script code of a metavariable of type fresh identifier returns a
string that is used as the name of the identifier.  There is no such thing
as fresh source code.  "source code" doesn't give enough information to
correctly parse the string.

julia
--8323329-1093197209-1647702368=:3204--
