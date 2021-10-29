Return-Path: <SRS0=V3/9=PR=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F0C433F5
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 20:16:26 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59ABE60F56
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 20:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59ABE60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3ALC1kw66L6LtvLIxeS+Rw+gxRtCnGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0jRVxjEYCj/Vb66NNmP3f9kja4Tk8EsD6MTUmtFnGwA5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOi+xZVA/fvQHOOlULS?=
 =?us-ascii?q?VYnoZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57gY0gSS/jTOxKPgzxYQcBOgDAb/Hx0g/19baRGLx4J011lnPgooDlJnZe3Q?=
 =?us-ascii?q?gwoe6rTnukHexheCSB3e6NckFPCCSHl6JLMkhKun3zEhq8G4FsNFYYf8e12KWh?=
 =?us-ascii?q?U/vwZNj0XKBOOneS7xPS8UOYErs4iN9L6Mo03tXRpzDWfBvEjKbjIRKjM6Nlw0?=
 =?us-ascii?q?zI5h8QIFvHbD+IVYDwpblLfYhlLO14SE7oxme6pgj/0dDgwgF6cu6s7+G/VwAJ?=
 =?us-ascii?q?+1JDiNdPUfpqBQsA9tkqV4HnB4nbwRBodLtGZ1TuD2n2pj+7L2yj8Xeo6H6al8?=
 =?us-ascii?q?vp7qFKUwWMXBVsdUl7TifO0jEOyWtFDA0wZ+ywj67I1/0+wJvH2Wxq/u1aGvhU?=
 =?us-ascii?q?YXN1LVeY97WmlxqPS4gudQGwJXDVIbtsOsM4wTCYtkFiTkLvBDjx1saaJTmqds?=
 =?us-ascii?q?L2ToDO3JiERIWIYTSsFSwEE/5/op4Rbs/5lZr6PC4atlNr5XDXx2CyHtzVn1/M?=
 =?us-ascii?q?Si9QK3uO15zj6b/uXjsChZmYICs//BwpJNj9EWbM=3D?=
X-IronPort-AV: E=Sophos;i="5.87,193,1631570400"; 
   d="scan'208";a="1216757"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2021 22:16:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DD65E027E; Fri, 29 Oct 2021 22:16:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 44CD5E0072
	for <cocci@sympa.inria.fr>; Fri, 29 Oct 2021 22:16:21 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AN2zU16uSUXA47/Pek2do8vcO7skC24Mji2hC?=
 =?us-ascii?q?6mlwRA09TyXGraGTdaUguyMc1gx/ZJh5o6H7BEEZKUmsuqKdkrNhQItKOzOW9l?=
 =?us-ascii?q?dATbsSobcKpgeBJ8SQzJ8k6U4NSdkaNDSSNyk6sS+Z2njCLz9I+rDum8rE6Za8?=
 =?us-ascii?q?vhVQpGpRGsZdBnJCe3+m+zpNNW977PQCZf6hz/sCgwDlVWUcb8y9CHVAdfPEvc?=
 =?us-ascii?q?f3mJXvZgNDLwI76SGV5AnYqILSIly95FMzQjlPybAt/SzuiAri/JiutPm911v1?=
 =?us-ascii?q?y3LT1ZJLg9Hso+EzR/Bky/JlaAkEuDzYILiJaIfy+wzdZ9vfrmrCpeO85ivI+f?=
 =?us-ascii?q?4Dsk85MFvF+ScFkDOQrArGo0WStmNwx0GT+vAQgFkBepd8bUUzSGqC16NohqAM?=
 =?us-ascii?q?7Itbm22erJZZFhXGgWD04MXJTQhjkg6urWMlivN7tQ0VbWOPAIUh07D30XklWa?=
 =?us-ascii?q?voJhiKoLzP0dMeef309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhl?=
 =?us-ascii?q?xw9ArfZv00so5dY4Ud1J9u7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCaZIE?=
 =?us-ascii?q?jhFqsAJ3XRwqSHqokd9aWvYtgF3ZEykJPOXBdRsnMzYVvnDYmU0JhC4nn2MROA?=
 =?us-ascii?q?tPTWu7ZjDrRCy87BrYvQQFm+oQoV4rudSt0kc7/mZ8o=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397786553"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 22:16:20 +0200
Date: Fri, 29 Oct 2021 22:16:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luis Chamberlain <mcgrof@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <YXxGHEuS0zi+sbft@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2110292215580.3011@hadrien>
References: <YXxGHEuS0zi+sbft@bombadil.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Cannot infer Python version: when no /usr/bin/python
 symlink is found (resend)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 51
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110292215580.3011%40hadrien>



On Fri, 29 Oct 2021, Luis Chamberlain wrote:

> Debian and OpenSUSE Tumblweed no longer have the /usr/bin/python
> symlink, at least this is explained and spelled out on the Debian
> Python Policy [0]. This guideline specifically requests that scripts
> do not use `/usr/bin/env`, do not use `/usr/bin/python` and instead
> use the exact version desired.
>
> When running coccinelle on a system without this /usr/bin/python
> symlink Coccinelle will complain when using a python script on a cocci
> file:
>
> Cannot infer Python version
>
> Fixing this is just to create the symlink, but I *really* don't want
> to do that. And so I think we may need to support:
>
> script:python3
> initialize:python3
>
> Maybe it makes sense then to always look for python2 if a version is
> not specified, and if that does not exist look for python3 as new
> systems may not have python2.

Thanks for the report.

julia

>
> [0] https://www.debian.org/doc/packaging-manuals/python-policy/ch-python.html#s-interpreter
>
>   Luis
>
