Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43737C32771
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7FqNB8KVX5MpgYiR/RuskG2M2ln6aAG6NoRrqLbZ+kU=;
  b=DzDL35YccVkMs78VrQyCwYjTsWjZep+ZwPZ8Ni63NnjZ6McxK9EApGs9
   IYfikKY1GVDZeKKjtQnLSOLXDQ2Rzifpy7XpdCWUZLH6mv+Fx8VFE2ALj
   Zn83er44uxC9kqFlmGiwfGlPj3dNbxgF+htVLcHpiNVIVo14bOTIP5qfB
   A=;
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
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55024304"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 21:38:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 513A9E028F; Wed, 28 Sep 2022 21:38:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1804AE0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 21:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7FqNB8KVX5MpgYiR/RuskG2M2ln6aAG6NoRrqLbZ+kU=;
  b=CBFmfL48JE8fLTfM0M1n8oGqqyeqXscTR6Fm4TZhcb33+eKwrrK6b00e
   fhuB/EKBw63rMSd96aTTyNnjQXWCtQalWtcrhZbsy27KhZ7wHsSIuK8qR
   RT0iOLU5PtKavGgeUa2F3kOgKOGhLc1lUVQeYtLMkFwVh+GUMwSIBhZGf
   0=;
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="24949384"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:38:52 +0200
Date: Wed, 28 Sep 2022 21:38:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
In-Reply-To: <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
Message-ID: <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de> <alpine.DEB.2.22.394.2209282125470.2984@hadrien> <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1283727423-1664393931=:2984"
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 601
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209282137030.2984%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1283727423-1664393931=:2984
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 28 Sep 2022, Markus Elfring wrote:

> > t is a metavariable that gats bound to the type of o.
>
>
> I would use the kind “identifier” for the metavariable “o” which is connected
> to a known data type.
> I would appreciate if the usage of your SmPL code can become clearer.

In SmPL, if you want to declare a metavariable that matches an expression
of a certain type, you don't have to write the word expression.  For
example, you can write

int x;

and then x will maych any expression of type int.

And if you write

t x;

then x will match any expression of type t, t being another metavariable
that will get bound to that type.

julia
--8323329-1283727423-1664393931=:2984--
