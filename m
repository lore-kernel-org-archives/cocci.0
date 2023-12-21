Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E76C35274
	for <cocci@archiver.kernel.org>; Thu, 21 Dec 2023 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8tzB+3gvU1Kdb1jeIVrCxjBnk/DtVD1cbE7FASuWwdQ=;
  b=gHMV2zwTBLLkx4CHQoduBSMP345zvm0KoOBR4D0zk7rpl1q+ywYqegkA
   mSNiQ3FouIimx+yGlmWz8sI/z3XdDILMY91ytf1yYou0SoJ/lbRCCDvPT
   01BWkikMRThSMQk7iqoNK7cMSBxJ8vyNe6E+/PmuG/lgxwIHqburp9/zu
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143496943"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2023 10:51:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2C85EE0CCC; Thu, 21 Dec 2023 10:51:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AFF65E004E
	for <cocci@sympa.inria.fr>; Thu, 21 Dec 2023 10:44:59 +0100 (CET)
IronPort-SDR: 6584091c_wH4BlxpzU050/hmo+sgeKCcAPcmah0eia1sOPxKRNSZSv6h
 RiUPCWDsRXbF2rEQXclRuPeB2PJ29FSVd1H9X0Q==
X-IPAS-Result: =?us-ascii?q?A0HCAACPCIRl/ys0N8BaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIQKAeBSjEEC0iUFIF1MJ4VgSw+DwEDAQ1BAQIEAQEDBIR/Aoc0A?=
 =?us-ascii?q?h4GBjMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFbA2CX?=
 =?us-ascii?q?AGBHFgHCTYBAQEBAQEBAQEBAQEBAQEBAQEBAQEUAg1cAQEeAQUnGQEBNwEPC?=
 =?us-ascii?q?xguVwaDE4JgA64JgQEzgQGCCQEBBoJlsBYJgUgBiBoBhXCDOHongiiBFScLA?=
 =?us-ascii?q?4J1PoQphl2JHQcygh2DUJF/WyJGcBsDBwN/DysHBDAbBwYJFBgVIwZQBCghC?=
 =?us-ascii?q?RMSQIFdgVIKfj8PDhGCPis2NhlIgloVQUp1ECoEFBeBDwRqGxIeNxEQFw0DC?=
 =?us-ascii?q?HQdAjI8AwUDBDMKHQshBVYDQgZJCwMCGgUDAwSBMAUNHAIQGgYMJwMDEkkCE?=
 =?us-ascii?q?BQDOwMDBgMKMQMwVUQMTwNpHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ2E?=
 =?us-ascii?q?QkLKAMsBjgCEgwGBgleJhYJBCcDCAQDVAMjdhEDBAoDFAcLB1wDCQMcEANEH?=
 =?us-ascii?q?TYKAgELbT01CQsbbaZOYIE4gSsdommBQ6EwB4QUoRgGDwQvqgyYTahjgXkng?=
 =?us-ascii?q?VlwgzdPAxkPjiAMFoEKAQiCQ497QjI7AgcBCgEBAwmFRgEBg1qBQQEB?=
IronPort-PHdr: A9a23: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
 EPv
