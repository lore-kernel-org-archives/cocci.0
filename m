Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B70C04A95
	for <cocci@archiver.kernel.org>; Fri, 23 Sep 2022 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Gw11JBUdH21sSz2T27TsNO2xBRUcUC48YdF+GCrrulg=;
  b=a930nqnMjOrc8A04ATuAEkrUjqSrbU6kvnx3+JMeF5bwtNgqrLUzoL0e
   RbI9PnKlvSSIsLcfAZLana+yNcP7KHUTqkVhlwx7Zg+EzC7iDbs21BuiF
   NFFYeTyna7TeQlX7J7Teyf72P4VCV2YupNeKZTMkT7cirxrpsSodatEWS
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
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="54284327"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2022 19:08:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A0C6E0090; Fri, 23 Sep 2022 19:08:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 55176E0090
	for <cocci@sympa.inria.fr>; Fri, 23 Sep 2022 19:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Gw11JBUdH21sSz2T27TsNO2xBRUcUC48YdF+GCrrulg=;
  b=K32RGrEP2l++vR+o9aCVAdCDKWnpzHgPZIUKUeGxZF4gBNFygz6qJzQp
   Sw1mOgduwh/WtwtwY/um/bLxkIkHqMEU9uMQQreGszA6rYwkufJ5oGTh9
   wiGvf3s2ZQDVR0A8qtqqlUnp3pFCGDS9KTf/Badz2GdQ1R6ltCIWkdWPL
   M=;
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="24549723"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 19:08:44 +0200
Date: Fri, 23 Sep 2022 19:08:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1@web.de>
Message-ID: <54938aa-3629-2bc2-edc-cc1b3246866@inria.fr>
References: <20220922115535.44132-1-yuancan@huawei.com> <20220922115535.44132-2-yuancan@huawei.com> <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de> <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr> <6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-444471677-1663952923=:3931"
Subject: Re: [cocci] [v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 577
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/54938aa-3629-2bc2-edc-cc1b3246866%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-444471677-1663952923=:3931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 23 Sep 2022, Markus Elfring wrote:

> >>> +@r3@
> >>> +identifier s, fld;
> >>> +position p != {r2.p};
> >>> +@@
> >>> +
> >>> +struct s {
> >>> +  ...
> >>> +  struct mutex fld@p;
> >>> +  ...
> >>> +};
> >>
> >> How many mutexes (or spin locks) should be initialised before further data
> >> processing can be safely performed with corresponding structures?
> > I tried the semantic patch on this file:
> >
> > struct s {
> >   struct mutex fld;
> > };
> >
> > int main () {
> >   struct s *mm;
> >   mm = kmalloc();
> >   mutex_lock(&mm->fld);
> > }
> >
> > and it reported the expected error message.
>
>
> This test result might be nice.
>
>
> > So what exactly is the concern, Markus?
>
>
> I just suggest to check once more if it would be really required to determine
> the position for a data structure member twice (as proposed by the SmPL rules
> “r2” and “r3”).
>
> Would you like to compare the data processing for a SmPL code variant
> like the following?
>
> @find_member@
> identifier s1, s2, f;
> position p;
> @@
>  struct s1
>  {
>  ...
>  struct s2 f@p;
>  ...
>  };
>
> @show_member@
> identifier s1, s2, f;
> position p != find_member.p;
> @@
>  struct s1
>  {
>  ...
> *struct s2 f@p;
>  ...
>  };
>
>
> # How do you think about the handling of multiple members within data structures?

There should be no problem with this.

> # How much does it matter here that curly brackets are used for a proposed SmPL constraint?

I have no idea what "How much does it matter" mean.  {} are used because
that's how struct types are declared.

>
>
> I got another development concern for the presented algorithm.
> Why is a data initialisation function call searched in the first SmPL rule at all?

Because he wants to find the fields for which mutex_init is already called
and to not report messages for them.  That is the whole point of the
semantic patch.

julia

>
> I imagine that potentially missing function calls can be determined also
> by other approaches.
>
> Regards,
> Markus
>
>
--8323329-444471677-1663952923=:3931--
