Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A3BC54EE9
	for <cocci@archiver.kernel.org>; Tue, 20 Sep 2022 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vGxAyppGXyEU2AzP84/v7G8msZbpwOxvLEQBoVVJYqo=;
  b=UtTxjDMr0S3gpZCDhXVd/rsjeKQWxMNhu8eD0AfsoeVuP/WHymSJ9VxW
   +nZj1u5CayFfpnZ7TnGSNF53mxLR2YqmcTTz6X6Glc6qBmEJIvQBf3hfE
   PVU7OOBWt5lkVbAUVguClh1Y7nbVI7Y70pUY9mMY8oOaLm/ZdyMy2gLrv
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="5.93,330,1654552800"; 
   d="scan'208";a="53662558"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Sep 2022 15:47:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01D85E019E; Tue, 20 Sep 2022 15:47:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 63F7AE039E
	for <cocci@sympa.inria.fr>; Tue, 20 Sep 2022 15:46:55 +0200 (CEST)
IronPort-SDR: 6329c44f_OS0WyMjjoxZy0b80/BWBRZdxQwI29adilNwukeFqEJuyuZQ
 hlIdkz3EYyvLBNgcOiwcptLkv7aSm/sFH+dbRFg==
X-IPAS-Result: =?us-ascii?q?A0BqAwDbwyljh3yBCqpaFnOBT4IkgQGBBAQLRQONSYVxg?=
 =?us-ascii?q?iUDnSSBaAsBAwELAQEsDwcEAQGBU4JtRQKEagIdBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEYCRcHDhAFIoVoDYI1KYNlAQEBA?=
 =?us-ascii?q?wERKAYBATcBDwsYLhQUNRMJEAmCWwGDIAMQnhQBjGkBAQF2gTSBAYIIAQEGg?=
 =?us-ascii?q?UABgR+FCQmBPo8seicWBoFJRIEVgyo+gVOBDwICAReBLIQogi6ZAjgDGSsdQ?=
 =?us-ascii?q?QMLQjQYAxQDBSQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk04CAQIB?=
 =?us-ascii?q?CskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQVZEAkhH?=
 =?us-ascii?q?A4aDQUGEwMgbwUKOw8oMmsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSL?=
 =?us-ascii?q?QcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMDECI9BgMJAwIkW3k3ExUFA?=
 =?us-ascii?q?w0ZJggFIxYeBAg8AgUGmFiBH4FNPCMBIjuBYAuuEkeTIgcDg1aLN40Dh18EF?=
 =?us-ascii?q?jKDdoFQkSEMOINBjhiXCo05hymNSjWEWwIEAgQFAhaBdySBW3AVO4IzAQEBM?=
 =?us-ascii?q?QlFAxkPjjmDWYUUhUtANAIBCDACBgsBAQMJinoBAQ?=
IronPort-PHdr: A9a23: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
 Y8L65ZZdqQ=
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:9NQAxapeuI94AK/qxa0FRV8aV5pMeYIsimQD101hICG9Ffb2qy
 nOppkmPHDP+VUssR0b+OxoW5PtfZq/z+8W3WB5B97LN2PbUQCTQr2Kg7GD/wHd
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,330,1654552800"; 
   d="scan'208";a="53662126"
X-MGA-submission: =?us-ascii?q?MDGEh9nn+w+5zoSACdvkvIq/awRfZWW8UBQWIH?=
 =?us-ascii?q?Y0plb7Ftu/v8b0FCZ5y6NGH//2xbxamKSSDRw+CRa/eiioB/NIZNgWYX?=
 =?us-ascii?q?UbNgwMfvnRX7P8+017m8psxeJItf9Y1ljo+bJXGKiT6kKKv7RD+PbV7W?=
 =?us-ascii?q?SejRNBq2DEY7fDIJZi7wrmmw=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:46:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663681614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vGxAyppGXyEU2AzP84/v7G8msZbpwOxvLEQBoVVJYqo=;
	b=IACsrx5RAFXVXupUTX2Y/+Fqi/dducBKWdPr9qr1KsblJgeTaa/9QrKkg2ix+IcT7aQOLZ
	MB0piuPhoGglryBDS5EIuQiVsCorCijoYWuZyBqHx0ytjaLY1p7arECKQVri7vk1aCrDS/
	jrm9olwo1U5b0J56qbPDLa+17RT3ghs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-wtcaqkZGPZeM1owNwb_oyA-1; Tue, 20 Sep 2022 09:46:50 -0400
X-MC-Unique: wtcaqkZGPZeM1owNwb_oyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AF9D80029D;
	Tue, 20 Sep 2022 13:46:50 +0000 (UTC)
Received: from localhost (unknown [10.39.192.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD1A31410DD7;
	Tue, 20 Sep 2022 13:46:49 +0000 (UTC)
Date: Tue, 20 Sep 2022 14:46:48 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20220920134648.GA19609@redhat.com>
References: <20220722192327.GA28597@redhat.com>
 <alpine.DEB.2.22.394.2207222129160.2321@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2207222129160.2321@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] pcre vs pcre2
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 560
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220920134648.GA19609%40redhat.com>

On Fri, Jul 22, 2022 at 09:30:44PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 22 Jul 2022, Richard W.M. Jones wrote:
> 
> > PCRE (not PCRE2) is end of life: http://www.pcre.org/
> >
> > and may be removed from Fedora:
> >
> >   https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/K3BUC6T5VIG7LXOV4RVFO7IUPE2LGA2J/
> >
> > It seems as if coccinelle has an optional dep on PCRE enabled/disabled
> > through ./configure --enable-pcre-syntax.  It's not entirely clear to
> > me what Fedora would lose by disabling this.
> >
> > Does coccinelle plan to move to PCRE2?
> >
> > I have moved a few projects over to PCRE2.  It's definitely not an
> > automatic conversion, although it also wasn't especially difficult.
> > Here's libguestfs.  This is mostly C and we maintain our own PCRE
> > bindings for OCaml which are not based on Markus Mottl's bindings, but
> > it should give you an idea of the changes:
> >
> >   https://github.com/libguestfs/libguestfs/commit/82493579f38f39769861f31403ccfb8e97b41f96
> >   https://github.com/libguestfs/libguestfs-common/commit/0b244f2b0cfc920f2432f5df45e108583f0d2901
> >
> > We decided not to support alternate PCRE or PCRE2 compiles since all
> > distros have provided PCRE2 for a long time.
> >
> > Also:
> >
> >   https://github.com/mmottl/pcre-ocaml/issues/25
> 
> Thanks for the warning.  I don't think Coccinelle (the implementation)
> actually uses PCRE in any important way.  It just makes PCRE availble to
> the user for writing semantic patches.  I will look into how we can
> convert (or at least make PCRE2 available as an additional option).
> 
> julia

To follow up, here's the Fedora bug:

https://bugzilla.redhat.com/show_bug.cgi?id=2128281

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

