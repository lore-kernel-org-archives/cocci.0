Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367D9C02192
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hwcqabfdudhgcdl/kTTyBcMVfx1DoKTUBQMDa/gXfOo=;
  b=lWzxlTjDdNXUucDN/1JdXNpBHKSUadMF0gAYzO0Ec87aZH1XDPGjcdK8
   GcG9fMCS48JSGU8CAp2+gmi8HCc/vDNBwAjYbXbQNoFBSUvadZIe9Oemy
   L1o7PX310y5/ipSjioSyZxdyPWft/IWSOX2D6Lt8SZLG6SSw02kCKSYpR
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205533914"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 10:33:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 355A6E0D1F; Wed, 29 Jan 2025 10:33:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E4B16E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 10:33:09 +0100 (CET)
IronPort-SDR: 6799f5d5_/ZR7l2AIv1Gh6B++jl4oYeVN7G1iaQYmifyss2cKA9dQHo9
 DPk9c7oIH6k25O4aAKojBAuw9+ZctM1jOrSa1oA==
X-IPAS-Result: =?us-ascii?q?A0EmAADa9JlnhcNp+5RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVozBAtIBIRSg0+ETocygXQtA4Q7jQ6MToF+DwEDAQ00DQECB?=
 =?us-ascii?q?AEBAwEDggyCLkYCinUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAUBJhXsNgmIBM3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?ggFXgEBHQEBAQECASMPAQUIAQE3AQ8LGAICJgICVgYBCggCAQEQBoJoAYJBI?=
 =?us-ascii?q?wIBBQwGs256gTKBAYIMAQEGgQhQAw8v2gaBZAmBGi4BhWqCYwGFa4N9eicPg?=
 =?us-ascii?q?VVEgRUnC4JFMz6CYQECAYU5gmmCM0p6LQKBVl4lZ4Zmgw2BH4E7dDuBJYFtg?=
 =?us-ascii?q?VyDC4tFUnscA1ksAVUTFwsHBYEpSAMqNjEjgSYFNQo3OoINaUk6Ag0CNYIef?=
 =?us-ascii?q?IIrawQFgS2CO4RFhFGFW4IUgWUDAxYQAYI1cngcgiwdQAIBC209NwkLGwY9n?=
 =?us-ascii?q?Wc9gxARLTQBATwkLQETCA4CBEwhIA9dBw8fBQY6kkAUgzuMXoIdoFI0B4Qeg?=
 =?us-ascii?q?V0GDIoplTMGEy+EBIFXiy+GTpJ7mHwigjaIWlmBeZVQC4UdMYFnOoErHgwHM?=
 =?us-ascii?q?xojgwMBATIJCjwDGQ+OIRkfg0KFE8UJOzUCAQE4AgcBCgEBAwmFRgEBih0tB?=
 =?us-ascii?q?YFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fmKlqqF/noIXxdfjpLqE0ceALOsnbusQ8zAXPo5KOH9om7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmxyXcY2/h0AV7mZniAhILKFu5fBOnZrgEIcheWnoRgPO
 VbAspD4bbLbGSS4/yb3OD1Kbgd/OU=
X-Talos-CUID: 9a23:HN5vRW1Wsl7SzjzHaNIAcbxfHtsKKnD0lVrqLlaxDFhIRZyNcWWP5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AYYt2PQ0747t+0WFOh1cTrf5EODUj546hUGRVk7s?=
 =?us-ascii?q?965eJDAohPyu+nRGrTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205533896"
