Return-Path: <SRS0=2JM+=OZ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BFCC433F5
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 12:12:43 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF82A61186
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 12:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF82A61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532140981"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2021 14:12:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E847E0154; Tue,  5 Oct 2021 14:12:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BEC3E010C
	for <cocci@sympa.inria.fr>; Tue,  5 Oct 2021 14:12:33 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=rjones@redhat.com; spf=Pass smtp.mailfrom=rjones@redhat.com; spf=None smtp.helo=postmaster@us-smtp-delivery-124.mimecast.com
IronPort-PHdr: =?us-ascii?q?A9a23=3Ads02XhHoJTCnN5Xpk2djcZ1Gf2hLhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31BmYBM6GtLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s?=
 =?us-ascii?q?/gQhBEqG8WfCEf2f7bAZi0+G9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQp?=
 =?us-ascii?q?yO+/5BpPeg9642uys55HfeQFFiCeybb5yLhi9sBncuNQRjYZ+MKg61wHHomFPe?=
 =?us-ascii?q?+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4TadFDDs9KGA6+NfrtRj?=
 =?us-ascii?q?YQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0zVjq/8qdrUwfoh?=
 =?us-ascii?q?zkbOD4l/m/Xjclwg7haoBKnuhdzx4HZbYWQOPd4Y6jTf84VRXBZU8hfVyJPHJ6?=
 =?us-ascii?q?yYYgAAOUPIelXspLwp0cSoRakGQWgGPnixiFOi3Tr3aM6yeMhEQTe0QAuA9wOs?=
 =?us-ascii?q?WjbrNXvO6cITO++0anHwS/EYf9MxDzz7I/IchY/rvGXU757bM3cyVMtFwPCiFW?=
 =?us-ascii?q?ft5flMiiP1usTrmeb7/BvVf61h2E7rAFxpyGiy8ExgYbGmowb0ErL9TllwIkrP?=
 =?us-ascii?q?924TlZ2bNCgHZZOqy2XNI97T90tTWxmtis3xaEKtIKmcSYE1JgpyBHRZuCJfoW?=
 =?us-ascii?q?W/h/vSOScLCp3iX9kdryymwu+/Ee8xuD6S8K63lFKri9fndnNsHAAzxLT5daaR?=
 =?us-ascii?q?ft65Eeuwy6P1xrU6uFGP087ibbbJ4Qmwr4qmZofqV7DETHrl0X2lqCWal8o9fS?=
 =?us-ascii?q?v6+TiernnqJicN5VphQHmKKQhhNe/Af8iPgcSWGib/OKx36Dg803hWLhGkOA6n?=
 =?us-ascii?q?6jDvJzEOcgWprS1DxFa34o59hqzETir3MwGkXUbKF9JYg+Lgob3N13UPfz1Dvm?=
 =?us-ascii?q?yj06jnTpt2vvIJKfuAo/XIXjGiLrhfahy60pbyAcr0NBf/ItYCqoEIPLvQk/9r?=
 =?us-ascii?q?cHXAQE9Mwy13eboFs9914MHVW6SHKOUP7nesVqJ5uIqPeaDeJUauC3hK/Q/+/H?=
 =?us-ascii?q?uino5lUccfamvw5QXdGi1Eup7L0iYe3bgnMsNHGcQsgYgQ+HmkkCOXSBcanqqW?=
 =?us-ascii?q?qIz/DA7CIaoDYfZQYCthaSM3D25Hp1RYGBJFEuMHGzyd4qaRvgMaDidItN7njM?=
 =?us-ascii?q?YUrihTpct1Quyuw/i17pnMu3U9zUEupLkyNd6++zTmAop9T10CsSdy3uCQ3t1n?=
 =?us-ascii?q?mMOXT823bpwrVZzyleZguBEhKlTEtdY5ttIVB07PNjS1b9UEdf3D0j7f9yJQUy?=
 =?us-ascii?q?qCurgJHd5bNU3zsREKxJnGdKkgwvrxSemA7YJ0beMAcpnoernw3HtKpMlmD793?=
 =?us-ascii?q?647ggx6E6On2kW8i6J//hSVDInMwRzxf0eCaL9ZxyvR7CKPwG6PokxCQUspC/m?=
 =?us-ascii?q?DWHEaa0Dftsi/7UTHHefG4VEPKAZNyceebKBNb4+x5Wg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdVOTQKit5At8g+L6rPIyi+8EHnBQXq8ji2hC?=
 =?us-ascii?q?6mlwRA09TyX2rayTdZgguCMc9gx+ZJhIo7npU5VoKkmyyXca2+MsAYs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ALAQCYahphh3wYzdhaFgYBAQEBAQEHA?=
 =?us-ascii?q?QESAQEEBAEBQIFZgiR+gRExjUuGRaALCwEDAQ01DAQBAYdOAh0HAQQ0EwECBBU?=
 =?us-ascii?q?BAQUBAQECAQMDBAETAQEBAQsNDgg6JIVoDYI1DIQaKAYBASwMdH6CTwGDBw+aD?=
 =?us-ascii?q?QGMYwEBAXaBM4EBggcBAQaCWYUpCYE6jHl6JxYGgUlEhAqCQIEQBBiCE4UuhVE?=
 =?us-ascii?q?BVnuTFJknkh0HA4Moij2TewQWK4NlgUiQHAw3kGmiT4Zokh+Bd4F9cBU7gmkJC?=
 =?us-ascii?q?T4ZDo4gGYNZhRSFS0ABATA4AgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0ALAQCYahphh3wYzdhaFgYBAQEBAQEHAQESAQEEBAEBQIF?=
 =?us-ascii?q?ZgiR+gRExjUuGRaALCwEDAQ01DAQBAYdOAh0HAQQ0EwECBBUBAQUBAQECAQMDB?=
 =?us-ascii?q?AETAQEBAQsNDgg6JIVoDYI1DIQaKAYBASwMdH6CTwGDBw+aDQGMYwEBAXaBM4E?=
 =?us-ascii?q?BggcBAQaCWYUpCYE6jHl6JxYGgUlEhAqCQIEQBBiCE4UuhVEBVnuTFJknkh0HA?=
 =?us-ascii?q?4Moij2TewQWK4NlgUiQHAw3kGmiT4Zokh+Bd4F9cBU7gmkJCT4ZDo4gGYNZhRS?=
 =?us-ascii?q?FS0ABATA4AgYLAQEDCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532140933"
