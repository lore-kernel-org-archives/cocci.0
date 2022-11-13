Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC788C433FE
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3yFdmDg/BJlxal7o+pvNTRtASskTVOScOrYX7FZf7hQ=;
  b=akTkKyTnOxj0ZeqRRqK14KQ5wptpextXwDAxq50wjkgy0hvh233vdV3q
   turBYd3ZM3xq9J0QDzw2nBLd7rl4YqCkWmGpP7f4PyZ/ZUFbasp39WSeP
   K/EVrD4sEblElS/1ynBfsNIoFkjuyDBHzDbPLfDU7QYL8T6BPjjtUsSW5
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
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77916472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 15:10:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 088F1E0236; Sun, 13 Nov 2022 15:10:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 00245E0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 15:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3yFdmDg/BJlxal7o+pvNTRtASskTVOScOrYX7FZf7hQ=;
  b=cd32BuDrGGuL64IaU9BmT7km9wQRLuzDMTao4AcaVdzr+VYPI5kB2WWL
   vRRWDKSGAtc0s3+ZR3IHXwOr7y9SdnMZod7juqThbYM36GB9Xw8gWXvaZ
   MGbC0oIntpkd+BpOZIk0lxSe4ejCNVUdc9yE/L5JamK1PHwZ+YRpTKUKU
   I=;
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="39599290"
Received: from 165-173-11-170.myrepublic.com.sg (HELO hadrien) ([165.173.11.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 15:10:24 +0100
Date: Sun, 13 Nov 2022 22:10:21 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, 
    Elia Pinto <gitter.spiros@gmail.com>
In-Reply-To: <2dd76fcc-0f76-e99b-80a1-2ade40e65380@web.de>
Message-ID: <6cedba8a-8765-fd51-2980-b64a6f86aa7@inria.fr>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com> <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de> <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de> <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de> <b48551e5-3792-e563-469-57f2b17164@inria.fr>
 <2dd76fcc-0f76-e99b-80a1-2ade40e65380@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1625867843-1668348626=:3582"
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 742
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/6cedba8a-8765-fd51-2980-b64a6f86aa7%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1625867843-1668348626=:3582
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 13 Nov 2022, Markus Elfring wrote:

> > What is the problem with this semantic patch?
>
> It tried to express a reduced transformation approach also according to
> a clarification attempt by Elia Pinto.
>
>
>
> > You didn't have the thoughfulness to provide a test case,
>
> I published one yesterday.
> https://lore.kernel.org/cocci/b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2022-11/msg00040.html
>
>
> > but I tried one and it worked fine.
> >
> > int main () {
> >   int x;
> >   x = 'x';
> > }
>
> I can get a related test result.
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch move_a_variable_declaration-20221112.cocci test_for_declarators2.c
> …
> @@ -1,5 +1,5 @@
>  void my_test_for_one_declaration(void)
>  {
> - char o;
> + char
>   o = 'x';
>  }
>
>
> Does it also mean that information from code deletions can generally be captured
> for subsequent code additions?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/768bd6eb0a2cbede8f1390009cc997ff57c339a4/docs/manual/cocci_syntax.tex#L1022
>
> Why do I observe test results which are different in comparison to
> the previously mentioned SmPL code variant “-T I;”?

Elia Pinto's problem is related to the management of *s.  You can't see
the problem on a simple type like int.

julia


>
> Regards,
> Markus
>
--8323329-1625867843-1668348626=:3582--