IronPort-Data: A9a23:Log9o6yAngnSTc69vp96t+cDwyrEfRIJ4+MujC+fZmUNrF6WrkUFm
 DMbDWqPbK2MMGegKNx1bYm3909TvpTQzIVjQAJrpFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjg2Ic3l48sfrZ80o15q2q4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFOx8dtiAxgQMLdIwdtmUUpC5
 O4YBx0kO0Xra+KemNpXS8Fpic0mJcjveoIZpnxkizreCJ7KQ7iaEv+MuIIegW122psm8fX2P
 6L1bRJuaAzHJR9GIEkWDp84tOOpgGTvNTxetF+R46Ew5gA/ySQojOOxYYeMJ4XiqcN9vkajr
 E7epT7CJgghaeS57huh0GK8ibqa9c/8cMdIfFGizdZuiUKawmg7GhwTX0Gy5/i/kE+3HdxFQ
 2Qf/SElrIAp5UmzR5/8WQe5qTiKpHYht8F4FuIz7QiMzuzV5RqUAi4PSTsphMEaifLajAcCj
 jeh9+4FzxQ22FFMYSPNqOWnvnmpNDILLGQPQyYBQEFXq5PguYw/xFaHBNpqDKf/3JW/FCDS0
 gK6inE0p4wSqsoXiIS931TM2Ay3qrbzEwUa2wTwX0Ce1D1fWrKLXYKTxGb+0edhN6ecF1mIg
 2gFkZOR7ccIFpC8qxaOS+QsQpCsvvC0D2TciGFwApAeqmyfxGG+TNoB/BB/O0ZbHcIWchD5Y
 ELomF1w5b0CGFCIfKNIc4aKJMBy9pfZFPPhTeHyUtpCRrNTZT231nhiSmDI1l+8jXV2t780P
 KmqVPqFDFEYOPxB9yW3TeJM6o0b7Hky6k2LTK+q0in996SVYUOUbrI3MFGuSOQdx4HcqSX39
 +dvDee7+y99YsbfPBaOqZUyKGoUJ0cVHZr18sxbVtCSKzpcRV0ONaXj/qMDSadEwYJuieb6z
 lOsUBR5yX3+p0H9ByekV3RBUI7rDLFD9S8VHCp0Jlu5+WkRUaD25oclSpYHV70G9uti8P1Kc
 8c4a/iwWvRidzCW1AkePL/crZNjfiuFnQihHTSoSxlhco9CRz7mwM7FfAzu/gYKEyaHutY3n
 OD45DzEXKtZFhhDDdnXWt2r3VierXgQo8Msfkrqc/14WlTgz5huEAP11sQIGsArLQ7R4xejz
 COUPEsonvbMqIoL79X5v6CIgIO3Ge9YHEABPW3kwZupFCvdpEyP/JRhVbuWQDXjS2/EwqWuS
 uFLxfXaMvdcvlJrsZJ5Iol735AF+NrjiL9L/DtKREyRQQyQNYphBX2a0e1klK5HnOZZsDTrf
 HO/wIBRPLHRNf71FFIUGhEeUd2C8vMpgRjX0+U+JRTrxS1w/Yffa35oATu3tHV/Iod2YaQf+
 sVwnO4N6ge6tAgmDcbesABQ6Fa3DyIhV4cJi8gkJbHF2yQXzmNMW5j+MhPNwYquboxMO3Y6I
 zXPi6vlga9d93X4cHEyNCbs2PpFj5Iw5DRPyEIOCGqSvt/jmPUM/QZw9A4vRV9/1SR30ONUO
 0lqOXZqJK6IwSxauchbU02oGCBDHBe86GWp73cozUr3F1KJUE7JJ00DYde9xlgTqT9gT2IK7
 YOmx3bAehe0WsPIhw8Ze1Nv8t7nRvxPrjzyotitRZm5LsNrcAjeo/GcYEQToEHaGuI3vkrMo
 Ndq8MtWaaHWMS0xobUxO7KF1IY/GQy1G2hffc5PpK85P3nQWDWX6wi8L0qcfsBsJfuT1WSaD
 8doBNxEVjXg9SKogw0YO5UxIO5PrKZ03OYBR7LlGzdX+f/X5D9kq4nZ+SXClXcmCYcm29o0L
 oTKMSmOCCqMjH9TgHXAt9RAJnH+W9QfeQngx6qgxY3lzX7YXD1EKineE4dYvkl59CNi8BuRt
 QLHIa7Q0+Fmj49rmuMA10mF6xqccbvOuCagqWhfcOiiqfvLMMHTp0UUrEXqO0JdOr55txGbU
 1iSmIaf4a4G1Yral0jdmp+cB+9I49m/WKxcNcefwLy2W8edcJeE3ibvMFxU5XCEfB2xKyVnq
 8aFhBOMSOMo
IronPort-HdrOrdr: A9a23:Rj015Kvbvq53+IbD+em2WK+k7skDS9V00zEX/kB9WHVpm62j5r
 qTdZEgviMc5wxhO03I9erwWpVoBEmsk6KdgrNhRotKPjOWwVdARbsKheeD/9SjIVyHygc379
 YGT0ERMqyUMbE8t6nHCQ+DebtPoeWv+qrAv5a780tQ
