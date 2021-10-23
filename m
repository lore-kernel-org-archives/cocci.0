Return-Path: <SRS0=evXM=PL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E48C433F5
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 17:01:29 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3EA60F46
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 17:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD3EA60F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=outflux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3A1yK6la/Y4Lw6VBtB+IPzDrUDonyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUog3jJVz2NLCmHUa//YY2Kjft90aIq38BwPsJLXn9ZjGldlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OkUrW?=
 =?us-ascii?q?cYEideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3qd1UDBL/UJwmHzHRMM0SgqkEY9mpjieBiaqBaMBkP49mKt4kZJNFlvpu7Q?=
 =?us-ascii?q?gZsObLKlf41Uh9CEig4M7cuFLrveCLu7pLPp6HBWz62qxl0N2k9OpcV/Pp2Byd?=
 =?us-ascii?q?C+LkDLy0fZziCgfi3yfS1UIFRam4LRCXwFJsFvX0lyTDCEfs9XMmTBaTM/95Rm?=
 =?us-ascii?q?jkq7v2i1M32P6IxAQeDpjyZC/GXBmoqNQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="129765"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2021 19:01:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B950DE0018; Sat, 23 Oct 2021 19:01:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CEFF7E0018
	for <cocci@sympa.inria.fr>; Sat, 23 Oct 2021 19:01:21 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=kees@outflux.net; spf=Pass smtp.mailfrom=kees@outflux.net; spf=Pass smtp.helo=postmaster@smtp.outflux.net
