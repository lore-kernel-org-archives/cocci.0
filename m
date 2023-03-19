Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4436C6FD1F
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DiaqwX5fH9o20aB14mrQOTE3TZdlCFvOqLXxqAXqYz8=;
  b=Mi6ggBeRNEG9j17qbx8WgvhpgswPW7PSa0Fqa5qG1bb6GVhQWdb13TKb
   eFc8XXvSCfo/ZK3q7GqmOYrVAwPY2+KH5P1GsvrkBSxwDjhKkurFYGtod
   FLFqMqBI9Y6ZEX+S1w0jp1WInfglCehg0LmA9s4kWmMUYHGsDZICHac6R
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="97942964"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 15:14:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BF012E0D2D; Sun, 19 Mar 2023 15:14:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 459F6E0A9B
	for <cocci@sympa.inria.fr>; Sun, 19 Mar 2023 15:12:13 +0100 (CET)
IronPort-SDR: 64171828_4rrF4FphesxCZpZcwcL4TGGrrn58/tZ+BUZsHFIsIDmFwe3
 hNn1wm8fgCtorDExJZkLG4cLPRvEIDnZoqeq9mg==
X-IPAS-Result: =?us-ascii?q?A0EkAAChFxdkkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH1+GDIIlA5IZhWOFWIF+DwEDAQ1EBAEBAwSCC?=
 =?us-ascii?q?4JzAoU1Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEBAQEXCR4QDgUihWgNgjcpAXWBCAEBAQEBAQEBAQEBAQEBAQEBAQEWA?=
 =?us-ascii?q?g1SdwEBAQECASMPAQ0BATcBDwsUBAICJgICVwYTgn6COiMDA7JHeoEygQGCC?=
 =?us-ascii?q?AEBBp1KgV4JgRQsAZA5eicbgg2BFYMqPogcOYIujXOCeogjCoE0dYEgDoE9g?=
 =?us-ascii?q?QQCCQIRa4ESCGeBfUECDWULDnaBSwKBWzcDRB1AAws7Oj81FCEGWIEZJAUDC?=
 =?us-ascii?q?xUqRwQIOQYcNBECCA8SDwYmQw5CNzQTBlwBKQsOEQNPgUcEL4FaCgYBJiSdD?=
 =?us-ascii?q?QFSKBNMJoEHfQSSZbBxhASBWZ8TTBOBM4I3jGaGJUWRci6HLYpShT2oGoFiO?=
 =?us-ascii?q?oFcfQiDIk8DGQ+OIAwNCYhkimc/NDsCBwEKAQEDCYtDAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Guma7ahb8AxCMneskJP7ueukX161cxQKZh0ujC45NGQN5FlHY01je
 htvWTjXOfqOajD9e4wkYNjl80tU6sXcz4ViGwdvpCE2ECxjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqidUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYpdDNEg06/gEk35q+q42pJ5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGUE9xApA6osZLAXBPp
 PMfFTQAdVeIvrfjqF67YrEEasULIMf0epgYp2trwHfaAOwgTJSFRL/FjTNa9G5r14YXQqaYN
 5ZfM2MwBPjDS0Un1lM/DJ85ms+ri2P5fjker0iazUYyyzWLklQgjuS2WDbTUv+pYt1ek2K3n
 XLD33bSQQg6GebE8DXQpxpAgceUxHijBdpKfFGizdZhh1aYx0QIGRgOXB26p+O4gwiwQbpix
 1c89iQx67M16VagQ5/+Uge+rXrCuQQTMzZNLwEkwF2DjZXJwV65OmgVT29Ob+EiudRxTgV/g
 zdlgOjVLTBotbSUT1eU+bGVsS6+NEApEIMSWcMXZVBfvIay/+nfmjqKH4gzSPTv5jHgMWuoq
 w1muhTSkFn6YSQj+6y/+Vnc695HjseUFFFtjuk7s57M0++UTIKreMqz7kXB5vsGL4uDSFSF+
 n8elKByDdzi77nSzURho81XRdlFAspp1hWA3TaD+LF9q1yQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPd3gUpp2l/O4RIq4PhwxUjaoSsUoHONg1Hw0DXN8I0i2+KTRuf5nY
 szFGSpSJSxHV8yLMwZat89GiORzm3hmrY8ibYjyxBeqzfKeY2WJIYrpw3PTBt3VGJis+V2Pm
 /4Gbpvi40gBDIXWP3eGmaZNdgpiBSZgWvjLRzl/KrLrzvxOQzt6Wpc8ANoJJ+RYokiivryWr
 iDlBB8FmQCXaL+uAVziV02PoYjHBf5XxU/X9wR3Vbpx8yh8PdSc/+0EeoEpfLIq0uVmwLQmB
 7MGYsiMSLAHADjO5z1XP9G3oZ1AZSabo1uEHxOkRzwjIL9mZQjCoeH/ciXVqSIhMyuQtOkFm
 YOG6D/1e5Q4aj5ZPJ7kU873l1KVlloBqd12RHrNc4Vyel2z0Y1EKB7Rr/4QIuMWGyXh2wmly
 BucWjUehOjSor0a9MvCqrCEoryITcp/PBt+NEvK4YmmMRL1+jKY/rZBd+KTbBbhVG/Q04ezV
 9V/lv3THqUOowdXjtBaDb1u85Mb2/LugL1rliJfA3TBagWQOINKe3Wp85FGifxQ++V/pwCzZ
 0Oo/+taM5WvPOfOMgYYBCghX9S5+cAkoBvgxtVrHxyi/w5yxqSNbmtKNRrViCB9Eqp8ALl4/
 cgf4vwp+y6NoTt0FObelS1F1XW+HlpZWYUdi5wqKovKiA0q91J8XaLhGhLGuK+oVdEdHXQpc
 xm1hbXDjYty3kDtUWQ+PlmT0Pt/haYhggFrzlgDLg63i9DAuOQT2UxAwyUWVSVQ9A1MiMhoC
 1hoNmp0BKSAxChpj859RFKRGxlNKRma207pwX4LqTHpdFapXWnzM2ENA+aB00QH+WZ6fDIA3
 rWn5Ev6cDTtJufd4zATXBN7lvndUtBBzA3Ot8S5FcCjHZNhQz7EgLerVFUYuSncHsI9q03Wl
 9ZEpN8qR/XAChcRhKknB62x97caEkmELVMfZ8BRxvoCGGWEdQyi3TSLFVuKRfpMAP70oGuYE
 M1lI/xdWyuujBiuqi8pPo9SArtWssNw2v88VOLKH1MWi5qesTtjj7zI/AfcmmIAYotjgOQ9G
 KzrZhOAFW2iqkkPv2nrssV0GGiKWoQeVj3ewdKK7/gDTLAFkeBzcHMd1qm/kGWVPTBGoTOVn
 lLnTI3Hw9Nyzb9Dm9PXLZxCIAGvOPXPVOis2yKigeRkNN/gH5/HiFIIlwPBIQ9TA4o0Z/12s
 ra86PjMw0LPuecNYVDzwpWuOfFA2pSvYbBxLMnyEXh9mBmCUu/K5z8o2TixCb5NoeNnyviXf
 SmKQ+ruSodNQPZY/mNfVAZGGRVEC6jXULbplRngk9uyUCoiwS71B/L500+wYW9iI3pCf9W0D
 wLvoP+h6+xJtIkGVldOG/hiBIQ+O1P5H7cvc9rqrzSDE220mRW4t6D/kQY7oyT+YpVe/B0WP
 bqeLvQ/SPizhE0M5N1XrMppuQANB3s7guQqeE8ZvdlshFhWyYLAwfs1af075lN8y0QeF60Uo
 BnOYXEkBCG7Wi5LGfk5yMq2RR+RX4TiJf+gTgHEPCqoh+OeB46aBrZlsCB67B+av9clIP6Pc
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:ZlQAla+AyWVkBao3FJFuk+DdI+orL9Y04lQ7vn2ZhyY1TiW9rb
 HIoB19726TtN9xYgBFpTnkAsS9qBznmaKdjbN/AV7mZniehILKFvAG0WKB+UyCJ8SWzIc0vs
 1dmupFeb/N5DNB7foSjjPXL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50609643"