X-Talos-CUID: 9a23:+eKAYm9z8BqKygh+LIOVvxMmNMwqK1vQ9ifrHl7oImp4Wr26ZHbFrQ==
X-Talos-MUID: 9a23:1UdLGApjgnYBJ6kGtacezxFiD81E+/70M2QUqsg+ne6lEQ5gKzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143495151"
X-MGA-submission: =?us-ascii?q?MDEirsAgS/YtDjV6wBTdKmI5xYyDE+nL0bDh1G?=
 =?us-ascii?q?eZDutOAI2QOewsnVe7ntDZscZ+hlyVsKNoYG0lsBQ/7jTbBJlaG1m3Lg?=
 =?us-ascii?q?gnPBrytnzlUFPrn+4s1/xhTuA0PlMVVxTRVHUxmobi/Bb9jKK7SNqO1D?=
 =?us-ascii?q?T+yLNLCnQNStclu9JJe/HYrw=3D=3D?=
Received: from mgamail.intel.com ([192.55.52.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:44:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703151899; x=1734687899;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mqVu2KIx+O/wQSJPa99TQYKrQwmLaMYgU6Lr/FlcN1I=;
  b=Q/4nQN7kkAPH5J9MjnRCt3+ByrHVVSHwEiPix1sC9shua67WnP3m9vy4
   jWtV6GjX1hWzrptEuFtZHwveu++b/6CYYaMTwtKWP7GcZToi9xZ+1FX8U
   japbPx3iVfAztnCH3xFIWGqE/i9lJiTXV9Bs7NMUwI0WLAV7ANH7rY7CS
   g5g8TlD2GqDackIbzTxxen6qPIBfhmDPplT8D+Zrhy2u9Dycg9shT/Izy
   8blPOh7X2bkDgPcItswfowu3PdOqMqzGQKr2PDGCHZw0SM8l44/8MNClI
   R4c9GW8gwblD35zIKbbhiYKXErMjuvohuIGvH2VmNwcNpR1uZhFuZ1Q2+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482130097"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="482130097"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:44:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="780142364"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="780142364"
Received: from mmzakhar-mobl2.ccr.corp.intel.com ([10.252.51.198])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:44:34 -0800
Date: Thu, 21 Dec 2023 11:44:31 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <155979e7-bf8-a7da-4762-749cb9eba1d@inria.fr>
Message-ID: <7dde285a-3255-b58b-43ca-8a185e42fc10@linux.intel.com>
References: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com> <155979e7-bf8-a7da-4762-749cb9eba1d@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1664534084-1703151875=:1641"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Spatch corrupting struct variable
Reply-To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1354
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/7dde285a-3255-b58b-43ca-8a185e42fc10%40linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1664534084-1703151875=:1641
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 21 Dec 2023, Julia Lawall wrote:
> On Thu, 21 Dec 2023, Ilpo Järvinen wrote:
> 
> > Hi all,
> >
> > I'm at total loss what coccinelle/spatch is trying to do here:
> >
> > @@
> > struct resource *res;
> > expression size;
> > @@
> > - res->end = res->start + size - 1;
> > + resource_set_size(res, size);
> >
> > Spatching against Linux kernel tree results in this corruption:
> >
> > HANDLING: drivers/bus/fsl-mc/fsl-mc-bus.c
> > diff =
> > diff -u -p a/fsl-mc-bus.c b/fsl-mc-bus.c
> > --- a/fsl-mc-bus.c
> > +++ b/fsl-mc-bus.c
> > @@ -736,7 +736,7 @@ static int fsl_mc_device_get_mmio_region
> >                         goto error_cleanup_regions;
> >                 }
> >
> > -               regions[i].end = regions[i].start + region_desc.size - 1;
> > +               resource_set_size(regions, region_desc.size);
> >                 regions[i].name = "fsl-mc object MMIO region";
> >                 regions[i].flags = region_desc.flags & IORESOURCE_BITS;
> >                 regions[i].flags |= IORESOURCE_MEM;
> >
> > ??? How did that [i] vanish from regions? Why spatch thought . and -> are
> > equal?
> 
> There is an isomorphism that does that.  Maybe it should be removed...
> 
> In any case, you can put @disable ptr_to_array@ in place of the initial @@
> in your rule.  Or if your rule has a name, put the disable ptr_to_array
> after the name.

Thanks for the quick reply. Adding disable ptr_to_array indeed helped. :-)

-- 
 i.

--8323329-1664534084-1703151875=:1641--