IronPort-PHdr: =?us-ascii?q?A9a23=3ArqhwNB3Arz2Fxn/XsmDOxwMyDhhOgF0UFjAc5pd?=
 =?us-ascii?q?vsb9SaKPrp82kYBaHo6Q0xwKWFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkel?=
 =?us-ascii?q?M8NlBYhCsPWQWfyLfrtcjBoVJ8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZ?=
 =?us-ascii?q?pO+j5AIHfg9qr2+yo/5DffgpEiTq/bLhvMBi4sALdu9UMj4B/MKgx0BzJonVJe?=
 =?us-ascii?q?+RS22xlIE+Ykgj/6Mmt4pNt6jxctP09+cFOV6X6ZLk4QqdDDDs6KWA15dbkugf?=
 =?us-ascii?q?FQACS+3YTSGQWkh5PAwjY8BH3W4r6vyXmuuZh3iSRINb7Rq4oVzu886hrSQfoi?=
 =?us-ascii?q?CYZOD4/7GHXkdF7gKZCrB68uxBz34vYbYeIP/R8Y6zdZ8sXS2RBUMhPSiJODIG?=
 =?us-ascii?q?zb4UMAeUOIelWoJLwp0cXrRu7GQWgGPnixz1Oi3Tr3aM6yeMhEQTe0QIlAd0Br?=
 =?us-ascii?q?m/Up8jrOacVVuC1z7TDwDLAb/xIxzj985PFchc8ofGQU7JwddfRyEY1GwPDkFq?=
 =?us-ascii?q?QtZXoMjWI3esCr2aV9fBvVf6zi2E5sQFxpCCiytsyhoXXm44Z1kzJ+CV2zYopO?=
 =?us-ascii?q?9G1SU12bcCrHZVetCyXOY97T8I+T2x2pCs3xb8LtJClcCUW1Zkr2wPSZv2JfYW?=
 =?us-ascii?q?O/xntWuGRITJii3JkfrKynxKy8Um4yuD9TMW03kxKojJEktnKrHAN1gbc5tKJS?=
 =?us-ascii?q?vtn5kuh2iiA1xrV6u5aJUA4j63bK4QuwrM2i5EdslzDEzfrlEjyj6KabFgo9+e?=
 =?us-ascii?q?o5uj9Y7jrqYWQO5J1hwzwNKklh9axDv4iMgcUWmiW4eS826Pn/U3+WLhKlfg2k?=
 =?us-ascii?q?rXBsJzAIsQbu7K5AwFR0oY+5BezFTGm38oEnXUfLVJFfgyIj5TxNl3TJP31Du2?=
 =?us-ascii?q?zj0mjnTpr3fzLP7LsDo/QInXCnrrtZbN95FRdyAo3w9Bf/ZVUCrQZLfLwRED+q?=
 =?us-ascii?q?sfYAwQ+Mwyp3+bnBtF91p4RWG6VBK+WLr/SvUeS5u0zO+mMeJMVuDHlJvc54P7?=
 =?us-ascii?q?hkWM2mV4GcKmy3ZoXbWi4Ee58L0WYZ3rsmNYBHn0QsgowVuzgkEeCXiJLZ3auQ?=
 =?us-ascii?q?6I84Sk2CIa8AobNXI+thLiB0Ty6H51XY2BJEUqMHm3ye4WFXfcMciOSLdV7njw?=
 =?us-ascii?q?KT7jyA7MmgDOzsA7zg55uMePQ/mVMt4/n1dEz4+TMnBU23T1yFcWUlW+XGSU8v?=
 =?us-ascii?q?GQFDwc7xqt/rFc1nlWE3IBgjuZTFdFIofhOV1FpG4TbyrlZBt3pEinGedTBHFW?=
 =?us-ascii?q?rT86OBiwtQNYs05kIblorSIbqtQzKwyf/W+xdrLeMHpFht/uEhxAZxu5mzmrek?=
 =?us-ascii?q?q48k1ciX9sJM2C61PcXH+f7AJPVnUGEh+CseLhOhUYlEU+E0HaAuFxIFgh9Tfe?=
 =?us-ascii?q?dNU0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ap3CQ1qxbLw6aGwAZe+MRKrPw671zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZImPH7P+VEssRQb8+xoV5PsfVrx8oF45I8JMfOeWmDdyR?=
 =?us-ascii?q?DYVvAenPffKlHbdxEWs9QttpuIEJIObOEYb2IK6PoSiTPQe70dKZu8gcKVbIzl?=
 =?us-ascii?q?rkuFIzsEV0gt1WdEIzfeM2FSYmB9dOIEPavZwupiixetdnwRYICVBnwZU/Orna?=
 =?us-ascii?q?yzqHqLDCR2eCIa1A=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CPAwASaxphfaNAkcZaHgEBCxIMQIFOC?=
 =?us-ascii?q?4MiVgE6MYRHiQSGRYInhBiZTAsBAwELAQE1DAQBAYRhAoJrAh4GAQQzBg4BAgQ?=
 =?us-ascii?q?VAQEFAQEBAgEDAwQBEwEBGlAkhWgNgjUpAYNjAQEBAQIBIx0BASwLAQQLCxgCA?=
 =?us-ascii?q?iYCAjwbBgENBYJxAYJmIQUKpnJ6gTGBAYIHAQEGglmDT4FaCSNtKoleG4MAeic?=
 =?us-ascii?q?cgg2BPByCYj6ERIMXNoIuhVEBlDyOUp0bgzKBN4kGlBomgTuCKoFIoUiWEYIei?=
 =?us-ascii?q?iCYXgIKBxaBdiOBWzMaCCYKOyoBgj4JRxkOjiCFMIMbO4VqIQMvAjYCBgsBAQM?=
 =?us-ascii?q?JiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0CPAwASaxphfaNAkcZaHgEBCxIMQIFOC4MiVgE6MYRHiQS?=
 =?us-ascii?q?GRYInhBiZTAsBAwELAQE1DAQBAYRhAoJrAh4GAQQzBg4BAgQVAQEFAQEBAgEDA?=
 =?us-ascii?q?wQBEwEBGlAkhWgNgjUpAYNjAQEBAQIBIx0BASwLAQQLCxgCAiYCAjwbBgENBYJ?=
 =?us-ascii?q?xAYJmIQUKpnJ6gTGBAYIHAQEGglmDT4FaCSNtKoleG4MAeiccgg2BPByCYj6ER?=
 =?us-ascii?q?IMXNoIuhVEBlDyOUp0bgzKBN4kGlBomgTuCKoFIoUiWEYIeiiCYXgIKBxaBdiO?=
 =?us-ascii?q?BWzMaCCYKOyoBgj4JRxkOjiCFMIMbO4VqIQMvAjYCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397173507"
