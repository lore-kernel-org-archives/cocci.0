Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC5C02191
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=scR7wZ6PH3tt5XOKfQ3Cdm69od12lGxB6h7Kol1IknI=;
  b=TX4laSfNdeRJ0eKMH0jV5+17+zF6AJ4TfxY0bFJaDz9+1dRrB2FhkH9T
   kdGyaHPtKYALdhf3AvhZ5gnyaJSfbqYjYaLzLGvs0V4kXtkX42dWE9xB7
   vs/6blU+jTyv7Ckl3tTaLYfPc/gJq2Ol1/RyCjccrBjjDHADiT8nLSBud
   c=;
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
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325509"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E8111E0D9E; Tue, 28 Jan 2025 10:13:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C03C9E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 08:32:35 +0100 (CET)
IronPort-SDR: 67973692_oBFp8CWmvYbuiD7JYjKEI+mTlFTFpM1hJuV4K7yFyaXSnpP
 rtWaJHxrvWHvelDyPHXBj4sxRrGgwGYGK30KvYw==
X-IPAS-Result: =?us-ascii?q?A0EaAABGNZdnhcNp+5RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVozBAtIBIRSg0+ETocygXQtA4Q7jQ+MToF+DwEDAQ00DQECB?=
 =?us-ascii?q?AEBAwEDggyCLkYCinUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAUBJhXsNgmIBM3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?ggFXgEBHQEBAQECASMPAQUIAQE3AQ8LGAICJgICVgYBCggCAQEQBoJoAYJBI?=
 =?us-ascii?q?wIBBQwGtVB6gTKBAYIMAQEGgQhQAw8v2gaBZAmBGi4BhWqCYwGFa4N9eicPg?=
 =?us-ascii?q?VVEgRUnglAzPoJhAQKFOoJpgjNLgScCgVZeJWeGZoQsgTt0O4ElgW2EZ4phU?=
 =?us-ascii?q?nscA1ksAVUTFwsHBYEpSAMrNjEjgSYFNQo3OoINaUk3Ag0CNYIefIIrawQFg?=
 =?us-ascii?q?S2CO4RFhFGFXoIUgWUDAxYSAYI1cnkegU0dQAIBC209NwkLGwY9nS89gw0RL?=
 =?us-ascii?q?TUBPCQtARMIDgJQISBsFh8FBjqSQBSDO4xegh2LdZRdNAeEHoFdBgyKKZUzB?=
 =?us-ascii?q?hMvhASBV4svhk6Se5h8IoI2iFpZgXmVUAuFHTGBZzqBKx4MBzMaI4MDAQEyC?=
 =?us-ascii?q?Qo8AxkPjiEZH4NChRPCSDs1AgEBOAIHAQoBAQMJhUYBAYojLQWBSwEB?=
IronPort-PHdr: A9a23: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
 t0qNUGTUhJ3pIY=
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:cr393qCQtOkd4dTlHemV55DYdb4zR+YMi2TDGXoBKiC9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuex/hHPJOkO0s1PKZLW7bUQiTQ72Kj7GO/9SIIUSXnNK1l5
 0QEZSWY+eQMbEVt6bHCUWDfeod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3A9dHDxmjBqOwDibAOQO9my+072zJuQ3r6zkrAf3G?=
 =?us-ascii?q?CM0lQFJjJcVKL9YhbjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADVc/cQ9cBxaOPBijPcJBVbaQf9lZ44SrU3Ezqs4?=
 =?us-ascii?q?bsOmEOBUzAyyjzw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,237,1732575600"; 
   d="scan'208";a="107404589"
X-MGA-submission: =?us-ascii?q?MDGF06onPgobkjItkW++hwvUgcCfBdatE4ZXKd?=
 =?us-ascii?q?vcOYIUpVXZisdyMDqyHVfTnd/gt5NBlOjyqD8Uj2spyUKcldCraV8d8G?=
 =?us-ascii?q?E6E1x3gAFC7g1xEYRNjHcRhVuJnSqgyGUr1rxdFL8QWoUis7r7uRUezv?=
 =?us-ascii?q?IM+8b85dfioqVAvsaqmoofFQ=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:32:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737963152;
	bh=M1cz7Y5PlpaPiS3GVZ5e1VvQ0cfkEQKhqX+UMFLSc5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9ZiqL/RLEj0JWkSk/0Nz+G8iHnq2hPL6WeF2ZZ7phJdtKUqclJ9Jm5X8V722qIB6
	 0vJIUh1ZGVxs6yv6jPp48sMEVrs4QCbcp7O2qpeeWsFoftqTp6m8UJo4LUWi2vbTBW
	 adu6Mf4p3SYYgqXXGC/ZLivbwIyeqGQ1XXN9fllxAe/iPd3sUOIKfI7fI54feYShan
	 kJi6RpNePbQAXvFSoIHZpILsXqUxmdmSIRWLDMy/f1cO6Bd2OljUEPhsJNUFasC/td
	 XSlJ8IQ+vSPOPREmyUntBUG22r/UcvbUdbxyRFBjD2tjX1KaIGd6E6HqLdoLmRiO5j
	 ZvtnxD6aellvw==
