Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD6C0218D
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mA87HQcQyHRcBCZ4RJbtnjvs1XVJb09L2CzD+k/FeS8=;
  b=Lg/nuL6ab57cpHVpay+F6Hq+p0W2FapGOokqwaVMeeqQk0nSFerHJZPG
   GUVT3TxsrjRTELgLltrHdx1e3VSneskwJCAy9XszPazy5KbqgFUN1N4+b
   TKQHE0n1u/YcY+p4IIc/+vQmTxGE3586ispfDugEx44YuTzHM1WopOWMF
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324681"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77E7AE0D2F; Tue, 28 Jan 2025 10:13:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 18DEEE0077
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 09:13:05 +0100 (CET)
IronPort-SDR: 67934b8c_+bOrmOgavcZjbi2mnjo9idfnNHvVjZS17os6vbLYwWWEyU9
 kcYv34fVsFV5sq1DdvfaK+H3660xITRIzKT5+xQ==
X-IPAS-Result: =?us-ascii?q?A0ESAAD0SpNnhUDyp9VaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVonDAcISASEUoNPhE5fiAxnA4E/nFmBfg8BAwENNBAEAQEDA?=
 =?us-ascii?q?QOCDIIuRgKKdQIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBQEmFew2CYgEzcYElAQEBAQEBAQEBAQEBAQEBAQEBARcCCAVeA?=
 =?us-ascii?q?QEdAQEBAQIBIw8BDQEBNwEECwsYAgIYDgICVgYTFAaCZwGCQSMHAQwGuGd6g?=
 =?us-ascii?q?TKBAYIMAQEGgQhQAw8v2gaBZAMGgRouAYVqgmMBhWuDfXonD4FVRIEVNYJCM?=
 =?us-ascii?q?z6CYQEChTo6gi+CM0uBJwKBVl4lZ4ZlhCyBPXQ7gSWBbYRnikNSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlIA4ESI4EmBTUKNzqCDWlJNwINAjWCHnyCK4IfgjuERYRThVuCF?=
 =?us-ascii?q?IFlAwMWEAGCNXJ7H4EoHUADC209NxQbnVw9gwo+NQE8JC0BEwgOAlAhIIECH?=
 =?us-ascii?q?wUGOpJAFIM7r000B4QegV0GDIoplS4ESYQEjQaZSZh8gliJM4F5lVCFKDGBZ?=
 =?us-ascii?q?zqBSQwHTSODAwEBMhM8AxkPjiEZH4NChRTAT0E1AgEBOAIHAQoBAQMJj3MtB?=
 =?us-ascii?q?YFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:RHQoVawRHSjZOshdZdHEKrPwL71zdoMgy1knxilNoNJuHPBws/
 re+MjzsiWE7wr5OUtQ/OxoXZPrfZqyz/NICOUqUYtKGTOW3ldAT7sSj7cKoQeBJ8SWzIc0vp
 uIMZIOa+EYZmIasS+V2maFL+o=
X-Talos-CUID: 9a23:DirkJ28F3GJyUcmVDkOVv20oJct5V0f690frIgjjIGZVd+C1T1DFrQ==
X-Talos-MUID: 9a23:licVRQZZBmtGseBT5hrN3j1EL8VU5Kn0JWEduIQCpOiFHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,230,1732575600"; 
   d="scan'208";a="204787404"
X-MGA-submission: =?us-ascii?q?MDE0PiLZBaxdRn5rbbcbqopdKQxtxNSBM2z9f5?=
 =?us-ascii?q?UdJEP+EjVA32EWiJLewfdlTmXm9oe4h9iNfauISE9AOqFoashq36arcC?=
 =?us-ascii?q?zG5q/dILgDlV5v9DHmh5PzQQOXER0EogcR3cugE0M1XssWCJXklXtA9W?=
 =?us-ascii?q?nCn9wZ0D3VlJWhpRi5hw6psA=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 09:13:00 +0100
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A0ACD01;
	Fri, 24 Jan 2025 09:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737706315;
	bh=idLhQQ+Oo5UWIbjsyxcdZEeHw78VV8pc1CNx0UgjdPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1VBjwyLb5/825+b7cVXFO9bdDNfsHPuG4v+5w/PShcuhYZnEGzMi4sgSuBT/t+Vl
	 81MAQ4hSpeZbPfdN5IsMI6Ow92B6XjP6sN03JQCziXIeLU58DsLBP6BFGAvkJAmmYb
	 XS3nweXjhRkr7hgNRjCVLoF07N3/estJlBU9pt94=