X-MGA-submission: =?us-ascii?q?MDHekmqDzYDBSQuwcqXaSn6V7AH5I01M20DG0E?=
 =?us-ascii?q?yaJ97LXQl5JhmR0N/mmDkbx5iYF69Ip+mIbWo6SlQdf2BofX0MhYl+tW?=
 =?us-ascii?q?PgE0On3OVXk3eB3Cjxxu1BfXeTiRkV7i8sikrWJAVKYjPfbzKhmuCieZ?=
 =?us-ascii?q?DUKAfnMlF5AGDBJxy6pfqKmA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 15:11:53 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7116103A;
	Sun, 19 Mar 2023 14:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD5DC433EF;
	Sun, 19 Mar 2023 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679235109;
	bh=4Tn2Ss9phxopbxFgWMyA7uMu+W0oT/yoY9aVfnSNDaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMGREStkA3/9TXlwXEPTO8uO4UQBOtiRUE2xSxPulA02IVbv9hjf7q/JYEO7W2Yka
	 OzgDsY6tVvKh5ZFco4r89eXsm/Ip6dogTNrpOad594tmLqdSs9FEu0YXqwSn98yifV
	 A40ZeFjeZyZUt8rduS6/s9+AGj6KiwrgKqPWrZiWQwIXzFLJlV2wEbrhDFbtWc4v9E
	 kCUq+KZfoTRMXVMD2gFWHtGOVeaQ7+gNjGL+0HQxRakeXtQVyjA/bFXLyzH5gWSz8R
	 x/f0XXot9pD2Vm9BqegeaEz1ybj1agq9tGE3FmzV+fsiY06kwxgKFckMnwNuS5qed2
	 ya090jvNppjUQ==
