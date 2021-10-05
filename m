Return-Path: <SRS0=2JM+=OZ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F1AC433F5
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 14:02:02 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664726023D
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 14:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 664726023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532175988"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2021 16:01:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 87D68E0154; Tue,  5 Oct 2021 16:01:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D9EFAE010C
	for <cocci@sympa.inria.fr>; Tue,  5 Oct 2021 16:01:55 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=rjones@redhat.com; spf=Pass smtp.mailfrom=rjones@redhat.com; spf=None smtp.helo=postmaster@us-smtp-delivery-124.mimecast.com
IronPort-PHdr: =?us-ascii?q?A9a23=3A8cD5Ph+qOGTlqv9uWcq7ngc9DxPPW53KNwIYoqA?=
 =?us-ascii?q?ql6hJOvz6uci4ZAqOvL4w0xfgZsby07p8ke3YsqTtCyQrwK2qlzQ8SqFKTAIPk?=
 =?us-ascii?q?s4MngYtU4avAEz/K+P2PWRhRJwRHFBq8GumPkdLBc3we0PdomGo7T4VBx7zKRd?=
 =?us-ascii?q?5Kv76F4LMk8i7zeS/94DcbwhIhje2fK9/IgixoQjNrMcdnJFsKrw2yhvHo3tIf?=
 =?us-ascii?q?/pZyGZ1Ll+NnBjy+9m98od7/ytfp/wu+chAUb7nf6sjVrxXEC4mM2Eu68L1sxT?=
 =?us-ascii?q?IUBaC6WEdUmUSlRpIHhTF4RTnVZr/rif2quxw0zSBMMboUb47Ryit76ZzSB/pl?=
 =?us-ascii?q?igHMSI58HrKgcB0la5XvQ6tqwB6z4PSZ46bKed+frjFfdwEWWVBQshfVytEAoy?=
 =?us-ascii?q?mbosPCfcKMeJXooT5olcDqwa1CwuxC+P10jJGiH/407Mn3eoiHwHJ0w4vENwSv?=
 =?us-ascii?q?3vJt9j1KLseXPqpwKXU1zjPcfVb0ir95ojSdRAhpOmBUbxsf8rQ1UYvFxnKjk+?=
 =?us-ascii?q?Npof4PzyZzOMDv3KG5ORkUuKvjXAoqxp/rjOywcoskIvJhoUTyl/a7iV025w1K?=
 =?us-ascii?q?sOlR057e9GkDIFcuD2dN4tzW84vRXxjtykmxLMco5G7YDQKx4o9xx7Zc/GKboe?=
 =?us-ascii?q?F7x3+WeqMLjl1h3JrdKy7ihuv/kas1+LyWMm73ltLsyZIkcXBu3QC2hHR6cWKS?=
 =?us-ascii?q?/Rw80ih1zuP1w3e6v9JLEYpnqTVLJ4hx6Q/lpsVsUnbEC/5hlj5jKiMdko+4ui?=
 =?us-ascii?q?o8ePnYrf4qZCAK494kAb+Mr4hmsCnG+Q3LBUBX2iB9uSgzrHs4Ur5QLBSgvw4l?=
 =?us-ascii?q?anZqo3VJdwBpqGnGA9VyZwv5Aq4DzejyNgYmXgHI0lKeBKakYfpIE3OIP7jDfu?=
 =?us-ascii?q?lhFSsijhryvbbNbPiGpXANmXPnbX9cbpn9kJQ1BA/wc1R6p9aEL0NPez/V0Dpu?=
 =?us-ascii?q?NDGEhM0Nxa4z/vpBdljzI8SRGGCD6GDPK7dt1KD+/ghLPOWZIAPvTbwM/gl6OD?=
 =?us-ascii?q?qjX8+gVIdYLKp0YIMaHC9AvRmO1yVbmfyjdcFEGcKoBQxTPbqiVGbTDJfeXm/U?=
 =?us-ascii?q?7g55jE6DYKpE5vMSZq2gLydxiu0AppWZmVeBlCNF3fnaZmEVu8RZC+QPsNtiCE?=
 =?us-ascii?q?IWaS7R4M82xyjuhX2x6d5Iufb4iEYsIjs1Nlx5+3djxEy8jl0AtyH02GPSGF0m?=
 =?us-ascii?q?H0HRyQt0aBlv0Ny11eD3rJkg/BCCdNT4PZJXh8gNZHA1+x6F8zyWgXZc9iVT1a?=
 =?us-ascii?q?pXsmpATAqQ9Iqw94OZl59FM+4ghDC2SqqGb4VmKaRCJw66KKPl0T2cuRgz3fPn?=
 =?us-ascii?q?I0okFAiRoMbN3Cih6c58wHMDorNu0SfjaejM6oGin3j7mCGmCC0vUpYWRR8GZq?=
 =?us-ascii?q?DeDZXREzQoM+zrhfYTbioBK8PKAZNyceebKBNb4u63h19WP7/NYGGMCqKkGCqC?=
 =?us-ascii?q?EPNm+rkhGXCYWgR3CzBTkMDllJKlZ5jHRIzCieovyTVCzk8TToHgmvx6qxlrW+?=
 =?us-ascii?q?jC0M5ywCUYldwkuPvplgQhPmRQPoIwvQPvyJz811J?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGzlsJ6+5Rzz4nyxCrUFuk+G2db1zdoMgy1kn?=
 =?us-ascii?q?xilNYDRPeM2ZiMyi2NwHvCWEyQr5g0tQ2expWsG7K080kKQZ3WB/B8bFYODZgh?=
 =?us-ascii?q?rcEGgP1/qa/9UPcxeOuNK0+89bAuND4ffLfBBHZV6Q2nj2Lz4YqOP3vJxBb4/l?=
 =?us-ascii?q?vj1QpHhRGuxdBmRCe3ym+y9NNXJ77MECZe7skfavzgDIER96Aarbdx44to741q?=
 =?us-ascii?q?32fb3dEGg77nUcmXizZEaTmcLH+m+jr2gjul10sM8fGVauqX2L2kzaiYDH9jbs?=
 =?us-ascii?q?k0nJ75pXn9PljvZmLPenzvMYIDP2h2+TFcdcs7bphkFGnAhD0idIrDDXmWZEA+?=
 =?us-ascii?q?1Dr0nJdmXwmxHqwAWI6kdN15b98y79vVLT5fPwQTI2A9dAg4UceQux0TtfgDii?=
 =?us-ascii?q?6sJ29lPcsJwSBQjLnSTj67HzJlhXqnY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BRAACYahphh3yFCqpaFgUBAQEBAQEBA?=
 =?us-ascii?q?QUBAQESAQEBAwMBAQFAgVmCJH6BETGNS4ZFgiQDnWQLAQMBDTUMBAEBhGECgms?=
 =?us-ascii?q?CHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQEBCw0OCDokhWgNgjUpg2UBAQEDE?=
 =?us-ascii?q?igGAQEsCwEPCxguFEk1gk8BgwcPmg0BjGMBAQF2gTOBAYIHAQEGglmFKQmBOox?=
 =?us-ascii?q?5eicWBoFJRIQKMD6BUoEQBBiBN4Ncgi6EF4E6AYEAgUSSIZknkh0HA4Moij2NM?=
 =?us-ascii?q?4ZIBBYrg2VCgQaQHAw3kGmiT4ZojQWFGoF3gX1wFTuCaQkJPhkOjiAZg1mFFIV?=
 =?us-ascii?q?LQAEBMDgCBgsBAQMJhzCCRQEB?=