Date: Fri, 24 Jan 2025 10:12:50 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com,
	mripard@kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com, pawiecz@collabora.com,
	spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
	daniels@collabora.com, helen.koike@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
	airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
	groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Message-ID: <20250124081250.GA24731@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 2242
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250124081250.GA24731%40pendragon.ideasonboard.com>

On Fri, Jan 24, 2025 at 02:11:26AM -0300, Leonardo Brás wrote:
> On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
> > This patch series introduces "kci-gitlab," a GitLab CI pipeline
> > specifically designed for kernel testing. It provides kernel
> > developers with an integrated, efficient, and flexible testing
> > framework using GitLab's CI/CD capabilities. This patch includes
> > a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
> > additional YAML and script files, to define a basic test pipeline
> > triggered by code pushes to a GitLab-CI instance.
> > The initial version implements:
> >     
> > - Static checks: Includes checkpatch and smatch for code validation.
> > - Build tests: Covers various architectures and configurations.
> > - Boot tests: Utilizes virtme for basic boot testing.
> > 
> > Additionally, it introduces a flexible "scenarios" mechanism to
> > support subsystem-specific extensions.
> > 
> > This series also introduces a drm scenario that adds a job to run IGT
> > tests for vkms. This scenario includes helper scripts to build deqp-runner
> > and IGT, leveraging approaches from the drm-ci/mesa-ci project.
> > 
> > We are working towards creating a generic, upstream GitLab-CI pipeline
> > (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
> > is designed with a distributed infrastructure model, making it possible
> > to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> > backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > integration.
> > 
> > For an example of a fully executed pipeline with drm scenario set,
> > including documentation generation,
> > see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/1350262
> > 
> > Please refer to the documentation included in the patch, or check the
> > rendered version, here: 
> > https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
> > 
> > Differences from v1 to v2:
> > - moved to tools/ci as suggested by Linus on the previous version
> > - add arm64 containers for native compilation
> > - added boot tests using virtme: this is the base structure for boot tests,
> >   next steps would be adding other tests such as kselftests/kunit tests
> > - added DRM scenario testing on vkms: this should replace current vkms test
> >   in drm-ci. This work shows how a test scenario can be used by different
> >   subsystems to add their tests.
> > - update documentation
> > 
> > For more details on the motivation behind this work, please refer to the
> > cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/
> > 
> > [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/
> > [2] https://kernelci.org/
> > [3] https://docs.kernelci.org/kcidb/
> > 
> > Helen Koike (3):
> >   kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
> >   kci-gitlab: Add documentation
> >   kci-gitlab: docs: Add images
> > 
> > Vignesh Raman (2):
> >   MAINTAINERS: Add an entry for ci automated testing
> >   kci-gitlab: Add drm scenario
> 
> Hi Vignesh Raman,
> I am very happy to see this project going forward :)
> 
> It's been a few years since I first thought on finding a good way of helping
> kernel developers testing their patches, while making use of the free runner
> minutes Gitlab offers. It can greatly simplify the testing for people who are
> new to kernel development, or students trying to understand it better.
> 
> And this patchset allows that to happen :)
> 
> Actually, I spoke to Helen last year, and to enable it to run on the free
> Gitlab-CI runners, there is a small extra patch which is needed:
> 
> https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/

Gitlab as an open-source software project (the community edition) is one
thing, but can we please avoid advertising specific proprietary services
in the kernel documentation ?

> Could you please apply it on top of your tree?
> Some stuff changed places, but I can send a v2 with that fix if you want.
> 
> 
> While I have yet to review this v2 patchset, I applied it on my repo for
> testing, and cherry-picked the patch on above link, triggering a Pipeline:
> 
> https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600
> 
> It seems to be working fine, please check it, as you may be more used to the
> results.
> 
> Thanks!
> Leo

-- 
Regards,

Laurent Pinchart