X-MGA-submission: =?us-ascii?q?MDFmmCUbzhlYRxERiOE4fCWd/c+9xPuKGFTWuu?=
 =?us-ascii?q?+Nc7Rm8oN3kDf4YpbtE2WcPc2ujiszqJJ1XNiF2opZLxfcIpGRZ1Kw3E?=
 =?us-ascii?q?jxIgk3JOgYfq4hVk2AVSpIVCYArcW4dNqLuFZjgXYCJByXSrhotXdQLA?=
 =?us-ascii?q?pY7mS3iMHwIRccdSSXR8574A=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 14:12:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633435927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=AJysmTgS4pDjP4FsNb2X5VXmkBz3pNV25YvhECAzo5E=;
	b=TGm918Rlc3NnvZtgjkiVWFQLiEz55pUAqjsUqZ9OMjuFyP1rkwIJN8ok3YfkEKZxCJp+8b
	Pkf89WEvd+EFEhnqTLlwVCFEpwZBakV/w0m9RmswQ0XSriIsvSEW9CS1k3VvXVasbqfTau
	eKPYjQKlGE6bnG45PY4JaEVT342hAPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-2-cgBXo_P8SUeYjs6HmppQ-1; Tue, 05 Oct 2021 08:12:06 -0400
X-MC-Unique: 2-cgBXo_P8SUeYjs6HmppQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7791802C80
	for <cocci@inria.fr>; Tue,  5 Oct 2021 12:12:05 +0000 (UTC)
Received: from localhost (unknown [10.39.194.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58E5B1F42F
	for <cocci@inria.fr>; Tue,  5 Oct 2021 12:12:05 +0000 (UTC)
Date: Tue, 5 Oct 2021 13:12:04 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: cocci@inria.fr
Subject: Build failures, possibly 32 bit only, with OCaml 4.13.1
Message-ID: <20211005121204.GQ7596@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 20
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/20211005121204.GQ7596%40redhat.com>

[resending to the new mailing list]

Hi Julia,

https://koji.fedoraproject.org/koji/taskinfo?taskID=76740903

I observed build failures with OCaml 4.13.1.  They manifest as
segmentation faults.  Unfortunately it's not easy to get the core
dump, but I might be able to get a stack trace later.  Apart from that
you can look at the build logs by clicking through the red links above
and going to "build.log".

The common factor may be 32 bit platforms.

We (Fedora) don't really care too much about cocci on 32 bit since
it's a development tool and every developer these days has a 64 bit
machine.  (It could of course be something unrelated to 32 bit)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