X-IPAS-Result: =?us-ascii?q?A0BRAACYahphh3yFCqpaFgUBAQEBAQEBAQUBAQESAQEBAwM?=
 =?us-ascii?q?BAQFAgVmCJH6BETGNS4ZFgiQDnWQLAQMBDTUMBAEBhGECgmsCHQcBBDQTAQIEF?=
 =?us-ascii?q?QEBBQEBAQIBAwMEARMBAQEBCw0OCDokhWgNgjUpg2UBAQEDEigGAQEsCwEPCxg?=
 =?us-ascii?q?uFEk1gk8BgwcPmg0BjGMBAQF2gTOBAYIHAQEGglmFKQmBOox5eicWBoFJRIQKM?=
 =?us-ascii?q?D6BUoEQBBiBN4Ncgi6EF4E6AYEAgUSSIZknkh0HA4Moij2NM4ZIBBYrg2VCgQa?=
 =?us-ascii?q?QHAw3kGmiT4ZojQWFGoF3gX1wFTuCaQkJPhkOjiAZg1mFFIVLQAEBMDgCBgsBA?=
 =?us-ascii?q?QMJhzCCRQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532175974"
X-MGA-submission: =?us-ascii?q?MDGHktu80woYiU6G/AeDsHXS6BT3XOTPnu+ZZX?=
 =?us-ascii?q?96bNMRUO+vl6evahfU7QOMYQy+JQvYqYOGPDkl9qtvJ0rucK1p+7rpdb?=
 =?us-ascii?q?B3wv0DTO+U+bJ0hDuWxX+h61efr2ImjfYH1vPnARMyi/uRFdqDerIrVG?=
 =?us-ascii?q?rS5kzxhFbonQSNKWa/yns/GQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:01:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633442513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6S022bvR2W86R4d2xF3/XFZvWhwkpbQd8W9CPyQysQ8=;
	b=bAF+eMuYFH0wK/AQE/zmD7VhBW7KY91d/HrLRmcNP9PjWDSGyDIzTBpmUxgg5NhLlYg9JN
	B2Xtl5CsbR8ufC/hXXNZ3V+o7B82auvbCUPwqPnKah9Gc/4kKxW+kGaE94CxiHSlBpsN9a
	IiTG6lid6S7SVILFU/FW8porfQ2sugw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-0oL-NZX1NHeBPXCPaqMCMg-1; Tue, 05 Oct 2021 10:01:46 -0400
