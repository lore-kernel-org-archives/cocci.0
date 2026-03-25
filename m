Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D0B109C055
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=G6EjI+o4FWSqc3c797OBBQqeDflUwdW+v93p4StzRa8=;
  b=IQxPvwQ2Q/qpUDg2nvgqUbN5DEv3WSF8jQz/3Jzgu+CkZbROGXWRyKEw
   q51445KH55VtK2CkBDTnChN8LVf6jr7ll6jeHlR0TOCj8S4VRX8/wzZl9
   xkn5WMWADQ7q4JoFGFRl9WMOfCrlO1iaH3Ze6CXNUOGY2aJkxY5pHMLP3
   o=;
X-CSE-ConnectionGUID: 2ZCWKWEASve9vEFvZ5u5JQ==
X-CSE-MsgGUID: EyC5RdcyRc+W3mzCc+279A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269512593"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 19:30:48 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6167282F2F; Wed, 25 Mar 2026 19:30:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C34E782E82
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 19:30:41 +0100 (CET)
X-CSE-ConnectionGUID: pI7Q8FiWS8KpiU6CknyGvA==
X-CSE-MsgGUID: Ih5RKSr2Q2iwOcRkWUWgjg==
IronPort-SDR: 69c429d2_X9DoUGOSheLdDtqHjIjH15Ix+5Jetc4FwjrPYrtR9+y5DU7
 8CvWxhNUGL8FLl3yv/RkTmkedCYw9ghx1IxXlfg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GeAgA4KMRpg3yBCqpaFoJDghgpgQeBEgcISYgnhSyIe?=
 =?us-ascii?q?QMfnzs9Ag8BAwELAQE9FAQBAQMBAgGFAAKNJAIfBgEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBOQcOO4ZPDYJiNHFlCTcBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDX4BA?=
 =?us-ascii?q?QEDDwECKAYBATcBDwsYLhRINYJgAYIiB0oDAw4Go3sBjCQaNgEBAXaBNIEBg?=
 =?us-ascii?q?gwBAQaBCIFg2ykJgU2IVQGJdXonFQaBSUSEPz6BUoEPAgGFdIIvgiaBDoVcB?=
 =?us-ascii?q?oFGgmSHb1J4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFR9YGwcFEiEqg?=
 =?us-ascii?q?ScPhmV5Ay54DiICKBFcSj4LUgWCHQKBHSMDC209NxQbBI4NM4JxewEBIDCBb?=
 =?us-ascii?q?ZM5niGTWYE+BwOEHIwelToEFjOEBIFXkgM7klKZBhuJAIILgmOHXZMwAgoHG?=
 =?us-ascii?q?IF+JIFccBWDIglGAxkPjjqBGwEJgkKBPoNVw1pDNQIBOgIHAgcNAwuSHIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:p9Hcba/4fLAGm7YFkPluk+DDI+orL9Y04lQ7vn2ZhyY0TiX4ra
 2TdZsgtCMc5Ax6ZJhfo7690di7LU80nKQdieIs1NyZMzUO1lHYT72KlbGSoQHdJw==
X-Talos-CUID: =?us-ascii?q?9a23=3A870hUWo8SYo3RESrcdY2OMHmUdgELUSN4nbvGB+?=
 =?us-ascii?q?bEWdUFpaWT06/5ooxxg=3D=3D?=
X-Talos-MUID: 9a23:FwxRnApb9sHdR9pmliQezxBiaf1L2L70MRoMjrINgcq7CBN/OTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269512571"
X-MGA-submission: =?us-ascii?q?MDHSCRN2E/9Za66Wdn+zFHo5cB7BxODajxgS4i?=
 =?us-ascii?q?/WHUI79qljBM5sRKiUoKUUVW8h2sRcyG3sZlTxrl97j7eFGVyAbWmKqh?=
 =?us-ascii?q?qdyNg1LHfAlsD3uKpFT7mHUCPx6Z6wyvxiRFL/hx3VT8UBjL8yhts/tf?=
 =?us-ascii?q?Ojo2C+qOLOV0qCB5Yt6fcizQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 19:30:41 +0100
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-r3cVI1KlP2Wj7rngB3tbsQ-1; Wed,
 25 Mar 2026 14:30:37 -0400
X-MC-Unique: r3cVI1KlP2Wj7rngB3tbsQ-1
X-Mimecast-MFC-AGG-ID: r3cVI1KlP2Wj7rngB3tbsQ_1774463436
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7543918005BF;
	Wed, 25 Mar 2026 18:30:36 +0000 (UTC)
Received: from localhost (unknown [10.44.33.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B95741955D84;
	Wed, 25 Mar 2026 18:30:35 +0000 (UTC)
Date: Wed, 25 Mar 2026 18:30:34 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20260325183034.GB16430@redhat.com>
References: <20260325122401.GA16430@redhat.com>
 <9b85c0be-c08a-39d4-714-9be5e5ceea3@inria.fr>
MIME-Version: 1.0
In-Reply-To: <9b85c0be-c08a-39d4-714-9be5e5ceea3@inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 09p3DOTv_-sKF-T-tsiOUrc1FlNKcUq7_7_1qu-ICbg_1774463436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Current git URL
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 3455
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/9s6GY2Vh9dcseB8uERckzg>

On Wed, Mar 25, 2026 at 04:05:31PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 25 Mar 2026, Richard W.M. Jones wrote:
> 
> > Hi,
> >
> > We recently patched Fedora coccinelle to support pcre2.  One issue we
> > hit was that the website refers to the upstream git repository as:
> >
> > https://github.com/coccinelle/coccinelle/
> >
> > See for example the link here on what I assume is the correct upstream
> > website:
> >
> > https://coccinelle.gitlabpages.inria.fr/website/download.html
> >
> > However, upstream development (and the pcre2 patches) seem to appear
> > only on INRIA's gitlab instance.  We actually couldn't find the
> > patches or this git repo initially, as the coccinelle website doesn't
> > seem to refer to it at all:
> >
> > https://gitlab.inria.fr/coccinelle/coccinelle
> >
> > It'd be nice if this was fixed (or the github repo was synchronized).
> 
> I updated the github repository.

Great, thanks Julia.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

