Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEFC001DF
	for <cocci@archiver.kernel.org>; Tue,  1 Aug 2023 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5OEOk8+7Ak7ZSyBimhrgk9DCmY0Y0ZqnsLRLOilDdFs=;
  b=cTUa6lSjg86tUWzvqkASToDVoMw4ZDlC6788gl8oEGz5LymY1OF4ttQZ
   Kkv70r0TIgBOTzgx/Rb+0YCQvJoal3+oAq5Yl8fqYBMnB09vHJQE2iJKW
   v+UtU+zcK4dF5IGjf+/pL26uYwlaOkgloN75V4tTZriKtTmgq2sZFOFvC
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119848271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2023 17:50:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4BD7AE013D; Tue,  1 Aug 2023 17:50:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B7444E004E
	for <cocci@sympa.inria.fr>; Tue,  1 Aug 2023 17:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5OEOk8+7Ak7ZSyBimhrgk9DCmY0Y0ZqnsLRLOilDdFs=;
  b=DH/KPRweu1zQKPsXpnAVykglfMEbocYl2Ctq7DVTIska9dZl4eimWcf/
   /FuoQfWWrQlFz5OgAOR5RVLANsat4pPI+vSqaGKcxF4gzuoMBJBtLxO6y
   CfwgyQfW6kQnH+jSUuKmwIMEtB6JCMBzVJud7t4gYGS5JHLIk3ptvOXi/
   0=;
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119848269"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 17:50:11 +0200
Date: Tue, 1 Aug 2023 17:50:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Li Zetao <lizetao1@huawei.com>, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <7343e191-7775-dbec-265d-6bd67fe50cd5@web.de>
Message-ID: <8a77bfa1-267a-4455-9614-ef3392e526ff@inria.fr>
References: <20230801094337.4145806-1-lizetao1@huawei.com> <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de> <a22f1cd0-9a9c-7ef6-f36d-a04119591d2b@inria.fr> <7343e191-7775-dbec-265d-6bd67fe50cd5@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1780676318-1690905011=:3628"
Subject: Re: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1222
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/8a77bfa1-267a-4455-9614-ef3392e526ff%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1780676318-1690905011=:3628
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 1 Aug 2023, Markus Elfring wrote:

> >> …
> >>> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> >> …
> >>> @@ -60,6 +70,16 @@ if ( \( ret < 0 \| ret <= 0 \) )
> >> …
> >>> +if ( \( ret < 0 \| ret <= 0 \) )
> >>> +(
> >>> +-dev_err_probe(...);
> >>> ++return ret;
> >>> +|
> >>> +-return dev_err_probe(...);
> >>> ++return ret;
> >>> +)
> >>> +)
> >>
> >> How do you think about to use the following code variant
> >> for the adjusted SmPL disjunctions in the patch operation mode?
> >>
> >>  if ( \( ret < 0 \| ret <= 0 \) )
> >> (
> >> -dev_err_probe(...)
> >> |
> >> -return dev_err_probe(...)
> >> )
> >> +return ret
> >>  ;
> >
> > If this style works here, it doesn't always work,
>
> I find this feedback not so clear.

Normally, you can't put + code after a disjunction.  Because the two
branches of the disjunction might cause the matching process to end up in
two different places.

The fact that you are suggesting to do this seems to suggest that you
think that the Coccinelle semantic patch parser accepts this code.  But I
have no idea whether it does.  It should not in any case.

julia

>
>
> > so it is not desirable to put it in the Linux kernel.
>
> Can it be helpful to avoid a bit of duplicate SmPL code
> for the proposed transformation?
>
> Regards,
> Markus
>
--8323329-1780676318-1690905011=:3628--