X-MC-Unique: 0oL-NZX1NHeBPXCPaqMCMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DDA09126F;
	Tue,  5 Oct 2021 14:01:45 +0000 (UTC)
Received: from localhost (unknown [10.39.194.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E132F5D9DE;
	Tue,  5 Oct 2021 14:01:44 +0000 (UTC)
Date: Tue, 5 Oct 2021 15:01:44 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Subject: Re: Build failures, possibly 32 bit only, with OCaml 4.13.1
Message-ID: <20211005140144.GB25685@redhat.com>
References: <20211005121204.GQ7596@redhat.com>
 <alpine.DEB.2.22.394.2110051545350.6871@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2110051545350.6871@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 23
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/20211005140144.GB25685%40redhat.com>

On Tue, Oct 05, 2021 at 03:45:56PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 5 Oct 2021, Richard W.M. Jones wrote:
> 
> > [resending to the new mailing list]
> >
> > Hi Julia,
> >
> > https://koji.fedoraproject.org/koji/taskinfo?taskID=76740903
> >
> > I observed build failures with OCaml 4.13.1.  They manifest as
> > segmentation faults.  Unfortunately it's not easy to get the core
> > dump, but I might be able to get a stack trace later.  Apart from that
> > you can look at the build logs by clicking through the red links above
> > and going to "build.log".
> >
> > The common factor may be 32 bit platforms.
> >
> > We (Fedora) don't really care too much about cocci on 32 bit since
> > it's a development tool and every developer these days has a 64 bit
> > machine.  (It could of course be something unrelated to 32 bit)
> 
> Thanks for the report, I will see if something can be done.

After saying all that I noticed there's a newer version available,
and upgrading actually fixes it:

https://koji.fedoraproject.org/koji/taskinfo?taskID=76743322

I didn't notice any particular change that mentioned "32 bit".
So that's .. strange, but at least it's fixed!

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