X-MGA-submission: =?us-ascii?q?MDGTe+zrnWahRY24ye6N8m517PFvInOmUGU+tE?=
 =?us-ascii?q?tfcFkvELLq1wsaRZqy/l+SQgtv2iumONFm/yaoZWesRXFT/dLyb1ZSRl?=
 =?us-ascii?q?H0dviYHM9vB8zeOo3UXGwF6UMAWPII/4J/srM7cCqBHAOe8ilyZ5mQNp?=
 =?us-ascii?q?ElvQdNSs96Z6WqmuYoz8crIw=3D=3D?=
Received: from smtp.outflux.net ([198.145.64.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 19:01:19 +0200
Received: from auth (localhost [127.0.0.1]) (authenticated bits=0)
	by vinyl.outflux.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id 19NH1G5h005724
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 23 Oct 2021 10:01:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=outflux.net;
	s=2016010; t=1635008477;
	bh=HJ2FncMHXdeq3iIGAPXeJDeLV4Lnj+hYTF/49t+Z+9c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fNh/nv9ZPjanHdgdCokXr2RwOvIe9RGMJtg8FbshdSd8ihtnQGVCachF1Bu/cbwoj
	 CoJJHLfOZmhwIHAhM42fzFlgzMkA8ykpmftAXAPzUNM76knGW3oQlu1ETgFKvoV481
	 PfA/62brKmME66TtoITSArAZ3v8DrK4swlWsj5cs=
Date: Sat, 23 Oct 2021 10:01:16 -0700
From: Kees Cook <kees@outflux.net>
To: Julia Lawall <julia.lawall@inria.fr>, Joe Perches <joe@perches.com>
CC: cocci@inria.fr, linux-kernel@vger.kernel.org
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.22.394.2110231758550.2967@hadrien>
References: <alpine.DEB.2.22.394.2110231758550.2967@hadrien>
Message-ID: <6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: [127.0.0.1]
Envelope-To: linux-kernel@vger.kernel.org
Envelope-To: cocci@inria.fr
Envelope-To: joe@perches.com
Envelope-To: julia.lawall@inria.fr
X-Scanned-By: MIMEDefang 2.83
Subject: Re: [cocci] update Coccinelle entry
Reply-To: Kees Cook <kees@outflux.net>
X-Loop: cocci@inria.fr
X-Sequence: 28
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45%40outflux.net>



On October 23, 2021 9:01:18 AM PDT, Julia Lawall <julia=2Elawall@inria=2Ef=
r> wrote:
>Update mailing list and website=2E  Drop Michal Marek as a maintainer, wh=
o
>has not participated in a long time=2E
>
>Signed-off-by: Julia Lawall <Julia=2ELawall@inria=2Efr>
>
>---
>
>For information=2E  This will be in my tree=2E
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7d46f03e5037=2E=2E8746149b6623 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -4594,10 +4594,9 @@ COCCINELLE/Semantic Patches (SmPL)
> M:	Julia Lawall <Julia=2ELawall@inria=2Efr>
> M:	Gilles Muller <Gilles=2EMuller@inria=2Efr>
> M:	Nicolas Palix <nicolas=2Epalix@imag=2Efr>
>-M:	Michal Marek <michal=2Elkml@markovi=2Enet>
>-L:	cocci@systeme=2Elip6=2Efr (moderated for non-subscribers)
>+L:	cocci@inria=2Efr (moderated for non-subscribers)
> S:	Supported
>-W:	http://coccinelle=2Elip6=2Efr/
>+W:	https://coccinelle=2Egitlabpages=2Einria=2Efr/website/
> T:	git git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mmarek/kbuild=
=2Egit misc

Perhaps drop this tree and add yours, too?

> F:	Documentation/dev-tools/coccinelle=2Erst
> F:	scripts/coccicheck




--=20
Kees Cook