X-MGA-submission: =?us-ascii?q?MDFzhfzHwqugxRnqGVUQuHRnTTq59mL4Nqbq5b?=
 =?us-ascii?q?h+ERPbqhat4xn3CdhSPlMDrexLpDc0zRESRnqLe7k9xxdfevIKvbVuva?=
 =?us-ascii?q?qRx48c7X4rQKGFo4FfGocd9Z2rGPV86Teff9cRAlgTW3j1i9eIFdaoHw?=
 =?us-ascii?q?67XN6cnjVCrbbjbabVZ67y+g=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:33:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738143188;
	bh=rF2QEfMpgRURa/Nr9ID5fEOyfE/6x7j6OMBvAS0duAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=huxgjh8MA2s8jdfqP46FkoeTWT6nNkC3K/UUPZYFld3yHhBrdBtFj99lDEv/xUKUn
	 Lq7mAU9zMnCIsvM02zBTExclPzvc7RYKFN2WShLcOFVh1xMC6utFbw5eREhvmZ4Mb7
	 9hmFkScaDZbSybDqeNV4W+AIBbQ8LyNoFeen8bbGxvEwdP2dn7aBEcjAe+txsdPvD+
	 tQXIxBdBWaoT5KxFCJ9QOkzYgiIJ0INW+8GQRffX0YSR6fFF8bBlonZcr/OqOBsd7m
	 Jfwq1ocHDX3bn1NIIdFUEwg0JlooV6KmoxPxKTeL/s/3wyBf7razJQHr3IJJnO7CEI
	 YQv6GdN1dOTdQ==
Received: from [192.168.50.250] (unknown [171.76.83.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C07B317E00F6;
	Wed, 29 Jan 2025 10:33:00 +0100 (CET)
Message-ID: <446c3583-ba95-4021-83ca-1e112edf5b22@collabora.com>
Date: Wed, 29 Jan 2025 15:02:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
 nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
 Julia.Lawall@inria.fr, laura.nao@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, helen.koike@collabora.com,
 shreeya.patel@collabora.com, denys.f@collabora.com,
 nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
 hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
 airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org, groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi, jarkko@kernel.org
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <6ebd1551-017f-4b31-b235-829b2735d78f@collabora.com>
 <a6816a68e5e9aeb1d330b68f6a73decd2233c164.camel@gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <a6816a68e5e9aeb1d330b68f6a73decd2233c164.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2303
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/446c3583-ba95-4021-83ca-1e112edf5b22%40collabora.com>

Hi Leo,

On 28/01/25 00:35, Leonardo Brás wrote:
> On Mon, 2025-01-27 at 13:02 +0530, Vignesh Raman wrote:
>> Hi Leo,
>>
>> On 24/01/25 13:42, Laurent Pinchart wrote:
>>> On Fri, Jan 24, 2025 at 02:11:26AM -0300, Leonardo Brás wrote:
>>>> On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
>>>>> This patch series introduces "kci-gitlab," a GitLab CI pipeline
>>>>> specifically designed for kernel testing. It provides kernel
>>>>> developers with an integrated, efficient, and flexible testing
>>>>> framework using GitLab's CI/CD capabilities. This patch includes
>>>>> a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
>>>>> additional YAML and script files, to define a basic test pipeline
>>>>> triggered by code pushes to a GitLab-CI instance.
>>>>> The initial version implements:
>>>>>       
>>>>> - Static checks: Includes checkpatch and smatch for code validation.
>>>>> - Build tests: Covers various architectures and configurations.
>>>>> - Boot tests: Utilizes virtme for basic boot testing.
>>>>>
>>>>> Additionally, it introduces a flexible "scenarios" mechanism to
>>>>> support subsystem-specific extensions.
>>>>>
>>>>> This series also introduces a drm scenario that adds a job to run IGT
>>>>> tests for vkms. This scenario includes helper scripts to build deqp-runner
>>>>> and IGT, leveraging approaches from the drm-ci/mesa-ci project.
>>>>>
>>>>> We are working towards creating a generic, upstream GitLab-CI pipeline
>>>>> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
>>>>> is designed with a distributed infrastructure model, making it possible
>>>>> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
>>>>> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
>>>>> integration.
>>>>>
>>>>> For an example of a fully executed pipeline with drm scenario set,
>>>>> including documentation generation,
>>>>> see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/1350262
>>>>>
>>>>> Please refer to the documentation included in the patch, or check the
>>>>> rendered version, here:
>>>>> https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
>>>>>
>>>>> Differences from v1 to v2:
>>>>> - moved to tools/ci as suggested by Linus on the previous version
>>>>> - add arm64 containers for native compilation
>>>>> - added boot tests using virtme: this is the base structure for boot tests,
>>>>>     next steps would be adding other tests such as kselftests/kunit tests
>>>>> - added DRM scenario testing on vkms: this should replace current vkms test
>>>>>     in drm-ci. This work shows how a test scenario can be used by different
>>>>>     subsystems to add their tests.
>>>>> - update documentation
>>>>>
>>>>> For more details on the motivation behind this work, please refer to the
>>>>> cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/
>>>>>
>>>>> [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/
>>>>> [2] https://kernelci.org/
>>>>> [3] https://docs.kernelci.org/kcidb/
>>>>>
>>>>> Helen Koike (3):
>>>>>     kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
>>>>>     kci-gitlab: Add documentation
>>>>>     kci-gitlab: docs: Add images
>>>>>
>>>>> Vignesh Raman (2):
>>>>>     MAINTAINERS: Add an entry for ci automated testing
>>>>>     kci-gitlab: Add drm scenario
>>>>
>>>> Hi Vignesh Raman,
>>>> I am very happy to see this project going forward :)
>>>>
>>>> It's been a few years since I first thought on finding a good way of helping
>>>> kernel developers testing their patches, while making use of the free runner
>>>> minutes Gitlab offers. It can greatly simplify the testing for people who are
>>>> new to kernel development, or students trying to understand it better.
>>>>
>>>> And this patchset allows that to happen :)
>>
>> Thanks for testing the patch and providing feedback.
> 
> :)
> 
>>
>>>>
>>>> Actually, I spoke to Helen last year, and to enable it to run on the free
>>>> Gitlab-CI runners, there is a small extra patch which is needed:
>>>>
>>>> https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/
>>
>> Thanks for the patch.
> 
> Thank you for most of the work, it sure will be useful :)
> 
>>
>> We can keep the variable name as KCI_CI_TAGS (like other variables) and
>> add it in variables with default empty string.
> 
> Just tested, if it's an empty string, it will just be ignored, as it won't match
> anything (that is not an empty string)

