Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B14C433FE
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 10:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5nBhGcJkQbX0x/9ykAe0u6ws0m1mZWomo7Kz05+///0=;
  b=Cp2OhpnHBZTHAW1HsLyW3Be3cCWTHuXKXQdLWtuc2Rx9Ne/8JBk/DqGW
   bv/c9KR23CDEdgQISm678+rxN+7hZW/mdCScXfF/cwLgm5cl28/VMaDvy
   QEjUnGotyLWnQncCk5AVYIAVwYepH1oCuS9D9XR/Jp5a1E8x0FTqGxjzn
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77907714"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 11:36:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72FCEE039C; Sun, 13 Nov 2022 11:36:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F409EE0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 11:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5nBhGcJkQbX0x/9ykAe0u6ws0m1mZWomo7Kz05+///0=;
  b=EsqujnPDTdUVO6RChC3bcLKFTH03aeStFAr68sbnCjdSzUaV/pMW9ES4
   9wymeKE/TeDtIfNjU9l6JZvuim37RnMQNmKyRZz/8EELxHQsaSZpNbHmr
   1bXO0DjPlLJj7zR8gaygjbZQzkPV0T1/2U6dvNefpU1RPCya8o/1g5AxW
   A=;
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77907710"
Received: from clt-128-93-176-107.vpn.inria.fr ([128.93.176.107])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 11:36:47 +0100
Date: Sun, 13 Nov 2022 18:36:43 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Elia Pinto <gitter.spiros@gmail.com>
In-Reply-To: <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
Message-ID: <b48551e5-3792-e563-469-57f2b17164@inria.fr>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com> <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de> <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de> <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1209458034-1668335808=:14174"
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 740
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/b48551e5-3792-e563-469-57f2b17164%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1209458034-1668335808=:14174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 13 Nov 2022, Markus Elfring wrote:

> > @moving disable decl_init@
> > type t;
> > identifier x;
> > @@
> > -t x;
> > +t
> >  x = 'x';
>
> I would appreciate further feedback also for this tiny SmPL script variant.
> I got the impression that additional clarification will be helpful
> for some aspects.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/768bd6eb0a2cbede8f1390009cc997ff57c339a4/docs/manual/cocci_syntax.tex#L1022
>
> This transformation approach would require that a data type can be determined
> from a source code fragment which should be adjusted before the same type
> can be added to a subsequent statement.
> How good can such changes be supported by the Coccinelle software?

What is the problem with this semantic patch?  You didn't have the
thoughfulness to provide a test case, but I tried one and it worked fine.

int main () {
  int x;
  x = 'x';
}

julia
--8323329-1209458034-1668335808=:14174--