Date: Sun, 19 Mar 2023 16:11:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <20230319141145.GE36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
 <20230319114048.GB36557@unreal>
 <1c06e86d-1468-c11a-8344-9563ad6047b5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c06e86d-1468-c11a-8344-9563ad6047b5@web.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] RDMA/siw: Fix exception handling in
 siw_accept_newconn()
Reply-To: Leon Romanovsky <leon@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 900
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230319141145.GE36557%40unreal>

On Sun, Mar 19, 2023 at 02:38:03PM +0100, Markus Elfring wrote:
> >> Date: Sat, 18 Mar 2023 20:30:12 +0100
> >>
> >> The label “error” was used to jump to another pointer check despite of
> >> the detail in the implementation of the function “siw_accept_newconn”
> >> that it was determined already that corresponding variables contained
> >> still null pointers.
> >>
> >> 1. Use more appropriate labels instead.
> >>
> >> 2. Delete two questionable checks.
> >>
> >> 3. Omit extra initialisations (for the variables “new_cep” and “new_s”)
> >>    which became unnecessary with this refactoring.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Fixes: 6c52fdc244b5ccc468006fd65a504d4ee33743c7 ("rdma/siw: connection management")
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>  drivers/infiniband/sw/siw/siw_cm.c | 32 ++++++++++++++----------------
> >>  1 file changed, 15 insertions(+), 17 deletions(-)
> > Please read Documentation/process/submitting-patches.rst and resubmit.
> > Your patch is not valid.
> 
> 
> What do you find improvable here?

Did you read the guide above?

1. The patch is malformed and doesn't appear in lore and patchworks.
2. "Date ..." in the middle of patch
3. Wrong Fixes line.
4. Patch contains too much and too different things at the same time.

Thanks

> 
> Regards,
> Markus
> 