Received: from [192.168.50.250] (unknown [171.76.81.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 693ED17E0E8D;
	Mon, 27 Jan 2025 08:32:24 +0100 (CET)
Message-ID: <6ebd1551-017f-4b31-b235-829b2735d78f@collabora.com>
Date: Mon, 27 Jan 2025 13:02:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
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
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20250124081250.GA24731@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2268
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/6ebd1551-017f-4b31-b235-829b2735d78f%40collabora.com>

Hi Leo,

On 24/01/25 13:42, Laurent Pinchart wrote:
> On Fri, Jan 24, 2025 at 02:11:26AM -0300, Leonardo Brás wrote:
>> On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
>>> This patch series introduces "kci-gitlab," a GitLab CI pipeline
>>> specifically designed for kernel testing. It provides kernel
>>> developers with an integrated, efficient, and flexible testing
>>> framework using GitLab's CI/CD capabilities. This patch includes
>>> a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
>>> additional YAML and script files, to define a basic test pipeline
>>> triggered by code pushes to a GitLab-CI instance.
>>> The initial version implements:
>>>      
>>> - Static checks: Includes checkpatch and smatch for code validation.
>>> - Build tests: Covers various architectures and configurations.
>>> - Boot tests: Utilizes virtme for basic boot testing.
>>>
>>> Additionally, it introduces a flexible "scenarios" mechanism to
>>> support subsystem-specific extensions.
>>>
>>> This series also introduces a drm scenario that adds a job to run IGT
>>> tests for vkms. This scenario includes helper scripts to build deqp-runner
>>> and IGT, leveraging approaches from the drm-ci/mesa-ci project.
>>>
>>> We are working towards creating a generic, upstream GitLab-CI pipeline
>>> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
>>> is designed with a distributed infrastructure model, making it possible
>>> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
>>> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
>>> integration.
>>>
>>> For an example of a fully executed pipeline with drm scenario set,
>>> including documentation generation,
>>> see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/1350262
>>>
>>> Please refer to the documentation included in the patch, or check the
>>> rendered version, here:
>>> https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
>>>
>>> Differences from v1 to v2:
>>> - moved to tools/ci as suggested by Linus on the previous version
>>> - add arm64 containers for native compilation
>>> - added boot tests using virtme: this is the base structure for boot tests,
>>>    next steps would be adding other tests such as kselftests/kunit tests
>>> - added DRM scenario testing on vkms: this should replace current vkms test
>>>    in drm-ci. This work shows how a test scenario can be used by different
>>>    subsystems to add their tests.
>>> - update documentation
>>>
>>> For more details on the motivation behind this work, please refer to the
>>> cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/
>>>
>>> [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/
>>> [2] https://kernelci.org/
>>> [3] https://docs.kernelci.org/kcidb/
>>>
>>> Helen Koike (3):
>>>    kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
>>>    kci-gitlab: Add documentation
>>>    kci-gitlab: docs: Add images
>>>
>>> Vignesh Raman (2):
>>>    MAINTAINERS: Add an entry for ci automated testing
>>>    kci-gitlab: Add drm scenario
>>
>> Hi Vignesh Raman,
>> I am very happy to see this project going forward :)
>>
>> It's been a few years since I first thought on finding a good way of helping
>> kernel developers testing their patches, while making use of the free runner
>> minutes Gitlab offers. It can greatly simplify the testing for people who are
>> new to kernel development, or students trying to understand it better.
>>
>> And this patchset allows that to happen :)

Thanks for testing the patch and providing feedback.

>>
>> Actually, I spoke to Helen last year, and to enable it to run on the free
>> Gitlab-CI runners, there is a small extra patch which is needed:
>>
>> https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/

Thanks for the patch.

We can keep the variable name as KCI_CI_TAGS (like other variables) and 
add it in variables with default empty string.

> 
> Gitlab as an open-source software project (the community edition) is one
> thing, but can we please avoid advertising specific proprietary services
> in the kernel documentation ?

Agree. We could remove the lines which mentions gitlab.com SaaS in
commit message and documentation.

> 
>> Could you please apply it on top of your tree?
>> Some stuff changed places, but I can send a v2 with that fix if you want.

I will test your patch and we can add this for v3.

Regards,
Vignesh

>>
>>
>> While I have yet to review this v2 patchset, I applied it on my repo for
>> testing, and cherry-picked the patch on above link, triggering a Pipeline:
>>
>> https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600
>>
>> It seems to be working fine, please check it, as you may be more used to the
>> results.
>>
>> Thanks!
>> Leo
> 