Ack. Adding it to variables will allow us pass KCI_CI_TAGS when manually 
creating a pipeline without changing the CI/CD settings, but we can 
ignore this for now.

> 

>>
>>>
>>> Gitlab as an open-source software project (the community edition) is one
>>> thing, but can we please avoid advertising specific proprietary services
>>> in the kernel documentation ?
>>
>> Agree. We could remove the lines which mentions gitlab.com SaaS in
>> commit message and documentation.
> 
> Done :)
> Added a generic reason for needing better instance
> 
>>
>>>
>>>> Could you please apply it on top of your tree?
>>>> Some stuff changed places, but I can send a v2 with that fix if you want.
>>
>> I will test your patch and we can add this for v3.
> 
> Thanks!
> That's the v2 with the required changes:
> 
> https://lore.kernel.org/all/20250127185849.34131-1-leobras@redhat.com/T/#u
> 
> Please let me know if any further change is needed.


Thanks for the patch. We will pick this for v3.

Regards,
Vignesh

> 
> Thanks!
> Leo
> 
>>
>> Regards,
>> Vignesh
>>
>>>>
>>>>
>>>> While I have yet to review this v2 patchset, I applied it on my repo for
>>>> testing, and cherry-picked the patch on above link, triggering a Pipeline:
>>>>
>>>> https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600
>>>>
>>>> It seems to be working fine, please check it, as you may be more used to the
>>>> results.
>>>>
>>>> Thanks!
>>>> Leo
>>>
> 
